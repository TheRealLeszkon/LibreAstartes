interface MedallionProps {
  name: string;
  numeral?: string;
  primaryColor?: string;
  secondaryColor?: string;
  image?: string;
}

function initials(name: string): string {
  const words = name.replace(/[^A-Za-z\s'’]/g, "").split(/\s+/).filter(Boolean);
  if (words.length === 0) return "?";
  if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
  return (words[0][0] + words[words.length - 1][0]).toUpperCase();
}

/**
 * Original placeholder portrait: a gilded medallion showing the subject's
 * initials over the legion colours, with the legion numeral below. Used when no
 * image is supplied. No Games Workshop iconography — pure CSS/SVG.
 */
export default function Medallion({ name, numeral, primaryColor, secondaryColor, image }: MedallionProps) {
  if (image) {
    return (
      <div className="medallion medallion--image" style={{ borderColor: secondaryColor ?? "var(--aged-gold)" }}>
        <img src={`/${image}`} alt={name} />
      </div>
    );
  }
  const primary = primaryColor ?? "#241f19";
  const secondary = secondaryColor ?? "#c9a227";
  return (
    <div className="medallion" aria-label={name}>
      <svg viewBox="0 0 120 120" width="100%" height="100%">
        <defs>
          <radialGradient id="med-sheen" cx="50%" cy="38%" r="70%">
            <stop offset="0%" stopColor={secondary} stopOpacity="0.35" />
            <stop offset="100%" stopColor="#000" stopOpacity="0.1" />
          </radialGradient>
        </defs>
        <circle cx="60" cy="60" r="56" fill={primary} stroke={secondary} strokeWidth="4" />
        <circle cx="60" cy="60" r="56" fill="url(#med-sheen)" />
        <circle cx="60" cy="60" r="48" fill="none" stroke={secondary} strokeWidth="1" opacity="0.5" />
        <text
          x="60"
          y={numeral ? 58 : 68}
          textAnchor="middle"
          fontFamily="'Cinzel', serif"
          fontWeight="700"
          fontSize="34"
          fill={secondary}
        >
          {initials(name)}
        </text>
        {numeral && (
          <text x="60" y="86" textAnchor="middle" fontFamily="'Cinzel', serif" fontSize="16" fill={secondary} opacity="0.85">
            {numeral}
          </text>
        )}
      </svg>
    </div>
  );
}
