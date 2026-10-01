package com.liberastartes;

import static org.assertj.core.api.Assertions.assertThat;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.data.neo4j.test.autoconfigure.DataNeo4jTest;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.neo4j.core.Neo4jClient;
import org.testcontainers.containers.Neo4jContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.liberastartes.common.GraphFilters;
import com.liberastartes.common.GraphResponse;
import com.liberastartes.graph.GraphService;
import com.liberastartes.node.NodeDetails;
import com.liberastartes.node.NodeService;
import com.liberastartes.seed.CypherScript;

/**
 * Exercises the Cypher graph/filter queries against a real Neo4j via Testcontainers.
 * The seed is loaded manually (the SeedRunner only loads into an empty database).
 */
@DataNeo4jTest
@Testcontainers
class GraphQueryTests {

    @Container
    @ServiceConnection
    static Neo4jContainer<?> neo4j = new Neo4jContainer<>("neo4j:5-community");

    @Autowired
    Neo4jClient client;

    @Autowired
    Driver driver;

    GraphService graphService;
    NodeService nodeService;

    @BeforeEach
    void setUp() throws Exception {
        graphService = new GraphService(client);
        nodeService = new NodeService(client);
        seedIfEmpty();
    }

    /**
     * Seeds via the raw driver (each statement its own auto-commit transaction),
     * bypassing the slice's managed transaction — Neo4j forbids mixing schema
     * changes and writes within a single transaction. Idempotent across methods.
     */
    private void seedIfEmpty() throws Exception {
        try (Session session = driver.session()) {
            long count = session.run("MATCH (n) RETURN count(n) AS c").single().get("c").asLong();
            if (count > 0) {
                return;
            }
            for (String file : List.of("seed/01-constraints.cypher", "seed/02-nodes.cypher",
                    "seed/03-rels.cypher", "seed/04-expansion.cypher",
                    "seed/05-cast.cypher", "seed/06-participation.cypher")) {
                String script = new String(new ClassPathResource(file).getInputStream().readAllBytes(),
                        StandardCharsets.UTF_8);
                for (String statement : CypherScript.split(script)) {
                    session.run(statement).consume();
                }
            }
        }
    }

    private static GraphFilters filters(List<String> types, String allegiance,
                                        List<String> legions, String q) {
        return new GraphFilters(types, allegiance, legions, null, null, q);
    }

    private static Set<String> types(GraphResponse g) {
        return g.nodes().stream().map(n -> (String) n.data().get("type")).collect(Collectors.toSet());
    }

    private static List<String> ids(GraphResponse g) {
        return g.nodes().stream().map(n -> (String) n.data().get("id")).toList();
    }

    @Test
    void seedLoadsExpectedCounts() {
        // 18 original primarchs + Omegon, the Alpha Legion's hidden twin.
        assertThat(count("MATCH (p:Primarch)-[:SON_OF]->(:Emperor) RETURN count(p) AS c")).isEqualTo(19);
        assertThat(count("MATCH (l:Legion) RETURN count(l) AS c")).isEqualTo(20);
        assertThat(count("MATCH (n) RETURN count(n) AS c")).isEqualTo(215);
        // Every Primarch commands exactly one Legion (both Alpha Legion twins included).
        assertThat(count("""
                MATCH (p:Primarch) OPTIONAL MATCH (p)-[r:PRIMARCH_OF]->()
                WITH p, count(r) AS c WHERE c <> 1 RETURN count(p) AS c
                """)).isZero();
        // The only standalone nodes are the two Expunged Legions.
        assertThat(count("MATCH (n) WHERE NOT (n)--() RETURN count(n) AS c")).isEqualTo(2);
        // The expanded cast introduced the new subtype labels.
        assertThat(count("MATCH (n:Custodes) RETURN count(n) AS c")).isEqualTo(5);
        assertThat(count("MATCH (n:Daemon) RETURN count(n) AS c")).isEqualTo(5);
    }

    @Test
    void defaultGraphExcludesAllegianceNodes() {
        GraphResponse g = graphService.graph(filters(null, null, null, null));
        // Every node except the two Allegiance hubs.
        assertThat(g.nodes()).hasSize(213);
        assertThat(types(g)).doesNotContain("Allegiance");
        assertThat(types(g)).contains("Custodes", "Daemon", "Imperialis", "Mechanicum", "SistersOfSilence");
        assertThat(g.edges()).isNotEmpty();
    }

    @Test
    void filterByTypeReturnsOnlyThatType() {
        GraphResponse g = graphService.graph(filters(List.of("Legion"), null, null, null));
        assertThat(g.nodes()).hasSize(20);
        assertThat(types(g)).containsExactly("Legion");
    }

    @Test
    void filterByAllegianceTraitorReturnsTraitorsOnly() {
        GraphResponse g = graphService.graph(filters(null, "traitor", null, null));
        List<String> tids = ids(g);
        // Includes traitor primarchs, legions, astartes and warp-aligned daemons…
        assertThat(tids).contains("horus-lupercal", "sons-of-horus", "kabandha");
        // …and never a loyalist or the neutral allegiance hubs.
        assertThat(tids).doesNotContain("rogal-dorn", "the-emperor", "ultramarines", "loyalist");
    }

    @Test
    void dossierCorrectionsAndPresenceApplied() {
        // §15: Guilliman commanded the Ullanor *Crusade* but did not attend the Triumph.
        assertThat(count("""
                MATCH (:Character {id: 'roboute-guilliman'})-[:PARTICIPATED_IN]->(:Event {id: 'triumph-at-ullanor'})
                RETURN count(*) AS c
                """)).isZero();
        // §15: Dorn ordered the Retribution Fleet but was not physically at Phall.
        NodeDetails dorn = nodeService.details("rogal-dorn");
        Object phallPresence = dorn.events().stream()
                .filter(e -> "battle-of-phall".equals(e.get("id")))
                .findFirst().orElseThrow().get("presence");
        assertThat(phallPresence).isEqualTo("strategic");
    }

    @Test
    void siegeOfTerraHasPhaseChildren() {
        assertThat(count("""
                MATCH (p:Event)-[:PART_OF]->(:Event {id: 'siege-of-terra'}) RETURN count(p) AS c
                """)).isEqualTo(6);
    }

    @Test
    void newNodeTypesResolveFromLabels() {
        assertThat(nodeService.details("constantin-valdor").node().get("type")).isEqualTo("Custodes");
        assertThat(nodeService.details("kabandha").node().get("type")).isEqualTo("Daemon");
        assertThat(nodeService.details("malcador").node().get("type")).isEqualTo("Imperialis");
        assertThat(nodeService.details("jenetia-krole").node().get("type")).isEqualTo("SistersOfSilence");
    }

    @Test
    void filterByLegionReturnsLegionNeighbourhood() {
        GraphResponse g = graphService.graph(filters(null, null, List.of("sons-of-horus"), null));
        assertThat(ids(g)).contains("horus-lupercal", "sons-of-horus", "garviel-loken");
    }

    @Test
    void searchMatchesNameSubstringCaseInsensitively() {
        GraphResponse g = graphService.graph(filters(null, null, null, "HORUS"));
        assertThat(ids(g)).contains("horus-lupercal", "horus-aximand", "sons-of-horus");
    }

    @Test
    void legionSubgraphIncludesEmperorPrimarchAndMembers() {
        GraphResponse g = graphService.legionGraph("sons-of-horus",
                new GraphFilters(null, null, null, null, null, null));
        assertThat(ids(g)).contains("the-emperor", "horus-lupercal", "sons-of-horus", "garviel-loken");
        assertThat(types(g)).contains("Emperor", "Primarch", "Astartes", "Event");
    }

    @Test
    void nodeDetailsGroupsRelationshipsAndSortsEventsByOrder() {
        NodeDetails d = nodeService.details("horus-lupercal");
        assertThat(d.node().get("type")).isEqualTo("Primarch");
        assertThat(d.legion().get("name")).isEqualTo("Sons of Horus");
        assertThat(d.allegiance()).extracting(m -> m.get("name")).containsExactly("Traitor");
        assertThat(d.kills()).extracting(m -> m.get("name")).containsExactly("Sanguinius");
        List<Long> orders = d.events().stream().map(e -> ((Number) e.get("order")).longValue()).toList();
        assertThat(orders).isSorted();
    }

    private long count(String cypher) {
        return client.query(cypher).fetchAs(Long.class)
                .mappedBy((ts, rec) -> rec.get("c").asLong()).one().orElse(0L);
    }
}
