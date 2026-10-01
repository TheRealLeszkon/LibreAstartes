import { useEffect, useState } from "react";

/**
 * Resolves true once the web fonts have loaded, so canvas text measurement
 * (node sizing) uses the real font rather than a fallback. Hard requirement:
 * measuring before fonts load makes node labels overflow their shapes.
 */
export function useFontsReady(): boolean {
  const [ready, setReady] = useState(false);
  useEffect(() => {
    let cancelled = false;
    const fonts = (document as Document & { fonts?: FontFaceSet }).fonts;
    if (!fonts) {
      setReady(true);
      return;
    }
    // Ensure the specific families we measure with are actually requested.
    Promise.all([
      fonts.load("600 13px 'Cinzel'"),
      fonts.load("700 15px 'Cinzel'"),
      fonts.load("400 14px 'Cormorant Garamond'"),
    ])
      .catch(() => undefined)
      .then(() => fonts.ready)
      .then(() => {
        if (!cancelled) setReady(true);
      });
    return () => {
      cancelled = true;
    };
  }, []);
  return ready;
}
