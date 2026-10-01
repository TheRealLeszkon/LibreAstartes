// Cytoscape's bundled CSS typings are incomplete (they reject valid props such
// as shadow-* and shape-polygon-points), so the stylesheet is typed loosely.
type Style = { selector: string; style: Record<string, unknown> };

// Heraldic shield outline for Legion nodes: flat top, straight shoulders,
// tapering to a point. Values are normalised to the node's bounding box.
const SHIELD_POINTS =
  "-1 -0.95  1 -0.95  1 0.15  0.88 0.5  0.5 0.82  0 1  -0.5 0.82  -0.88 0.5  -1 0.15";

export const stylesheet: Style[] = [
  {
    selector: "node",
    style: {
      width: "data(w)",
      height: "data(h)",
      label: "data(label)",
      "background-color": "data(bg)",
      "border-color": "data(border)",
      "border-width": "data(borderWidth)",
      color: "data(fg)",
      "font-family": "Cinzel, serif",
      "font-size": "data(fontSize)",
      "font-weight": 600,
      "text-wrap": "wrap",
      "text-max-width": "data(tw)",
      "text-valign": "center",
      "text-halign": "center",
      "line-height": 1.24,
      "text-margin-y": 0,
      "overlay-opacity": 0,
    },
  },
  /* ---- shapes per type ---- */
  { selector: "node[type = 'Emperor']", style: { shape: "octagon", "shadow-blur": 40, "shadow-color": "#e6c86e", "shadow-opacity": 0.5, "shadow-offset-x": 0, "shadow-offset-y": 0 } },
  { selector: "node[type = 'Primarch']", style: { shape: "hexagon" } },
  { selector: "node[type = 'Astartes']", style: { shape: "round-rectangle" } },
  { selector: "node[type = 'Dreadnought']", style: { shape: "barrel" } },
  { selector: "node[type = 'Legion']", style: { shape: "polygon", "shape-polygon-points": SHIELD_POINTS } },
  { selector: "node[type = 'ChaosGod']", style: { shape: "concave-hexagon" } },
  { selector: "node[type = 'Event']", style: { shape: "diamond" } },
  { selector: "node[type = 'Allegiance']", style: { shape: "tag" } },

  // Records Expunged legions: redacted look.
  {
    selector: "node[?expunged]",
    style: {
      "background-fill": "linear-gradient",
      "background-gradient-stop-colors": "#2a2623 #171310 #2a2623",
      "background-gradient-stop-positions": "0 50 100",
      color: "#b9502f",
      "font-weight": 700,
      "border-style": "dashed",
    },
  },

  /* ---- selection / hover / search ---- */
  { selector: "node:selected", style: { "border-color": "#f4ecd5", "border-width": 5 } },
  { selector: "node.faded", style: { opacity: 0.12 } },
  { selector: "edge.faded", style: { opacity: 0.05 } },
  { selector: "node.highlight", style: { "border-color": "#e6c86e", "border-width": 5 } },
  { selector: "node.search-hit", style: { "border-color": "#f4ecd5", "border-width": 6 } },
  { selector: ".search-dim", style: { opacity: 0.1 } },

  /* ---- edges ---- */
  {
    selector: "edge",
    style: {
      width: 1.6,
      "line-color": "rgba(201,162,39,0.45)",
      "target-arrow-color": "rgba(201,162,39,0.6)",
      "target-arrow-shape": "triangle",
      "arrow-scale": 0.9,
      "curve-style": "bezier",
      label: "data(label)",
      "font-family": "Cinzel, serif",
      "font-size": 7,
      "letter-spacing": 1.2,
      color: "#b7a985",
      "text-background-color": "#0b0a09",
      "text-background-opacity": 0.65,
      "text-background-padding": 2,
      "text-rotation": "autorotate",
      "text-opacity": 0,
    },
  },
  { selector: "edge[type = 'KILLED']", style: { "line-color": "#a81a1a", "target-arrow-color": "#a81a1a", width: 2.4 } },
  {
    selector: "edge[type = 'DEVOTED_TO']",
    style: { "line-color": "#7a4fa0", "target-arrow-color": "#7a4fa0", "line-style": "dashed", width: 2 },
  },
  { selector: "edge[type = 'SIDED_WITH']", style: { "line-color": "#3f6f63", "target-arrow-color": "#3f6f63", "line-style": "dotted" } },
  { selector: "edge[type = 'SON_OF']", style: { "line-color": "rgba(230,200,110,0.7)", width: 2.2 } },
  { selector: "edge[type = 'PRIMARCH_OF']", style: { "line-color": "rgba(230,200,110,0.55)", width: 2 } },
  // Edge labels appear on hover / when incident to the selected node.
  { selector: "edge.show-label", style: { "text-opacity": 1 } },
  { selector: "edge:selected", style: { "line-color": "#f4ecd5", "text-opacity": 1 } },
];
