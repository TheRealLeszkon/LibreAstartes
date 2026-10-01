import type { Filters } from "../api/client";

export const DEFAULT_TYPES = [
  "Emperor",
  "Primarch",
  "Astartes",
  "Dreadnought",
  "Legion",
  "ChaosGod",
  "Event",
] as const;

export const ALL_TYPES = [...DEFAULT_TYPES, "Allegiance"] as const;

/** Full UI filter state, derived from and written to the URL query string. */
export interface FilterState {
  types: string[];
  allegiance?: string;
  legions: string[];
  gods: string[];
  events: string[];
  q: string;
  hood: number; // "neighbourhood of selected" depth; 0 = off
}

function list(params: URLSearchParams, key: string): string[] {
  const v = params.get(key);
  return v ? v.split(",").filter(Boolean) : [];
}

export function parseFilters(params: URLSearchParams): FilterState {
  const typesParam = list(params, "types");
  return {
    types: typesParam.length ? typesParam : [...DEFAULT_TYPES],
    allegiance: params.get("allegiance") ?? undefined,
    legions: list(params, "legions"),
    gods: list(params, "gods"),
    events: list(params, "events"),
    q: params.get("q") ?? "",
    hood: Number(params.get("hood") ?? "0") || 0,
  };
}

function sameSet(a: string[], b: readonly string[]): boolean {
  return a.length === b.length && [...a].sort().join(",") === [...b].sort().join(",");
}

/** Write a filter state back into URL params, omitting defaults/empties. */
export function writeFilters(params: URLSearchParams, s: FilterState): void {
  const put = (key: string, v: string[] | string | undefined) => {
    if (Array.isArray(v)) {
      if (v.length) params.set(key, v.join(","));
      else params.delete(key);
    } else if (v) {
      params.set(key, v);
    } else {
      params.delete(key);
    }
  };
  // `types` only appears in the URL when it differs from the defaults.
  if (sameSet(s.types, DEFAULT_TYPES)) params.delete("types");
  else params.set("types", [...s.types].join(","));
  put("allegiance", s.allegiance);
  put("legions", s.legions);
  put("gods", s.gods);
  put("events", s.events);
  put("q", s.q.trim());
  if (s.hood > 0) params.set("hood", String(s.hood));
  else params.delete("hood");
}

/** The server-side portion of the filters (q is applied client-side as highlight). */
export function toServerFilters(s: FilterState): Filters {
  return {
    types: s.types,
    allegiance: s.allegiance,
    legions: s.legions,
    gods: s.gods,
    events: s.events,
  };
}

export const EMPTY_FILTERS: FilterState = {
  types: [...DEFAULT_TYPES],
  legions: [],
  gods: [],
  events: [],
  q: "",
  hood: 0,
};
