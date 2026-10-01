import { useEffect, useState } from "react";
import type { GraphResponse } from "../api/types";
import GraphView from "../graph/GraphView";
import HeraldicFallback from "./HeraldicFallback";
import Portrait, { GROUP_IMAGE } from "./Portrait";
import HotspotEditor from "./HotspotEditor";

interface LegionsTabProps {
  graph: GraphResponse | null; // the full graph, for cards/hotspot mapping
  legionId: string | null;
  legionGraph: GraphResponse | null;
  onSelectLegion: (legionId: string) => void;
  onBack: () => void;
  onSelectNode: (id: string) => void;
  selectedId: string | null;
  layoutNonce: number;
}

export default function LegionsTab({
  graph,
  legionId,
  legionGraph,
  onSelectLegion,
  onBack,
  onSelectNode,
  selectedId,
  layoutNonce,
}: LegionsTabProps) {
  const editing = new URLSearchParams(window.location.search).get("editHotspots") === "1";
  const [hasImage, setHasImage] = useState<boolean | null>(null);

  // Probe for the optional group portrait; fall back to heraldic cards if absent.
  useEffect(() => {
    const img = new Image();
    img.onload = () => setHasImage(true);
    img.onerror = () => setHasImage(false);
    img.src = GROUP_IMAGE;
  }, []);

  if (!graph) return <div className="placeholder">Mustering the Legions…</div>;

  if (editing) return <HotspotEditor graph={graph} />;

  // A legion has been chosen: show its filtered subgraph.
  if (legionId) {
    const legion = graph.nodes.find((n) => n.data.id === legionId)?.data;
    return (
      <div className="legion-view">
        <div className="legion-view-bar">
          <button className="back-btn" onClick={onBack}>
            ‹ All Legions
          </button>
          <h2>
            {legion?.numeral && <span className="bar-numeral">{legion.numeral}</span>} {legion?.name}
          </h2>
          <span className="bar-sub">{legion?.subtitle}</span>
        </div>
        <div className="legion-graph">
          <GraphView
            graph={legionGraph}
            selectedId={selectedId}
            onSelectNode={onSelectNode}
            onBackgroundTap={() => undefined}
            layoutNonce={layoutNonce}
          />
        </div>
      </div>
    );
  }

  // Muster view: portrait (if supplied) or the heraldic-card fallback.
  if (hasImage === null) return <div className="placeholder">Mustering the Legions…</div>;
  if (hasImage) {
    return <Portrait graph={graph} onSelectLegion={onSelectLegion} />;
  }
  return <HeraldicFallback graph={graph} onSelectLegion={onSelectLegion} onShowNode={onSelectNode} />;
}
