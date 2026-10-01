// react-cytoscapejs ships no type declarations; declare a minimal module.
declare module "react-cytoscapejs" {
  import type { Core, ElementDefinition } from "cytoscape";
  import type { CSSProperties } from "react";

  export interface CytoscapeComponentProps {
    elements: ElementDefinition[];
    stylesheet?: unknown;
    layout?: unknown;
    cy?: (cy: Core) => void;
    style?: CSSProperties;
    className?: string;
    minZoom?: number;
    maxZoom?: number;
    wheelSensitivity?: number;
    [key: string]: unknown;
  }

  const CytoscapeComponent: (props: CytoscapeComponentProps) => JSX.Element;
  export default CytoscapeComponent;
}
