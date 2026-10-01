import { useCallback, useEffect, useRef, useState } from "react";
import { api } from "./api/client";
import type { GraphResponse, NodeDetails } from "./api/types";
import GraphView from "./graph/GraphView";
import DetailsPanel from "./panel/DetailsPanel";

type Tab = "codex" | "legions";

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
  const [tab, setTab] = useState<Tab>("codex");
  const [graph, setGraph] = useState<GraphResponse | null>(null);
  const [selectedId, setSelectedId] = useState<string | null>(
    () => new URLSearchParams(window.location.search).get("node"),
  );
  const [details, setDetails] = useState<NodeDetails | null>(null);
  const [detailsLoading, setDetailsLoading] = useState(false);
  const [layoutNonce, setLayoutNonce] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const detailReq = useRef(0);

  useEffect(() => {
    api.graph().then(setGraph).catch((e) => setError(String(e)));
  }, []);

  // Fetch details whenever the selection changes.
  useEffect(() => {
    if (!selectedId) {
      setDetails(null);
      return;
    }
    const req = ++detailReq.current;
    setDetailsLoading(true);
    api
      .node(selectedId)
      .then((d) => {
        if (req === detailReq.current) setDetails(d);
      })
      .catch((e) => setError(String(e)))
      .finally(() => {
        if (req === detailReq.current) setDetailsLoading(false);
      });
  }, [selectedId]);

  // Esc closes the panel.
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setSelectedId(null);
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, []);

  const handleSelect = useCallback((id: string) => setSelectedId(id), []);
  const handleClose = useCallback(() => setSelectedId(null), []);

  const handleExpand = useCallback(() => {
    if (!selectedId) return;
    api.neighbours(selectedId, 1).then((nb) => {
      setGraph((g) => (g ? mergeGraph(g, nb) : nb));
      setLayoutNonce((n) => n + 1);
    });
  }, [selectedId]);

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
            graph={graph}
            selectedId={selectedId}
            onSelectNode={handleSelect}
            onBackgroundTap={handleClose}
            layoutNonce={layoutNonce}
          />
        ) : (
          <div className="placeholder">The Legions muster here — raised in a later rite.</div>
        )}

        <DetailsPanel
          details={details}
          loading={detailsLoading}
          open={Boolean(selectedId)}
          onClose={handleClose}
          onNavigate={handleSelect}
          onExpand={handleExpand}
        />
      </main>
    </div>
  );
}
