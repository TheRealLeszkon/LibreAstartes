import type { ApiNodeData, GraphResponse, NodeType } from "../api/types";
import type { ElementDefinition } from "cytoscape";

/* ------------------------------------------------------------------ colours */

const GOLD = "#c9a227";
const PALE_GOLD = "#e6c86e";
const PARCHMENT = "#e8dcc0";
const CHARCOAL = "#241f19";
const BLOOD = "#7a0f0f";
const VERDIGRIS = "#3f6f63";

function hexToRgb(hex: string): [number, number, number] {
  let h = hex.replace("#", "").trim();
  if (h.length === 3) h = h.split("").map((c) => c + c).join("");
  const n = parseInt(h, 16);
  return [(n >> 16) & 255, (n >> 8) & 255, n & 255];
}

function clamp(n: number) {
  return Math.max(0, Math.min(255, Math.round(n)));
}

function toHex(r: number, g: number, b: number) {
  return "#" + [r, g, b].map((v) => clamp(v).toString(16).padStart(2, "0")).join("");
}

/** Relative luminance (0..1) used to choose a legible text colour. */
export function luminance(hex: string): number {
  const [r, g, b] = hexToRgb(hex).map((v) => {
    const s = v / 255;
    return s <= 0.03928 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4);
  });
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

/** Pick dark ink or pale parchment for contrast against a fill. */
export function textColorFor(bg: string): string {
  return luminance(bg) > 0.42 ? "#160f08" : "#f4ecd5";
}

export function shade(hex: string, amount: number): string {
  // amount in [-1,1]; negative darkens, positive lightens toward white.
  const [r, g, b] = hexToRgb(hex);
  if (amount < 0) {
    const f = 1 + amount;
    return toHex(r * f, g * f, b * f);
  }
  return toHex(r + (255 - r) * amount, g + (255 - g) * amount, b + (255 - b) * amount);
}

/* ------------------------------------------------------- per-type visual spec */

interface TypeSpec {
  fontSize: number;
  maxTextW: number;
  padX: number;
  padY: number;
  // Shape-inset inflation: the node must be larger than the text box so inset
  // shapes (hexagon, diamond, shield, star) never clip the label.
  wFactor: number;
  hFactor: number;
  minW: number;
  minH: number;
}

const SPEC: Record<NodeType, TypeSpec> = {
  Emperor: { fontSize: 15, maxTextW: 150, padX: 30, padY: 26, wFactor: 1.3, hFactor: 1.3, minW: 158, minH: 158 },
  Primarch: { fontSize: 13, maxTextW: 142, padX: 24, padY: 20, wFactor: 1.3, hFactor: 1.22, minW: 124, minH: 100 },
  Astartes: { fontSize: 12, maxTextW: 152, padX: 20, padY: 14, wFactor: 1.05, hFactor: 1.1, minW: 100, minH: 54 },
  Dreadnought: { fontSize: 12, maxTextW: 140, padX: 22, padY: 16, wFactor: 1.2, hFactor: 1.16, minW: 112, minH: 70 },
  Legion: { fontSize: 13, maxTextW: 150, padX: 24, padY: 22, wFactor: 1.18, hFactor: 1.55, minW: 124, minH: 128 },
  ChaosGod: { fontSize: 13, maxTextW: 120, padX: 24, padY: 20, wFactor: 1.4, hFactor: 1.4, minW: 120, minH: 112 },
  Event: { fontSize: 12, maxTextW: 132, padX: 22, padY: 18, wFactor: 1.58, hFactor: 1.58, minW: 120, minH: 120 },
  Allegiance: { fontSize: 12, maxTextW: 120, padX: 20, padY: 12, wFactor: 1.08, hFactor: 1.12, minW: 96, minH: 48 },
};

/* --------------------------------------------------------------- measurement */

let ctx: CanvasRenderingContext2D | null = null;
function context(): CanvasRenderingContext2D {
  if (!ctx) {
    const canvas = document.createElement("canvas");
    ctx = canvas.getContext("2d");
  }
  if (!ctx) throw new Error("No 2D canvas context for text measurement");
  return ctx;
}

function measureLine(c: CanvasRenderingContext2D, text: string): number {
  return c.measureText(text).width;
}

/** Greedy word-wrap at maxWidth; returns the laid-out lines. */
function wrap(c: CanvasRenderingContext2D, text: string, maxWidth: number): string[] {
  const lines: string[] = [];
  for (const paragraph of text.split("\n")) {
    const words = paragraph.split(/\s+/).filter(Boolean);
    if (words.length === 0) {
      lines.push("");
      continue;
    }
    let line = words[0];
    for (let i = 1; i < words.length; i++) {
      const next = `${line} ${words[i]}`;
      if (measureLine(c, next) <= maxWidth) {
        line = next;
      } else {
        lines.push(line);
        line = words[i];
      }
    }
    lines.push(line);
  }
  return lines;
}

/** Fill colour for a node, resolved from type + legion/chaos colours. */
export function fillFor(d: ApiNodeData): string {
  switch (d.type) {
    case "Emperor":
      return GOLD;
    case "Primarch":
    case "Astartes":
      return d.primaryColor ?? CHARCOAL;
    case "Dreadnought":
      return shade(d.primaryColor ?? CHARCOAL, -0.35);
    case "Legion":
      return d.expunged ? "#262321" : d.primaryColor ?? CHARCOAL;
    case "ChaosGod":
      return d.color ?? "#3a2a4a";
    case "Event":
      return PARCHMENT;
    case "Allegiance":
      return d.id === "loyalist" ? shade(GOLD, -0.2) : BLOOD;
    default:
      return CHARCOAL;
  }
}

function borderFor(d: ApiNodeData): { color: string; width: number } {
  switch (d.type) {
    case "Emperor":
      return { color: PALE_GOLD, width: 5 };
    case "Primarch":
      return { color: GOLD, width: 3.5 };
    case "Astartes":
      return { color: d.secondaryColor ?? GOLD, width: 1.6 };
    case "Dreadnought":
      return { color: d.secondaryColor ?? "#0a0a0a", width: 4.5 };
    case "Legion":
      return { color: d.expunged ? BLOOD : d.secondaryColor ?? GOLD, width: 3 };
    case "ChaosGod":
      return { color: shade(d.color ?? "#3a2a4a", 0.3), width: 2.5 };
    case "Event":
      return { color: "#6b4f2a", width: 2 };
    case "Allegiance":
      return { color: GOLD, width: 1.5 };
    default:
      return { color: GOLD, width: 2 };
  }
}

function labelFor(d: ApiNodeData): string {
  if (d.type === "Legion" && d.expunged) {
    return `${d.numeral ?? ""}\nRECORDS\nEXPUNGED`.trim();
  }
  const sub = d.subtitle ? `\n${d.subtitle}` : "";
  const prefix = d.type === "Legion" && d.numeral ? `${d.numeral} · ` : "";
  return `${prefix}${d.name}${sub}`;
}

/**
 * Turn an API graph into Cytoscape elements, computing each node's size from
 * its *measured* text so labels never clip. Call only after document.fonts.ready
 * so measurement uses the real webfont, not a fallback.
 */
export function prepareElements(graph: GraphResponse): ElementDefinition[] {
  const c = context();
  const nodes: ElementDefinition[] = graph.nodes.map(({ data }) => {
    const spec = SPEC[data.type];
    c.font = `${data.type === "Emperor" ? 700 : 600} ${spec.fontSize}px 'Cinzel', serif`;

    const label = labelFor(data);
    const lines = wrap(c, label, spec.maxTextW);
    const contentW = Math.max(1, ...lines.map((l) => measureLine(c, l)));
    const lineH = spec.fontSize * 1.26;
    const contentH = lines.length * lineH;

    const w = Math.max(spec.minW, Math.round((contentW + spec.padX * 2) * spec.wFactor));
    const h = Math.max(spec.minH, Math.round((contentH + spec.padY * 2) * spec.hFactor));

    const bg = fillFor(data);
    const border = borderFor(data);
    // Portraits live in the details panel, not on the node, so text colour is
    // chosen purely for contrast against the node fill.
    const fg = data.type === "Event" ? "#201204" : textColorFor(bg);

    return {
      data: {
        ...data,
        label,
        bg,
        fg,
        border: border.color,
        borderWidth: border.width,
        w,
        h,
        tw: spec.maxTextW,
        fontSize: spec.fontSize,
      },
    };
  });

  const edges: ElementDefinition[] = graph.edges.map(({ data }) => ({
    data: { ...data, label: data.type.toLowerCase().replace(/_/g, " ") },
  }));

  return [...nodes, ...edges];
}

export const PALETTE = { GOLD, PALE_GOLD, PARCHMENT, CHARCOAL, BLOOD, VERDIGRIS };
