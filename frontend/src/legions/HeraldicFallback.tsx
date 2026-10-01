import type { GraphResponse, ApiNodeData } from "../api/types";

interface HeraldicFallbackProps {
  graph: GraphResponse;
  onSelectLegion: (legionId: string) => void;
  onShowNode: (id: string) => void;
}

const ROMAN_ORDER = [
  "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X",
  "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX",
];

/**
 * Original fallback layout for the Legions tab: the Emperor presides above a
 * muster of 20 heraldic cards (numeral, legion colours, Primarch name). Used
 * when no group portrait image is supplied. All ornament is original CSS/SVG —
 * legions are shown by numeral and colour, never official iconography.
 */
export default function HeraldicFallback({ graph, onSelectLegion, onShowNode }: HeraldicFallbackProps) {
  const legions = graph.nodes
    .map((n) => n.data)
    .filter((d) => d.type === "Legion")
    .sort((a, b) => ROMAN_ORDER.indexOf(a.numeral ?? "") - ROMAN_ORDER.indexOf(b.numeral ?? ""));

  const primarchByLegion = new Map<string, ApiNodeData>();
  for (const n of graph.nodes) {
    if (n.data.type === "Primarch" && n.data.legionId) {
      primarchByLegion.set(n.data.legionId, n.data);
    }
  }
  const emperor = graph.nodes.map((n) => n.data).find((d) => d.type === "Emperor");

  return (
    <div className="muster">
      {emperor && (
        <button className="emperor-card" onClick={() => onShowNode(emperor.id)}>
          <span className="emperor-sun" aria-hidden />
          <div className="emperor-text">
            <span className="card-kicker">The Master of Mankind</span>
            <h2>{emperor.name}</h2>
            <span className="emperor-sub">{emperor.subtitle}</span>
          </div>
        </button>
      )}

      <div className="legion-grid">
        {legions.map((lg) => {
          const primarch = primarchByLegion.get(lg.id);
          const primary = lg.primaryColor ?? "#241f19";
          const secondary = lg.secondaryColor ?? "#c9a227";
          if (lg.expunged) {
            return (
              <button key={lg.id} className="legion-card expunged" onClick={() => onShowNode(lg.id)}>
                <span className="legion-numeral">{lg.numeral}</span>
                <span className="legion-name">Records Expunged</span>
                <span className="legion-primarch">— ✖ —</span>
              </button>
            );
          }
          return (
            <button
              key={lg.id}
              className="legion-card"
              style={{
                background: `linear-gradient(160deg, ${primary}, #110d0a 140%)`,
                borderColor: secondary,
              }}
              onClick={() => onSelectLegion(lg.id)}
            >
              <span className="legion-stripe" style={{ background: secondary }} aria-hidden />
              <span className="legion-numeral" style={{ color: secondary }}>
                {lg.numeral}
              </span>
              <span className="legion-name">{lg.name}</span>
              <span className="legion-primarch">{primarch ? primarch.name : "Primarch unknown"}</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}
