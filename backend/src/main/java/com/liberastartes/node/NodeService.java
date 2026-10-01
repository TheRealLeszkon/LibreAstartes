package com.liberastartes.node;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class NodeService {

    private final Neo4jClient neo4j;

    public NodeService(Neo4jClient neo4j) {
        this.neo4j = neo4j;
    }

    // Groups every relationship of a node using pattern comprehensions, which
    // keep each group independent and avoid cartesian products.
    private static final String DETAILS_QUERY = """
            MATCH (n {id: $id})
            RETURN
              n {.*, type: head([l IN labels(n) WHERE l <> 'Character'])} AS node,
              [(n)-[:PRIMARCH_OF|MEMBER_OF]->(lg:Legion)
                 | lg {.id, .name, .numeral, .primaryColor, .secondaryColor}][0] AS legion,
              [(n)-[:SIDED_WITH]->(a:Allegiance) | a {.id, .name, type: 'Allegiance'}] AS allegiance,
              [(n)-[r:DEVOTED_TO]->(g:ChaosGod)
                 | g {.id, .name, type: 'ChaosGod', degree: r.degree}] AS devotion,
              [(n)-[r:PARTICIPATED_IN]->(e:Event)
                 | e {.id, .name, type: 'Event', order: e.order, side: r.side, role: r.role}]
                + [(n)-[r:FOUGHT_IN]->(e:Event)
                 | e {.id, .name, type: 'Event', order: e.order, side: r.side}] AS events,
              [(n)-[r:KILLED]->(v)
                 | v {.id, .name, type: head([l IN labels(v) WHERE l <> 'Character']), event: r.event}] AS kills,
              [(k)-[r:KILLED]->(n)
                 | k {.id, .name, type: head([l IN labels(k) WHERE l <> 'Character']), event: r.event}] AS deaths,
              [(m)-[r:MEMBER_OF]->(n)
                 | m {.id, .name, type: head([l IN labels(m) WHERE l <> 'Character']), role: r.role}] AS members,
              [(p:Primarch)-[:PRIMARCH_OF]->(n) | p {.id, .name, type: 'Primarch'}] AS primarch,
              [(n)-[:RIVAL_OF]-(c)
                 | c {.id, .name, type: head([l IN labels(c) WHERE l <> 'Character']), relation: 'RIVAL_OF'}]
                + [(n)-[:ALLY_OF]-(c)
                 | c {.id, .name, type: head([l IN labels(c) WHERE l <> 'Character']), relation: 'ALLY_OF'}]
                + [(n)-[:MENTOR_OF]->(c)
                 | c {.id, .name, type: head([l IN labels(c) WHERE l <> 'Character']), relation: 'MENTOR_OF'}]
                + [(c)-[:MENTOR_OF]->(n)
                 | c {.id, .name, type: head([l IN labels(c) WHERE l <> 'Character']), relation: 'MENTORED_BY'}]
                AS connections
            """;

    @SuppressWarnings("unchecked")
    public NodeDetails details(String id) {
        Map<String, Object> row = neo4j.query(DETAILS_QUERY)
                .bind(id).to("id")
                .fetch().one()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No node with id " + id));

        List<Map<String, Object>> events =
                new java.util.ArrayList<>((List<Map<String, Object>>) row.get("events"));
        events.sort(Comparator.comparing(e -> asLong(e.get("order"))));

        return new NodeDetails(
                (Map<String, Object>) row.get("node"),
                (Map<String, Object>) row.get("legion"),
                (List<Map<String, Object>>) row.get("allegiance"),
                (List<Map<String, Object>>) row.get("devotion"),
                events,
                (List<Map<String, Object>>) row.get("kills"),
                (List<Map<String, Object>>) row.get("deaths"),
                (List<Map<String, Object>>) row.get("members"),
                (List<Map<String, Object>>) row.get("primarch"),
                (List<Map<String, Object>>) row.get("connections"));
    }

    private static long asLong(Object o) {
        return (o instanceof Number num) ? num.longValue() : Long.MAX_VALUE;
    }
}
