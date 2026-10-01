package com.liberastartes;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.assertj.core.api.Assertions.catchThrowableOfType;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.data.neo4j.test.autoconfigure.DataNeo4jTest;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import org.testcontainers.containers.Neo4jContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.liberastartes.character.CharacterRepository;
import com.liberastartes.character.CharacterRequest;
import com.liberastartes.character.CharacterService;
import com.liberastartes.node.NodeDetails;
import com.liberastartes.node.NodeService;
import com.liberastartes.seed.CypherScript;

@DataNeo4jTest
@Testcontainers
class CharacterCrudTests {

    @Container
    @ServiceConnection
    static Neo4jContainer<?> neo4j = new Neo4jContainer<>("neo4j:5-community");

    @Autowired
    Neo4jClient client;
    @Autowired
    Driver driver;
    @Autowired
    CharacterRepository repository;

    CharacterService service;

    @BeforeEach
    void setUp() throws Exception {
        service = new CharacterService(repository, client, new NodeService(client));
        try (Session session = driver.session()) {
            long count = session.run("MATCH (n) RETURN count(n) AS c").single().get("c").asLong();
            if (count == 0) {
                for (String file : List.of("seed/01-constraints.cypher", "seed/02-nodes.cypher",
                        "seed/03-rels.cypher", "seed/04-expansion.cypher")) {
                    String script = new String(new ClassPathResource(file).getInputStream().readAllBytes(), StandardCharsets.UTF_8);
                    for (String stmt : CypherScript.split(script)) {
                        session.run(stmt).consume();
                    }
                }
            }
            // Remove any leftover test node between methods.
            session.run("MATCH (c:Character {id: 'test-legionary'}) DETACH DELETE c").consume();
        }
    }

    private CharacterRequest req(String type) {
        return new CharacterRequest(null, "Test Legionary", type, "Battle-Brother",
                "A seeded test marine.", null, null, null, null, "sons-of-horus", "Tester");
    }

    @Test
    void createPersistsCharacterWithSubtypeLabelAndMembership() {
        NodeDetails d = service.create(req("Astartes"));
        assertThat(d.node().get("id")).isEqualTo("test-legionary");
        assertThat(d.node().get("type")).isEqualTo("Astartes");
        assertThat(d.legion()).isNotNull();
        assertThat(d.legion().get("name")).isEqualTo("Sons of Horus");

        boolean labelled = client.query(
                "MATCH (c:Character:Astartes {id: 'test-legionary'}) RETURN count(c) AS c")
                .fetchAs(Long.class).mappedBy((ts, rec) -> rec.get("c").asLong()).one().orElse(0L) == 1L;
        assertThat(labelled).isTrue();
    }

    @Test
    void createRejectsUnknownType() {
        ResponseStatusException ex = catchThrowableOfType(ResponseStatusException.class, () -> service.create(req("Wizard")));
        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
    }

    @Test
    void createRejectsDuplicateId() {
        service.create(req("Astartes"));
        ResponseStatusException ex = catchThrowableOfType(ResponseStatusException.class, () -> service.create(req("Astartes")));
        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
    }

    @Test
    void updateChangesProperties() {
        service.create(req("Astartes"));
        NodeDetails updated = service.update("test-legionary",
                new CharacterRequest("test-legionary", "Test Legionary", "Astartes", "Veteran Sergeant",
                        "Now promoted.", "To endure.", null, null, null, null, null));
        assertThat(updated.node().get("subtitle")).isEqualTo("Veteran Sergeant");
        assertThat(updated.node().get("description")).isEqualTo("Now promoted.");
    }

    @Test
    void updateMissingIs404() {
        assertThatThrownBy(() -> service.update("no-such-id",
                new CharacterRequest("no-such-id", "Ghost", "Astartes", null, null, null, null, null, null, null, null)))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    void deleteRemovesCharacter() {
        service.create(req("Astartes"));
        service.delete("test-legionary");
        assertThat(repository.existsById("test-legionary")).isFalse();
    }

    @Test
    void deleteMissingIs404() {
        ResponseStatusException ex = catchThrowableOfType(ResponseStatusException.class, () -> service.delete("no-such-id"));
        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }
}
