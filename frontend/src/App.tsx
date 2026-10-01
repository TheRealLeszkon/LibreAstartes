import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { api } from "./api/client";
import type { FilterOptions, GraphResponse, NodeDetails } from "./api/types";
import GraphView from "./graph/GraphView";
import DetailsPanel from "./panel/DetailsPanel";
import LegionsTab from "./legions/LegionsTab";
import FilterRail from "./filters/FilterRail";
import { useUrlState } from "./filters/useUrlState";
import {
  EMPTY_FILTERS,
  parseFilters,
  toServerFilters,
  writeFilters,
  type FilterState,
} from "./filters/filterState";

/** Merge extra elements into a graph, de-duplicated by id. */
function mergeGraph(base: GraphResponse, extra: GraphResponse): GraphResponse {
  const nodeIds = new Set(base.nodes.map((n) => n.data.id));
  const edgeIds = new Set(base.edges.map((e) => e.data.id));
  return {
    nodes: [...base.nodes, ...extra.nodes.filter((n) => !nodeIds.has(n.data.id))],
    edges: [...base.edges, ...extra.edges.filter((e) => !edgeIds.has(e.data.id))],
  };
}

export default function App() {
  const { params, update } = useUrlState();

  // All view state derives from the URL (shareable).
  const tab = params.get("tab") === "legions" ? "legions" : "codex";
  const selectedId = params.get("node");
  const legionId = params.get("legion");
  const filters = useMemo(() => parseFilters(params), [params.toString()]);
  const serverKey = JSON.stringify(toServerFilters(filters));

  const [options, setOptions] = useState<FilterOptions | null>(null);
  const [fullGraph, setFullGraph] = useState<GraphResponse | null>(null);
  const [baseGraph, setBaseGraph] = useState<GraphResponse | null>(null);
  const [legionGraph, setLegionGraph] = useState<GraphResponse | null>(null);
  const [hoodGraph, setHoodGraph] = useState<GraphResponse | null>(null);
  const [details, setDetails] = useState<NodeDetails | null>(null);
  const [detailsLoading, setDetailsLoading] = useState(false);
  const [layoutNonce, setLayoutNonce] = useState(0);
  const [railCollapsed, setRailCollapsed] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const detailReq = useRef(0);

  useEffect(() => {
    api.filters().then(setOptions).catch((e) => setError(String(e)));
    // Unfiltered full graph: drives the Legions muster cards and hotspot mapping.
    api.graph().then(setFullGraph).catch((e) => setError(String(e)));
  }, []);

  // Codex graph — debounced on the server-side filters.
  useEffect(() => {
    const t = setTimeout(() => {
      api.graph(toServerFilters(filters)).then(setBaseGraph).catch((e) => setError(String(e)));
    }, 250);
    return () => clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [serverKey]);

  // Legion subgraph — same filters, debounced.
  useEffect(() => {
    if (!legionId) {
      setLegionGraph(null);
      return;
    }
    const t = setTimeout(() => {
      api.legionGraph(legionId, toServerFilters(filters)).then(setLegionGraph).catch((e) => setError(String(e)));
    }, 250);
    return () => clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [legionId, serverKey]);

  // Neighbourhood of selected (depth 1–2).
  useEffect(() => {
    if (filters.hood > 0 && selectedId) {
      api.neighbours(selectedId, filters.hood).then(setHoodGraph).catch((e) => setError(String(e)));
    } else {
      setHoodGraph(null);
    }
  }, [filters.hood, selectedId]);

  // Details for the selected node.
  useEffect(() => {
    if (!selectedId) {
      setDetails(null);
      return;
    }
    const req = ++detailReq.current;
    setDetailsLoading(true);
    api
      .node(selectedId)
      .then((d) => req === detailReq.current && setDetails(d))
      .catch((e) => setError(String(e)))
      .finally(() => req === detailReq.current && setDetailsLoading(false));
  }, [selectedId]);

  // Esc closes the panel.
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && update((p) => p.delete("node"));
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [update]);

  const setTab = (t: "codex" | "legions") =>
    update((p) => (t === "legions" ? p.set("tab", "legions") : p.delete("tab")));
  const selectNode = useCallback((id: string) => update((p) => p.set("node", id)), [update]);
  const closeNode = useCallback(() => update((p) => p.delete("node")), [update]);
  const selectLegion = useCallback((id: string) => update((p) => p.set("legion", id)), [update]);
  const legionBack = useCallback(
    () => update((p) => {
      p.delete("legion");
      p.delete("node");
    }),
    [update],
  );

  const onFilterChange = useCallback(
    (patch: Partial<FilterState>) =>
      update((p) => writeFilters(p, { ...parseFilters(p), ...patch })),
    [update],
  );
  const onReset = useCallback(() => update((p) => writeFilters(p, EMPTY_FILTERS)), [update]);

  const onExpand = useCallback(() => {
    if (!selectedId) return;
    api.neighbours(selectedId, 1).then((nb) => {
      setBaseGraph((g) => (g ? mergeGraph(g, nb) : nb));
      setLayoutNonce((n) => n + 1);
    });
  }, [selectedId]);

  const useHood = filters.hood > 0 && selectedId && hoodGraph;
  const codexGraph = useHood ? hoodGraph : baseGraph;
  const shownLegionGraph = useHood ? hoodGraph : legionGraph;

  return (
    <div className="app">
      <header className="topbar">
        <div className="brand">
          <span className="brand-mark" aria-hidden />
          <h1>Liber Astartes</h1>
          <span className="brand-sub">Chronicle of the Horus Heresy</span>
        </div>
        <nav className="tabs">
          <button className={tab === "codex" ? "tab active" : "tab"} onClick={() => setTab("codex")}>
            Codex Graph
          </button>
          <button className={tab === "legions" ? "tab active" : "tab"} onClick={() => setTab("legions")}>
            Legions
          </button>
        </nav>
      </header>

      <main className="stage">
        {error && <div className="error-banner">Failed to reach the archive: {error}</div>}

        {tab === "codex" ? (
          <GraphView
            graph={codexGraph}
            selectedId={selectedId}
            onSelectNode={selectNode}
            onBackgroundTap={closeNode}
            layoutNonce={layoutNonce}
            search={filters.q}
          />
        ) : (
          <LegionsTab
            graph={fullGraph}
            legionId={legionId}
            legionGraph={shownLegionGraph}
            onSelectLegion={selectLegion}
            onBack={legionBack}
            onSelectNode={selectNode}
            selectedId={selectedId}
            layoutNonce={layoutNonce}
            search={filters.q}
          />
        )}

        <DetailsPanel
          details={details}
          loading={detailsLoading}
          open={Boolean(selectedId)}
          onClose={closeNode}
          onNavigate={selectNode}
          onExpand={onExpand}
        />

        <FilterRail
          options={options}
          filters={filters}
          onChange={onFilterChange}
          onReset={onReset}
          collapsed={railCollapsed}
          onToggleCollapse={() => setRailCollapsed((c) => !c)}
          legionLocked={tab === "legions" && Boolean(legionId)}
        />
      </main>
    </div>
  );
}
