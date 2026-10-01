import { useRef, useState } from "react";
import type { GraphResponse } from "../api/types";
import { GROUP_IMAGE, type Hotspot } from "./Portrait";

interface HotspotEditorProps {
  graph: GraphResponse;
}

interface Draft {
  x: number;
  y: number;
  w: number;
  h: number;
}

/**
 * Hotspot editor (?editHotspots=1): drag rectangles over the group image, assign
 * each to a Primarch, and export the JSON for data/hotspots.json. Coordinates are
 * stored as percentages so they scale with the image.
 */
export default function HotspotEditor({ graph }: HotspotEditorProps) {
  const frameRef = useRef<HTMLDivElement>(null);
  const [spots, setSpots] = useState<Hotspot[]>([]);
  const [draft, setDraft] = useState<Draft | null>(null);
  const start = useRef<{ x: number; y: number } | null>(null);

  const primarchs = graph.nodes
    .map((n) => n.data)
    .filter((d) => d.type === "Primarch")
    .sort((a, b) => a.name.localeCompare(b.name));

  const pct = (clientX: number, clientY: number) => {
    const el = frameRef.current!;
    const r = el.getBoundingClientRect();
    return {
      x: ((clientX - r.left) / r.width) * 100,
      y: ((clientY - r.top) / r.height) * 100,
    };
  };

  const onDown = (e: React.MouseEvent) => {
    const p = pct(e.clientX, e.clientY);
    start.current = p;
    setDraft({ x: p.x, y: p.y, w: 0, h: 0 });
  };
  const onMove = (e: React.MouseEvent) => {
    if (!start.current) return;
    const p = pct(e.clientX, e.clientY);
    const s = start.current;
    setDraft({
      x: Math.min(s.x, p.x),
      y: Math.min(s.y, p.y),
      w: Math.abs(p.x - s.x),
      h: Math.abs(p.y - s.y),
    });
  };
  const onUp = () => {
    if (draft && draft.w > 1 && draft.h > 1) {
      setSpots((prev) => [...prev, { primarchId: "", ...round(draft) }]);
    }
    start.current = null;
    setDraft(null);
  };

  const assign = (i: number, primarchId: string) =>
    setSpots((prev) => prev.map((s, idx) => (idx === i ? { ...s, primarchId } : s)));
  const remove = (i: number) => setSpots((prev) => prev.filter((_, idx) => idx !== i));

  const json = JSON.stringify(spots, null, 2);
  const copy = () => navigator.clipboard?.writeText(json);
  const download = () => {
    const blob = new Blob([json], { type: "application/json" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "hotspots.json";
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="hotspot-editor">
      <div className="editor-stage">
        <div
          className="portrait-frame editable"
          ref={frameRef}
          onMouseDown={onDown}
          onMouseMove={onMove}
          onMouseUp={onUp}
          onMouseLeave={onUp}
        >
          <img src={GROUP_IMAGE} alt="group" draggable={false} />
          {spots.map((s, i) => (
            <div key={i} className="edit-rect" style={{ left: `${s.x}%`, top: `${s.y}%`, width: `${s.w}%`, height: `${s.h}%` }}>
              <span>{s.primarchId || "?"}</span>
            </div>
          ))}
          {draft && (
            <div className="edit-rect drafting" style={{ left: `${draft.x}%`, top: `${draft.y}%`, width: `${draft.w}%`, height: `${draft.h}%` }} />
          )}
        </div>
      </div>

      <aside className="editor-panel">
        <h3>Hotspots ({spots.length})</h3>
        <p className="editor-help">Drag on the image to add a rectangle, then assign a Primarch.</p>
        <ul>
          {spots.map((s, i) => (
            <li key={i}>
              <select value={s.primarchId} onChange={(e) => assign(i, e.target.value)}>
                <option value="">— choose —</option>
                {primarchs.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.name}
                  </option>
                ))}
              </select>
              <button onClick={() => remove(i)}>✕</button>
            </li>
          ))}
        </ul>
        <div className="editor-actions">
          <button onClick={copy}>Copy JSON</button>
          <button onClick={download}>Download</button>
        </div>
        <textarea readOnly value={json} rows={10} />
      </aside>
    </div>
  );
}

function round(d: Draft): Draft {
  const r = (n: number) => Math.round(n * 100) / 100;
  return { x: r(d.x), y: r(d.y), w: r(d.w), h: r(d.h) };
}
