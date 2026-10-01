# Liber Astartes — a Horus Heresy lore graph explorer

An interactive, filterable graph of the Horus Heresy era of Warhammer 40,000, built on Neo4j
as a learning project. A React + Cytoscape.js front end explores a graph of characters, legions,
events and the powers of Chaos, served by a Spring Boot API over a Neo4j graph database.

> All lore text is original high-level summary. No Games Workshop artwork, logos, iconography or
> fonts are bundled; only user-supplied images placed in `frontend/public/assets/` are used, and
> all ornaments are original CSS/SVG.

## Stack

| Layer    | Choice                                                                 |
|----------|-----------------------------------------------------------------------|
| Database | Neo4j Community (Docker), browser on `7474`, Bolt on `7687`            |
| Backend  | Java 21, Spring Boot 4, Spring Data Neo4j + `Neo4jClient` (hand Cypher)|
| Frontend | React + TypeScript + Vite, Cytoscape.js (`react-cytoscapejs`, fcose)   |

## Setup

```bash
# 1. Database
docker compose up -d                 # Neo4j on 7474 (browser) / 7687 (bolt), user neo4j / password123
#    reset everything:  docker compose down -v && docker compose up -d

# 2. Backend  (seeds the DB automatically on first run, only when it is empty)
cd backend && ./mvnw spring-boot:run # http://localhost:8080

# 3. Frontend
cd frontend && npm install && npm run dev   # http://localhost:5173  (proxies /api -> :8080)
```

The backend connects using the env vars `NEO4J_URI` / `NEO4J_USER` / `NEO4J_PASSWORD`
(defaults `bolt://localhost:7687`, `neo4j`, `password123`).

## Data model

Characters carry two labels (`Character` + a subtype). Every node has a unique slug `id`;
Neo4j internal ids are never exposed.

```
(:Character:Emperor) (:Character:Primarch) (:Character:Astartes) (:Character:Dreadnought)
(:Legion) (:ChaosGod) (:Event) (:Allegiance)
```

Relationships:

```
(:Primarch)-[:SON_OF]->(:Emperor)
(:Primarch)-[:PRIMARCH_OF]->(:Legion)
(:Astartes|Dreadnought)-[:MEMBER_OF {role}]->(:Legion)
(:Character|Legion)-[:SIDED_WITH]->(:Allegiance)          // per character too
(:Character|Legion)-[:DEVOTED_TO {degree}]->(:ChaosGod)   // "sworn" | "influenced"
(:Character)-[:PARTICIPATED_IN {side, role}]->(:Event)
(:Legion)-[:FOUGHT_IN {side}]->(:Event)
(:Character)-[:KILLED {event}]->(:Character)
(:Character)-[:RIVAL_OF|ALLY_OF|MENTOR_OF]->(:Character)
(:Event)-[:PART_OF]->(:Event)
```

Legions II and XI are "Records Expunged" nodes (`expunged: true`) with no Primarch — deliberately
standalone, reflecting the two lost Legions struck from Imperial record.

### Seeding

Idempotent Cypher seed files in `backend/src/main/resources/seed/` are loaded in filename order
by `SeedRunner`, but only when the database is empty:

- `01-constraints.cypher` — uniqueness constraint on `id` per label
- `02-nodes.cypher` — `MERGE` each node on `id`, then `SET` properties
- `03-rels.cypher` — match endpoints by `id`, then `MERGE` each relationship

Current seed: 87 nodes (1 Emperor, 18 Primarchs, 20 Legions, 25 Astartes, 3 Dreadnoughts,
5 Chaos powers, 13 Events, 2 Allegiances) and 250 relationships.

## API

All read endpoints return JSON. Graph endpoints return **Cytoscape-ready elements**
(`{ "data": { ... } }` per node/edge); all filtering happens in Cypher on the server, using
bound parameters. Node `data` carries `id, type, name, subtitle` plus style fields
(`legionId, primaryColor, secondaryColor, numeral, expunged, color, kind, image, order`).

| Endpoint | Purpose |
|---|---|
| `GET /api/graph?types=&allegiance=&legions=&gods=&events=&q=` | Filtered graph |
| `GET /api/graph/legion/{legionId}?…same filters` | Legion subgraph (Primarch, members, dreadnoughts, events, chaos powers, allegiance, + the Emperor) |
| `GET /api/nodes/{id}` | Full details + relationships grouped (allegiance, devotion, events, kills, deaths, members, primarch, connections) |
| `GET /api/nodes/{id}/neighbours?depth=1` | Neighbourhood (depth 1–2) as a graph |
| `GET /api/meta/filters` | Option lists for the filter UI (types, legions, gods, events) |
| `POST/PUT/DELETE /api/characters` | Character CRUD (phase 7) |

Filter params accept comma-separated or repeated values. `types` defaults to everything except
`Allegiance` (hidden by default to reduce hub clutter); pass `types=...,Allegiance` to include it.

```bash
# Whole graph (Allegiance nodes hidden by default)
curl 'http://localhost:8080/api/graph'
# Only the Legions
curl 'http://localhost:8080/api/graph?types=Legion'
# Everything on the traitor side
curl 'http://localhost:8080/api/graph?allegiance=traitor'
# The Sons of Horus neighbourhood
curl 'http://localhost:8080/api/graph?legions=sons-of-horus'
# Search by name
curl 'http://localhost:8080/api/graph?q=horus'
# A legion subgraph (includes the Emperor)
curl 'http://localhost:8080/api/graph/legion/sons-of-horus'
# Full node details
curl 'http://localhost:8080/api/nodes/horus-lupercal'
# Neighbours for "expand connections"
curl 'http://localhost:8080/api/nodes/horus-lupercal/neighbours?depth=1'
# Filter option lists
curl 'http://localhost:8080/api/meta/filters'
```

### Tests

```bash
cd backend && ./mvnw test   # @DataNeo4jTest + Testcontainers Neo4j
```

Tests spin up a real Neo4j, load the seed, and assert the seed counts, each filter
(type / allegiance / legion / search), the legion subgraph (Emperor included) and node details
(relationship grouping + chronological event ordering).

## Verifying the data

```bash
docker exec -it neo4j cypher-shell -u neo4j -p password123
```

```cypher
// Node counts per label
MATCH (n) UNWIND labels(n) AS l RETURN l AS label, count(*) AS n ORDER BY label;

// 18 Primarchs, each a son of the Emperor
MATCH (p:Primarch)-[:SON_OF]->(:Emperor) RETURN count(p);

// Every Primarch commands exactly one Legion
MATCH (p:Primarch) OPTIONAL MATCH (p)-[r:PRIMARCH_OF]->()
WITH p, count(r) AS c RETURN c, count(p);

// The two Expunged Legions are intentionally standalone
MATCH (n) WHERE NOT (n)--() RETURN labels(n), n.id;
```
