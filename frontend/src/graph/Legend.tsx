import { useState } from "react";

/** A tiny SVG glyph echoing each Cytoscape node shape. */
function Glyph({ shape, fill, stroke }: { shape: string; fill: string; stroke: string }) {
  const common = { fill, stroke, strokeWidth: 2 };
  let node;
  switch (shape) {
    case "octagon":
      node = <polygon points="11,2 25,2 34,11 34,19 25,28 11,28 2,19 2,11" {...common} />;
      break;
    case "hexagon":
      node = <polygon points="18,2 33,9 33,21 18,28 3,21 3,9" {...common} />;
      break;
    case "round-rectangle":
      node = <rect x="3" y="7" width="30" height="16" rx="4" {...common} />;
      break;
    case "barrel":
      node = <path d="M5,8 Q18,3 31,8 L31,22 Q18,27 5,22 Z" {...common} />;
      break;
    case "pentagon":
      node = <polygon points="18,2 33,13 27,28 9,28 3,13" {...common} />;
      break;
    case "rhomboid":
      node = <polygon points="9,7 33,7 27,23 3,23" {...common} />;
      break;
    case "cut-rectangle":
      node = <polygon points="7,7 29,7 33,11 33,19 29,23 7,23 3,19 3,11" {...common} />;
      break;
    case "rectangle":
      node = <rect x="3" y="7" width="30" height="16" {...common} />;
      break;
    case "star":
      node = <polygon points="18,2 22,12 33,12 24,18 28,28 18,21 8,28 12,18 3,12 14,12" {...common} />;
      break;
    case "shield":
      node = <polygon points="5,3 31,3 31,15 24,24 18,27 12,24 5,15" {...common} />;
      break;
    case "concave":
      node = <polygon points="18,2 23,10 33,11 27,18 30,28 18,23 6,28 9,18 3,11 13,10" {...common} />;
      break;
    case "diamond":
      node = <polygon points="18,2 34,15 18,28 2,15" {...common} />;
      break;
    case "tag":
      node = <polygon points="4,7 24,7 32,15 24,23 4,23" {...common} />;
      break;
    default:
      node = <rect x="4" y="8" width="28" height="14" {...common} />;
  }
  return (
    <svg viewBox="0 0 36 30" width="36" height="30" aria-hidden>
      {node}
    </svg>
  );
}

const NODE_LEGEND = [
  { shape: "octagon", fill: "#c9a227", stroke: "#e6c86e", label: "Emperor", desc: "The Master of Mankind" },
  { shape: "hexagon", fill: "#2f5d50", stroke: "#c9a227", label: "Primarch", desc: "In legion colours, gold border" },
  { shape: "round-rectangle", fill: "#11407a", stroke: "#c9a227", label: "Astartes", desc: "Named legionary" },
  { shape: "barrel", fill: "#16181a", stroke: "#6a6f75", label: "Dreadnought", desc: "Interred ancient" },
  { shape: "pentagon", fill: "#b8902a", stroke: "#e6c86e", label: "Custodes", desc: "Golden guardians" },
  { shape: "rhomboid", fill: "#9ba3ab", stroke: "#e3e7ea", label: "Silent Sisters", desc: "Null-maidens" },
  { shape: "cut-rectangle", fill: "#8a4a2b", stroke: "#d08a3a", label: "Mechanicum", desc: "Priests of Mars" },
  { shape: "rectangle", fill: "#5a5e52", stroke: "#c9a227", label: "Imperialis", desc: "Humans & perpetuals" },
  { shape: "shield", fill: "#6e1414", stroke: "#c9a227", label: "Legion", desc: "Numeral + name" },
  { shape: "concave", fill: "#3a2a4a", stroke: "#7a4fa0", label: "Chaos Power", desc: "Warp-glow" },
  { shape: "star", fill: "#6a1f4a", stroke: "#b0308a", label: "Daemon", desc: "Neverborn of the warp" },
  { shape: "diamond", fill: "#e8dcc0", stroke: "#6b4f2a", label: "Event", desc: "Battle or council" },
  { shape: "tag", fill: "#7a0f0f", stroke: "#c9a227", label: "Allegiance", desc: "Hidden by default" },
];

const EDGE_LEGEND = [
  { color: "#c9a227", dash: "", label: "Bond / membership", desc: "son of, member of, fought in…" },
  { color: "#a81a1a", dash: "", label: "Killed", desc: "slayer → slain" },
  { color: "#7a4fa0", dash: "5,4", label: "Devoted to", desc: "sworn / influenced" },
  { color: "#3f6f63", dash: "2,4", label: "Sided with", desc: "allegiance" },
  { color: "rgba(201,162,39,0.5)", dash: "6,4", label: "Involved from afar", desc: "strategic / supporting / vision" },
];

export default function Legend() {
  const [open, setOpen] = useState(false);
  return (
    <div className={open ? "legend open" : "legend"}>
      <button className="legend-toggle" onClick={() => setOpen((o) => !o)}>
        {open ? "✕ Legend" : "☰ Legend"}
      </button>
      {open && (
        <div className="legend-body">
          <h4>Node Shapes</h4>
          <ul>
            {NODE_LEGEND.map((n) => (
              <li key={n.label}>
                <Glyph shape={n.shape} fill={n.fill} stroke={n.stroke} />
                <span className="legend-text">
                  <strong>{n.label}</strong>
                  <em>{n.desc}</em>
                </span>
              </li>
            ))}
          </ul>
          <h4>Bonds</h4>
          <ul>
            {EDGE_LEGEND.map((e) => (
              <li key={e.label}>
                <svg viewBox="0 0 36 30" width="36" height="30" aria-hidden>
                  <line
                    x1="3"
                    y1="15"
                    x2="33"
                    y2="15"
                    stroke={e.color}
                    strokeWidth="2.5"
                    strokeDasharray={e.dash || undefined}
                  />
                </svg>
                <span className="legend-text">
                  <strong>{e.label}</strong>
                  <em>{e.desc}</em>
                </span>
              </li>
            ))}
          </ul>
          <p className="legend-note">Node size is driven by its label — bigger = more text, never clipped.</p>
        </div>
      )}
    </div>
  );
}
