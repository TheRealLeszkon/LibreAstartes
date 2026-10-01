package com.liberastartes.graph;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.stereotype.Service;

import com.liberastartes.common.CyElement;
import com.liberastartes.common.GraphFilters;
import com.liberastartes.common.GraphResponse;

/**
 * Builds filtered, Cytoscape-ready graphs with hand-written Cypher. All
 * filtering happens here on the server; parameters are always bound, never
 * concatenated into the query string.
 */
@Service
public class GraphService {

    private final Neo4jClient neo4j;

    public GraphService(Neo4jClient neo4j) {
        this.neo4j = neo4j;
    }

    // Map projection for a node's Cytoscape `data`. Legion colours are resolved
    // for member characters via a pattern comprehension (first legion found).
    private static final String NODE_DATA = """
            {
              id: n.id,
              type: type,
              name: n.name,
              subtitle: n.subtitle,
              numeral: n.numeral,
              expunged: n.expunged,
              color: n.color,
              kind: n.kind,
              image: n.image,
              order: n.order,
              era: n.era,
              location: n.location,
              legionId: coalesce(
                  [(n)-[:PRIMARCH_OF|MEMBER_OF]->(lg:Legion) | lg.id][0],
                  CASE WHEN n:Legion THEN n.id END),
              primaryColor: coalesce(
                  [(n)-[:PRIMARCH_OF|MEMBER_OF]->(lg:Legion) | lg.primaryColor][0],
                  n.primaryColor),
              secondaryColor: coalesce(
                  [(n)-[:PRIMARCH_OF|MEMBER_OF]->(lg:Legion) | lg.secondaryColor][0],
                  n.secondaryColor)
            }
            """;

    // Standard optional filters, shared by the full graph and the legion subgraph.
    private static final String FILTER_WHERE = """
            (type IN $types)
            AND ($q IS NULL OR toLower(n.name) CONTAINS toLower($q))
            AND ($allegiance IS NULL OR EXISTS { (n)-[:SIDED_WITH]->(:Allegiance {id: $allegiance}) })
            AND ($legions IS NULL OR n.id IN $legions
                 OR EXISTS { MATCH (n)-[:MEMBER_OF|PRIMARCH_OF]->(l:Legion) WHERE l.id IN $legions })
            AND ($gods IS NULL OR n.id IN $gods
                 OR EXISTS { MATCH (n)-[:DEVOTED_TO]->(g:ChaosGod) WHERE g.id IN $gods })
            AND ($events IS NULL OR n.id IN $events
                 OR EXISTS { MATCH (n)-[:PARTICIPATED_IN|FOUGHT_IN]->(e:Event) WHERE e.id IN $events })
            """;

    // Legion subgraph scope: the legion, the Emperor, the legion's primarch and
    // members, the events they fought in, the chaos powers they are devoted to,
    // and the allegiance they swore.
    private static final String LEGION_SCOPE = """
            (
              n.id = $legionId
              OR n:Emperor
              OR EXISTS { (n)-[:MEMBER_OF|PRIMARCH_OF]->(:Legion {id: $legionId}) }
              OR EXISTS { (:Legion {id: $legionId})-[:FOUGHT_IN]->(n:Event) }
              OR EXISTS { (c)-[:MEMBER_OF|PRIMARCH_OF]->(:Legion {id: $legionId})
                          WHERE (c)-[:PARTICIPATED_IN]->(n) AND n:Event }
              OR EXISTS { (:Legion {id: $legionId})-[:DEVOTED_TO]->(n:ChaosGod) }
              OR EXISTS { (c)-[:MEMBER_OF|PRIMARCH_OF]->(:Legion {id: $legionId})
                          WHERE (c)-[:DEVOTED_TO]->(n) AND n:ChaosGod }
              OR EXISTS { (:Legion {id: $legionId})-[:SIDED_WITH]->(n:Allegiance) }
            )
            """;

    private static final String EDGE_QUERY = """
            MATCH (a)-[r]->(b)
            WHERE a.id IN $ids AND b.id IN $ids
            RETURN DISTINCT {
              id: a.id + '__' + type(r) + '__' + b.id,
              source: a.id,
              target: b.id,
              type: type(r),
              role: r.role,
              side: r.side,
              presence: r.presence,
              degree: r.degree,
              event: r.event
            } AS data
            """;

    public GraphResponse graph(GraphFilters filters) {
        String nodeQuery = "MATCH (n) WITH n, " + typeExpr() + " AS type WHERE "
                + FILTER_WHERE + " RETURN DISTINCT " + NODE_DATA + " AS data";
        return build(nodeQuery, filters.toParams());
    }

    public GraphResponse legionGraph(String legionId, GraphFilters filters) {
        Map<String, Object> params = filters.toParams();
        params.put("legionId", legionId);
        String nodeQuery = "MATCH (n) WITH n, " + typeExpr() + " AS type WHERE "
                + LEGION_SCOPE + " AND " + FILTER_WHERE
                + " RETURN DISTINCT " + NODE_DATA + " AS data";
        return build(nodeQuery, params);
    }

    /** Node plus its neighbourhood out to {@code depth} (clamped to 1..2), as a graph. */
    public GraphResponse neighbours(String id, int depth) {
        int d = Math.max(1, Math.min(depth, 2));
        String idQuery = "MATCH (n {id: $id}) OPTIONAL MATCH (n)-[*1.." + d + "]-(m) "
                + "RETURN [x IN (collect(DISTINCT n.id) + collect(DISTINCT m.id)) WHERE x IS NOT NULL] AS ids";
        @SuppressWarnings("unchecked")
        List<String> ids = (List<String>) neo4j.query(idQuery)
                .bind(id).to("id")
                .fetch().one()
                .map(row -> row.get("ids"))
                .orElse(List.of());
        return subgraph(ids);
    }

    /** Build a graph from an explicit set of node ids (nodes + the edges among them). */
    public GraphResponse subgraph(List<String> ids) {
        String nodeQuery = "MATCH (n) WHERE n.id IN $ids WITH n, " + typeExpr()
                + " AS type RETURN DISTINCT " + NODE_DATA + " AS data";
        return build(nodeQuery, Map.of("ids", ids));
    }

    private static String typeExpr() {
        return "head([l IN labels(n) WHERE l <> 'Character'])";
    }

    @SuppressWarnings("unchecked")
    private GraphResponse build(String nodeQuery, Map<String, Object> params) {
        Collection<Map<String, Object>> nodeRows = neo4j.query(nodeQuery)
                .bindAll(params).fetch().all();
        List<CyElement> nodes = new ArrayList<>();
        List<String> ids = new ArrayList<>();
        for (Map<String, Object> row : nodeRows) {
            Map<String, Object> data = (Map<String, Object>) row.get("data");
            nodes.add(new CyElement(data));
            ids.add((String) data.get("id"));
        }
        Collection<Map<String, Object>> edgeRows = neo4j.query(EDGE_QUERY)
                .bind(ids).to("ids").fetch().all();
        List<CyElement> edges = new ArrayList<>();
        for (Map<String, Object> row : edgeRows) {
            edges.add(new CyElement((Map<String, Object>) row.get("data")));
        }
        return new GraphResponse(nodes, edges);
    }
}
