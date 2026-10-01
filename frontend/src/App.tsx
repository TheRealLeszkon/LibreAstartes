import { useCallback, useEffect, useState } from "react";
import { api } from "./api/client";
import type { GraphResponse } from "./api/types";
import GraphView from "./graph/GraphView";

type Tab = "codex" | "legions";

export default function App() {
  const [tab, setTab] = useState<Tab>("codex");
  const [graph, setGraph] = useState<GraphResponse | null>(null);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    api
      .graph()
      .then(setGraph)
      .catch((e) => setError(String(e)));
  }, []);

  const handleSelect = useCallback((id: string) => setSelectedId(id), []);
  const handleBackground = useCallback(() => setSelectedId(null), []);

  return (
    <div className="app">
      <header className="topbar">
        <div className="brand">
          <span className="brand-mark" aria-hidden />
          <h1>Liber Astartes</h1>
          <span className="brand-sub">Chronicle of the Horus Heresy</span>
        </div>
        <nav className="tabs">
          <button
            className={tab === "codex" ? "tab active" : "tab"}
            onClick={() => setTab("codex")}
          >
            Codex Graph
          </button>
          <button
            className={tab === "legions" ? "tab active" : "tab"}
            onClick={() => setTab("legions")}
          >
            Legions
          </button>
        </nav>
      </header>

      <main className="stage">
        {error && <div className="error-banner">Failed to reach the archive: {error}</div>}
        {tab === "codex" ? (
          <GraphView graph={graph} selectedId={selectedId} onSelectNode={handleSelect} onBackgroundTap={handleBackground} />
        ) : (
          <div className="placeholder">The Legions muster here — raised in a later rite.</div>
        )}
      </main>
    </div>
  );
}
