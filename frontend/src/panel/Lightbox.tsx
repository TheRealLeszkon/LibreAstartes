import { useEffect } from "react";

interface LightboxProps {
  src: string;
  caption?: string;
  onClose: () => void;
}

/** Full-view image overlay at centre-stage. Closes on ✕, backdrop click, or Esc. */
export default function Lightbox({ src, caption, onClose }: LightboxProps) {
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && onClose();
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [onClose]);

  return (
    <div className="lightbox" onClick={onClose} role="dialog" aria-modal="true" aria-label={caption}>
      <button className="lightbox-close" onClick={onClose} aria-label="Close image">
        ✕
      </button>
      <figure className="lightbox-figure" onClick={(e) => e.stopPropagation()}>
        <img src={src} alt={caption ?? "Expanded view"} />
        {caption && <figcaption>{caption}</figcaption>}
      </figure>
    </div>
  );
}
