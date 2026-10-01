import type { NodeDetails, RelatedRef } from "../api/types";
import PanelHeader from "./PanelHeader";

interface DetailsPanelProps {
  details: NodeDetails | null;
  loading: boolean;
  open: boolean;
  onClose: () => void;
  onNavigate: (id: string) => void;
  onExpand: () => void;
}

/** A clickable related name. */
function Ref({ r, onNavigate }: { r: RelatedRef; onNavigate: (id: string) => void }) {
  return (
    <button className="ref" onClick={() => onNavigate(r.id)} title={r.type}>
      {r.name}
    </button>
  );
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="panel-section">
      <h3 className="section-head">
        <span className="section-rule" aria-hidden />
        {title}
      </h3>
      {children}
    </section>
  );
}

export default function DetailsPanel({ details, loading, open, onClose, onNavigate, onExpand }: DetailsPanelProps) {
  const node = details?.node;

  return (
    <aside className={open ? "details-panel open" : "details-panel"} aria-hidden={!open}>
      <button className="panel-close" onClick={onClose} aria-label="Close codex entry">
        ✕
      </button>

      {loading && <div className="panel-loading">Consulting the archive…</div>}

      {node && (
        <div className="panel-scroll">
          <PanelHeader details={details!} onNavigate={onNavigate} />

          {node.description && (
            <Section title="Codex Entry">
              <p className="body">{node.description}</p>
            </Section>
          )}

          {node.motivations && (
            <Section title="Driving Purpose">
              <p className="body">{node.motivations}</p>
            </Section>
          )}

          {(details!.allegiance.length > 0 || (details!.primarch.length > 0 && node.type === "Legion")) && (
            <Section title="Oaths Sworn">
              <div className="ref-row">
                {details!.allegiance.map((r) => (
                  <Ref key={r.id} r={r} onNavigate={onNavigate} />
                ))}
              </div>
              {node.type === "Legion" && details!.primarch.length > 0 && (
                <p className="body">
                  Commanded by{" "}
                  {details!.primarch.map((r) => (
                    <Ref key={r.id} r={r} onNavigate={onNavigate} />
                  ))}
                </p>
              )}
            </Section>
          )}

          {details!.devotion.length > 0 && (
            <Section title="Dark Patron">
              <ul className="rel-list">
                {details!.devotion.map((r) => (
                  <li key={r.id}>
                    <Ref r={r} onNavigate={onNavigate} />
                    {r.degree && <span className="degree"> — {r.degree}</span>}
                  </li>
                ))}
              </ul>
            </Section>
          )}

          {details!.events.length > 0 && (
            <Section title="Deeds Recorded">
              <ul className="rel-list">
                {details!.events.map((r) => (
                  <li key={r.id}>
                    <Ref r={r} onNavigate={onNavigate} />
                    {(r.side || r.role) && (
                      <span className="meta">
                        {" "}
                        — {[r.role, r.side].filter(Boolean).join(", ")}
                      </span>
                    )}
                  </li>
                ))}
              </ul>
            </Section>
          )}

          {(details!.kills.length > 0 || details!.deaths.length > 0 || node.fate) && (
            <Section title="Kills & Fate">
              {details!.kills.map((r) => (
                <p className="body" key={`k-${r.id}`}>
                  Slew <Ref r={r} onNavigate={onNavigate} />
                  {r.event && <span className="meta"> at {r.event}</span>}
                </p>
              ))}
              {details!.deaths.map((r) => (
                <p className="body" key={`d-${r.id}`}>
                  Slain by <Ref r={r} onNavigate={onNavigate} />
                  {r.event && <span className="meta"> at {r.event}</span>}
                </p>
              ))}
              {node.fate && <p className="body">{node.fate}</p>}
            </Section>
          )}

          {(details!.connections.length > 0 || details!.members.length > 0) && (
            <Section title="Bonds & Retinue">
              {details!.connections.length > 0 && (
                <ul className="rel-list">
                  {details!.connections.map((r) => (
                    <li key={`c-${r.id}-${r.relation}`}>
                      <span className="relation">{(r.relation ?? "").toLowerCase().replace(/_/g, " ")}</span>{" "}
                      <Ref r={r} onNavigate={onNavigate} />
                    </li>
                  ))}
                </ul>
              )}
              {details!.members.length > 0 && (
                <div className="ref-row">
                  {details!.members.map((r) => (
                    <Ref key={`m-${r.id}`} r={r} onNavigate={onNavigate} />
                  ))}
                </div>
              )}
            </Section>
          )}

          {node.loreNote && (
            <Section title="Contested Lore">
              <p className="body lore-note">{node.loreNote}</p>
            </Section>
          )}

          <button className="expand-btn" onClick={onExpand}>
            ✦ Expand connections
          </button>
        </div>
      )}
    </aside>
  );
}
