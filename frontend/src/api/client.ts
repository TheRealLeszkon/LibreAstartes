import type { FilterOptions, GraphResponse, NodeDetails } from "./types";

/**
 * Filter state shared by both graphs. Mirrors the backend query params.
 * `undefined`/empty means "no constraint".
 */
export interface Filters {
  types?: string[];
  allegiance?: string;
  legions?: string[];
  gods?: string[];
  events?: string[];
  q?: string;
}

function toQuery(filters: Filters): string {
  const p = new URLSearchParams();
  const addList = (key: string, v?: string[]) => {
    if (v && v.length) p.set(key, v.join(","));
  };
  addList("types", filters.types);
  addList("legions", filters.legions);
  addList("gods", filters.gods);
  addList("events", filters.events);
  if (filters.allegiance) p.set("allegiance", filters.allegiance);
  if (filters.q && filters.q.trim()) p.set("q", filters.q.trim());
  const s = p.toString();
  return s ? `?${s}` : "";
}

async function getJson<T>(url: string): Promise<T> {
  const res = await fetch(url);
  if (!res.ok) {
    throw new Error(`${res.status} ${res.statusText} for ${url}`);
  }
  return (await res.json()) as T;
}

export const api = {
  graph: (filters: Filters = {}) =>
    getJson<GraphResponse>(`/api/graph${toQuery(filters)}`),

  legionGraph: (legionId: string, filters: Filters = {}) =>
    getJson<GraphResponse>(`/api/graph/legion/${encodeURIComponent(legionId)}${toQuery(filters)}`),

  node: (id: string) => getJson<NodeDetails>(`/api/nodes/${encodeURIComponent(id)}`),

  neighbours: (id: string, depth = 1) =>
    getJson<GraphResponse>(`/api/nodes/${encodeURIComponent(id)}/neighbours?depth=${depth}`),

  filters: () => getJson<FilterOptions>(`/api/meta/filters`),
};
