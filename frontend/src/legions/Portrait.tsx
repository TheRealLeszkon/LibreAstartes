import { useState } from "react";
import type { GraphResponse } from "../api/types";
import hotspotData from "../data/hotspots.json";

export interface Hotspot {
  primarchId: string;
  x: number; // all as percentages of the image box
  y: number;
  w: number;
  h: number;
}

export const GROUP_IMAGE = "/assets/primarchs-group.jpg";

interface PortraitProps {
  graph: GraphResponse;
  onSelectLegion: (legionId: string) => void;
}

/**
 * The group-portrait view: clickable hotspots (from data/hotspots.json, in
 * percentages so they scale with the image) over the supplied group image.
 * Hovering a face reveals a gilded outline and a name tooltip; clicking opens
 * that Primarch's legion graph. Shown only when the image is present.
 */
export default function Portrait({ graph, onSelectLegion }: PortraitProps) {
  const [hovered, setHovered] = useState<string | null>(null);
  const hotspots = hotspotData as Hotspot[];

  // Map a primarch id to its legion id and display name.
  const legionByPrimarch = new Map<string, { legionId?: string; name: string }>();
  for (const n of graph.nodes) {
    if (n.data.type === "Primarch") {
      legionByPrimarch.set(n.data.id, { legionId: n.data.legionId, name: n.data.name });
    }
  }

  return (
    <div className="portrait-wrap">
      <div className="portrait-frame">
        <img src={GROUP_IMAGE} alt="The Emperor and his Primarchs" />
        {hotspots.map((h) => {
          const info = legionByPrimarch.get(h.primarchId);
          return (
            <button
              key={h.primarchId}
              className={hovered === h.primarchId ? "hotspot hovered" : "hotspot"}
              style={{ left: `${h.x}%`, top: `${h.y}%`, width: `${h.w}%`, height: `${h.h}%` }}
              onMouseEnter={() => setHovered(h.primarchId)}
              onMouseLeave={() => setHovered(null)}
              onClick={() => info?.legionId && onSelectLegion(info.legionId)}
              aria-label={info?.name ?? h.primarchId}
            >
              {hovered === h.primarchId && <span className="hotspot-tip">{info?.name ?? h.primarchId}</span>}
            </button>
          );
        })}
      </div>
      {hotspots.length === 0 && (
        <p className="portrait-note">
          No hotspots defined yet — map faces with the editor at <code>?editHotspots=1</code>.
        </p>
      )}
    </div>
  );
}
