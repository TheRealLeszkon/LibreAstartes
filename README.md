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

Current seed: 113 nodes (1 Emperor, 18 Primarchs, 20 Legions, 51 Astartes, 3 Dreadnoughts,
5 Chaos powers, 13 Events, 2 Allegiances) and 342 relationships. `04-expansion.cypher` adds a
further roster of notable Heresy figures — captains, equerries, librarians and more loyalists
serving inside traitor Legions (Macer Varren, Tylos Rubio, Corswain, …).

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

### Character CRUD (phase 7)

`type` is the subtype label and is validated against a whitelist
(`Astartes`, `Dreadnought`, `Primarch`, `Emperor`); `legionId`/`role` optionally
attach a `MEMBER_OF` relationship. The id is the given `id` or a slug of the name.

```bash
# Create (201) — returns the new node's details
curl -X POST http://localhost:8080/api/characters -H 'Content-Type: application/json' \
  -d '{"name":"Verdane Kol","type":"Astartes","subtitle":"Sergeant",
       "description":"…","legionId":"sons-of-horus","role":"Sergeant"}'
# Update (200)
curl -X PUT http://localhost:8080/api/characters/verdane-kol -H 'Content-Type: application/json' \
  -d '{"name":"Verdane Kol","type":"Astartes","subtitle":"Veteran Sergeant"}'
# Delete (204)
curl -X DELETE http://localhost:8080/api/characters/verdane-kol
```

Validation: missing `name`/`type` → `400`; unknown `type` → `400`;
duplicate id → `409`; update/delete of a missing id → `404`.

### Tests

```bash
cd backend && ./mvnw test   # @DataNeo4jTest + Testcontainers Neo4j (15 tests)
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

## Example Cypher queries

Practising Cypher is a goal of this project — all filtering happens in the database.

```cypher
// Loyalists serving inside a Traitor Legion (e.g. Garviel Loken)
MATCH (c:Character)-[:MEMBER_OF]->(l:Legion)-[:SIDED_WITH]->(:Allegiance {id:'traitor'})
MATCH (c)-[:SIDED_WITH]->(:Allegiance {id:'loyalist'})
RETURN c.name AS loyalist, l.name AS legion;

// Who killed whom, and where
MATCH (a:Character)-[k:KILLED]->(b:Character)
RETURN a.name AS slayer, b.name AS slain, k.event AS event;

// Every participant at the Dropsite Massacre, by side
MATCH (c:Character)-[p:PARTICIPATED_IN]->(:Event {id:'isstvan-v'})
RETURN p.side AS side, collect(c.name) AS warriors ORDER BY side;

// Legions sworn to each Chaos power
MATCH (l:Legion)-[d:DEVOTED_TO]->(g:ChaosGod)
RETURN g.name AS power, d.degree AS degree, collect(l.name) AS legions;

// The Siege of Terra and everything folded into it
MATCH (e:Event)-[:PART_OF]->(:Event {id:'siege-of-terra'})
RETURN e.name;

// Shortest path of allegiance/bonds between two primarchs
MATCH p = shortestPath(
  (:Primarch {id:'horus-lupercal'})-[:ALLY_OF|RIVAL_OF|SON_OF*..6]-(:Primarch {id:'rogal-dorn'}))
RETURN [n IN nodes(p) | n.name] AS chain;
```

## Using the app

- **Codex Graph** tab: the whole setting as an interactive graph. Click any node to open
  its codex entry (panel slides in from the left); click related names to navigate.
- **Legions** tab: a heraldic muster of the Emperor and 20 Legions; click a Legion for its
  filtered subgraph. (Drop a `frontend/public/assets/primarchs-group.jpg` in and map faces
  with the editor at `?editHotspots=1` to use a group portrait instead.)
- **Imagery**: a node's details panel shows a portrait banner if an image is available,
  otherwise an original medallion. Drop a file at `frontend/public/assets/<id>.jpg` (the node's
  slug — a character *or* an event, e.g. `horus-lupercal.jpg`, `isstvan-v.jpg`) and it appears
  automatically, falling back gracefully if absent. Only images you place there are ever loaded —
  no artwork is fetched or embedded (see the IP rules in `CLAUDE.md`).
- **Legend** (bottom-left of any graph): what every node shape and bond style means.
- **Filters** (right rail, on both tabs): node types, allegiance, legions, chaos powers,
  events, a name search that highlights and focuses matches, and a "neighbourhood of selected"
  depth toggle. All state lives in the URL, so any view is shareable — e.g.
  `/?allegiance=traitor`, `/?legion=sons-of-horus`, `/?node=horus-lupercal`.
