package com.liberastartes.seed;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Comparator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.stereotype.Component;
import org.springframework.util.StreamUtils;

/**
 * Loads the Cypher seed files on startup, but only when the database is empty.
 * Files under {@code classpath:/seed/} are executed in filename order
 * (01-constraints, 02-nodes, 03-rels), each split into individual statements.
 */
@Component
public class SeedRunner implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(SeedRunner.class);

    private final Neo4jClient neo4jClient;
    private final boolean seedEnabled;

    public SeedRunner(Neo4jClient neo4jClient,
                      @Value("${liberastartes.seed.enabled:true}") boolean seedEnabled) {
        this.neo4jClient = neo4jClient;
        this.seedEnabled = seedEnabled;
    }

    @Override
    public void run(String... args) throws Exception {
        if (!seedEnabled) {
            log.info("Seed loading disabled (liberastartes.seed.enabled=false).");
            return;
        }
        long nodeCount = neo4jClient.query("MATCH (n) RETURN count(n) AS c")
                .fetchAs(Long.class)
                .mappedBy((ts, rec) -> rec.get("c").asLong())
                .one()
                .orElse(0L);
        if (nodeCount > 0) {
            log.info("Database already contains {} nodes; skipping seed.", nodeCount);
            return;
        }
        log.info("Empty database detected; loading seed files...");
        for (Resource resource : seedResources()) {
            String script = readResource(resource);
            List<String> statements = CypherScript.split(script);
            log.info("Seed {}: {} statements", resource.getFilename(), statements.size());
            for (String statement : statements) {
                neo4jClient.query(statement).run();
            }
        }
        log.info("Seed complete.");
    }

    private Resource[] seedResources() throws IOException {
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Resource[] resources = resolver.getResources("classpath*:/seed/*.cypher");
        // Deterministic filename order (01-, 02-, 03-).
        java.util.Arrays.sort(resources, Comparator.comparing(r -> {
            String name = r.getFilename();
            return name == null ? "" : name;
        }));
        return resources;
    }

    private String readResource(Resource resource) throws IOException {
        try (var in = resource.getInputStream()) {
            return StreamUtils.copyToString(in, StandardCharsets.UTF_8);
        }
    }
}
