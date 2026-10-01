// Shapes returned by the backend API.

export type NodeType =
  | "Emperor"
  | "Primarch"
  | "Astartes"
  | "Dreadnought"
  | "Legion"
  | "ChaosGod"
  | "Event"
  | "Allegiance";

/** Raw node `data` from the API (Cytoscape element data). */
export interface ApiNodeData {
  id: string;
  type: NodeType;
  name: string;
  subtitle?: string;
  legionId?: string;
  primaryColor?: string;
  secondaryColor?: string;
  color?: string;
  kind?: string;
  numeral?: string;
  expunged?: boolean;
  image?: string;
  order?: number;
  era?: string;
  location?: string;
}

export interface ApiEdgeData {
  id: string;
  source: string;
  target: string;
  type: string;
  role?: string;
  side?: string;
  degree?: string;
  event?: string;
}

export interface GraphResponse {
  nodes: { data: ApiNodeData }[];
  edges: { data: ApiEdgeData }[];
}

export interface RelatedRef {
  id: string;
  name: string;
  type: NodeType;
  role?: string;
  side?: string;
  order?: number;
  degree?: string;
  event?: string;
  relation?: string;
}

export interface NodeDetails {
  node: ApiNodeData & {
    description?: string;
    motivations?: string;
    fate?: string;
    loreNote?: string;
    homeworld?: string;
  };
  legion?: { id: string; name: string; numeral?: string; primaryColor?: string; secondaryColor?: string };
  allegiance: RelatedRef[];
  devotion: RelatedRef[];
  events: RelatedRef[];
  kills: RelatedRef[];
  deaths: RelatedRef[];
  members: RelatedRef[];
  primarch: RelatedRef[];
  connections: RelatedRef[];
}

export interface FilterOptions {
  types: NodeType[];
  legions: { id: string; name: string; numeral?: string; expunged?: boolean }[];
  gods: { id: string; name: string; color?: string; kind?: string }[];
  events: { id: string; name: string; order?: number; era?: string }[];
}
