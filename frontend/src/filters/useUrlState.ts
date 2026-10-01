import { useCallback, useEffect, useState } from "react";

/**
 * The URL query string as the single source of truth for app state (filters,
 * tab, selection). `params` is recomputed each render; `update` mutates the URL
 * in place (replaceState) and triggers a re-render.
 */
export function useUrlState() {
  const [search, setSearch] = useState(() => window.location.search);

  const update = useCallback((mutate: (p: URLSearchParams) => void) => {
    const p = new URLSearchParams(window.location.search);
    mutate(p);
    const qs = p.toString();
    const url = qs ? `${window.location.pathname}?${qs}` : window.location.pathname;
    window.history.replaceState(null, "", url);
    setSearch(window.location.search);
  }, []);

  useEffect(() => {
    const onPop = () => setSearch(window.location.search);
    window.addEventListener("popstate", onPop);
    return () => window.removeEventListener("popstate", onPop);
  }, []);

  return { params: new URLSearchParams(search), update };
}
