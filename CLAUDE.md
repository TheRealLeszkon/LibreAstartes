# Liber Astartes: Horus Heresy lore graph explorer

A learning project for building apps on Neo4j. The full build spec is in `docs/build-spec.md`; read it only when starting a new phase.

## Layout
- `docker-compose.yml`: Neo4j Community (7474 browser, 7687 bolt)
- `backend/`: Java 21, Spring Boot, Spring Data Neo4j (see `backend/CLAUDE.md`)
- `frontend/`: React + TS + Vite + Cytoscape.js (see `frontend/CLAUDE.md`)

## Commands
- DB: `docker compose up -d` | reset: `docker compose down -v && docker compose up -d`
- Backend: `cd backend && ./mvnw spring-boot:run` | tests: `./mvnw test`
- Frontend: `cd frontend && npm run dev` | typecheck: `npm run typecheck` | build: `npm run build`
- Query the DB: `docker exec -it neo4j cypher-shell -u neo4j -p <password>`

## Data model (source of truth)
Labels: `Character` + one of `Emperor|Primarch|Astartes|Dreadnought`; `Legion`, `ChaosGod`, `Event`, `Allegiance`.
Rels: `SON_OF`, `PRIMARCH_OF`, `MEMBER_OF{role}`, `SIDED_WITH`, `DEVOTED_TO{degree}`,
`PARTICIPATED_IN{side,role}`, `FOUGHT_IN{side}`, `KILLED{event}`, `RIVAL_OF|ALLY_OF|MENTOR_OF`, `PART_OF`.
Every node has a unique slug `id`. Never use Neo4j internal ids in the API or frontend.
If you change the model, update this section and the seed files in the same commit.

## Conventions
- Labels PascalCase singular, rel types UPPER_SNAKE, properties camelCase.
- Cypher: always parameters (`$id`), never string concatenation. Use `MERGE` on `id` for writes.
  Merge nodes separately, then merge the relationship, never a whole path.
- Filtering happens in Cypher on the server, not on the client.
- API returns Cytoscape-ready elements: `{data:{id,type,name,subtitle,...}}`, edges `{data:{id,source,target,type}}`.

## Hard rules
- Node text must never clip. Size nodes from measured text after `document.fonts.ready`.
- No Games Workshop artwork, logos, legion/Chaos iconography, or fonts may be downloaded or embedded.
  Use only user-supplied images in `frontend/public/assets/`; all ornaments are original CSS/SVG.
- Lore text is original summary. If unsure something is canon, omit it; put ambiguity in `loreNote`.

## Workflow
- Work phase by phase as in the spec. Verify (tests, curl, screenshots), then commit with `phase N: ...`.
- Don't add dependencies beyond the spec without asking.
- Keep this file short. Area-specific notes go in the subdirectory CLAUDE.md files.

# Backend (Spring Boot + Spring Data Neo4j)

- Packages: `config`, `seed`, `graph` (filtered graph queries), `node` (details/neighbours), `character` (CRUD), `common`.
- Use `Neo4jClient` with hand-written Cypher for graph and filter endpoints. Use `Neo4jRepository` entities only for CRUD.
- Keep entities shallow: don't map relationships on entities unless CRUD needs them, so one save doesn't rewrite half the graph.
- Seed: `src/main/resources/seed/*.cypher`, loaded in filename order (`01-constraints`, `02-nodes`, `03-rels`) only when the DB is empty.
- Optional filters: build Cypher with `WHERE ($legions IS NULL OR l.id IN $legions)`-style clauses, not dynamic strings.
- Return DTO records, never entities. Map with map projections: `n {.*, type: labels(n)[...]}`.
- Tests: `@DataNeo4jTest` with Testcontainers Neo4j. At minimum test the filters and the legion subgraph.
- CORS is not needed in dev (the Vite proxy handles `/api`).

# Frontend (React + TS + Vite + Cytoscape.js)

- Structure: `api/` (typed fetch client), `graph/` (GraphView, stylesheet, sizing, layout), `panel/` (DetailsPanel), `filters/`, `legions/` (portrait, hotspots, editor), `theme/` (CSS variables, fonts, ornaments).
- One shared `GraphView` component is used by both tabs. Filters and the panel are shared too.
- `react-cytoscapejs` calls its `cy` callback every render: register event listeners once (ref guard).
- Node sizing lives in `graph/sizing.ts`: measure name + subtitle with canvas `measureText` in the real font, add padding and per-shape inset factors. Run only after `document.fonts.ready`.
- Filter state lives in the URL query string (single source of truth). Debounce API calls.
- Theme: CSS variables only, no hard-coded colours in components. Respect `prefers-reduced-motion`.
- Images: only from `public/assets/`. A missing image falls back to the original placeholder medallion.
