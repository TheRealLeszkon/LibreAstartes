# Backend (Spring Boot + Spring Data Neo4j)

- Packages: `config`, `seed`, `graph` (filtered graph queries), `node` (details/neighbours), `character` (CRUD), `common`, `meta` (filter option lists).
- Use `Neo4jClient` with hand-written Cypher for graph and filter endpoints. Use `Neo4jRepository` entities only for CRUD.
- Keep entities shallow: don't map relationships on entities unless CRUD needs them, so one save doesn't rewrite half the graph.
- Seed: `src/main/resources/seed/*.cypher`, loaded in filename order (`01-constraints`, `02-nodes`, `03-rels`) only when the DB is empty. Cypher strings use backslash escaping (`\'`); `SeedRunner`/`CypherScript` split statements quote-aware.
- Optional filters: build Cypher with `WHERE ($legions IS NULL OR l.id IN $legions)`-style clauses, not dynamic strings. The one safe interpolation is a whitelisted subtype label in `CharacterService`.
- Return DTO records, never entities. Map with map projections: `n {.*, type: head([l IN labels(n) WHERE l <> 'Character'])}`.
- Tests: `@DataNeo4jTest` with Testcontainers Neo4j. Seed via the raw `Driver` (schema changes and writes can't share one transaction). At minimum test the filters, the legion subgraph, and character CRUD.
- CORS is not needed in dev (the Vite proxy handles `/api`).
