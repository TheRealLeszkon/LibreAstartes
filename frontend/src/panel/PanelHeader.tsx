import { useEffect, useState } from "react";
import type { NodeDetails } from "../api/types";
import Medallion from "./Medallion";

interface PanelHeaderProps {
  details: NodeDetails;
  onNavigate: (id: string) => void;
  onViewImage?: (src: string, caption: string) => void;
}

/**
 * Panel header. If an image is available it is shown as a large portrait banner;
 * otherwise an original medallion (initials + legion numeral) is drawn. Image
 * sources are tried in order and fall back on load error, so a user can drop
 * `public/assets/<id>.jpg` (character or event) and it appears with no code change.
 * Only user-supplied images are ever loaded — no artwork is fetched or embedded.
 */
export default function PanelHeader({ details, onNavigate, onViewImage }: PanelHeaderProps) {
  const node = details.node;
  const candidates = [node.image ? `/${node.image}` : null, `/assets/${node.id}.jpg`].filter(
    (s): s is string => Boolean(s),
  );
  const [idx, setIdx] = useState(0);
  useEffect(() => setIdx(0), [node.id]);

  const src = candidates[idx];
  const hasBanner = Boolean(src);

  const title = (
    <div className="panel-title">
      <span className="type-badge">{node.type}</span>
      <h2>{node.name}</h2>
      {node.subtitle && <p className="subtitle">{node.subtitle}</p>}
      {details.legion && node.type !== "Legion" && (
        <p className="of-legion">
          of the{" "}
          <button className="ref inline" onClick={() => onNavigate(details.legion!.id)}>
            {details.legion.name}
          </button>
        </p>
      )}
      {node.homeworld && <p className="of-legion">Homeworld · {node.homeworld}</p>}
    </div>
  );

  if (hasBanner) {
    const zoomable = Boolean(onViewImage);
    return (
      <header className="panel-header has-banner">
        <div
          className={zoomable ? "panel-banner zoomable" : "panel-banner"}
          onClick={zoomable ? () => onViewImage!(src, node.name) : undefined}
        >
          {zoomable && <span className="banner-expand">⤢ expand</span>}
          <img src={src} alt={node.name} onError={() => setIdx((i) => i + 1)} />
          <div className="banner-fade" />
        </div>
        {title}
      </header>
    );
  }

  return (
    <header className="panel-header">
      <Medallion
        name={node.name}
        numeral={details.legion?.numeral ?? node.numeral}
        primaryColor={details.legion?.primaryColor ?? node.primaryColor}
        secondaryColor={details.legion?.secondaryColor ?? node.secondaryColor}
      />
      {title}
    </header>
  );
}
