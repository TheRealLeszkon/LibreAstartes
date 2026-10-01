# Frontend (React + TS + Vite + Cytoscape.js)

- Structure: `api/` (typed fetch client), `graph/` (GraphView, stylesheet, sizing, layout), `panel/` (DetailsPanel, Medallion), `filters/` (FilterRail, url state, filter parsing), `legions/` (portrait, hotspots, editor, heraldic fallback), `theme/` (CSS variables, fonts, ornaments).
- One shared `GraphView` component is used by both tabs. Filters and the panel are shared too.
- `react-cytoscapejs` calls its `cy` callback every render: register event listeners once (ref guard).
- Node sizing lives in `graph/sizing.ts`: measure name + subtitle with canvas `measureText` in the real font, add padding and per-shape inset factors. Run only after `document.fonts.ready` (see `useFontsReady`).
- Filter state lives in the URL query string (single source of truth, `filters/useUrlState.ts`). API calls are debounced. `q` is a client-side highlight+focus, not a server filter.
- Theme: CSS variables only, no hard-coded colours in components. Respect `prefers-reduced-motion`.
- Images: only from `public/assets/`. A missing image falls back to the original placeholder medallion. The Legions group portrait is optional (`public/assets/primarchs-group.jpg`); without it the heraldic-card muster is shown.
- Node types (`NodeType` in `api/types.ts`) must stay in lockstep across `sizing.ts` (`SPEC` is a `Record<NodeType,…>`, plus `fillFor`/`borderFor`), `stylesheet.ts` (shape per type), `Legend.tsx`, and `filters/filterState.ts` (`DEFAULT_TYPES`). Adding a type without a `SPEC` entry is a compile error — good.
- `PARTICIPATED_IN` carries `presence`; non-`physical` ties render dashed/faint in the graph and as a pill in the panel's "Deeds Recorded".
