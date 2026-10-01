import { useEffect, useMemo, useRef } from "react";
import CytoscapeComponent from "react-cytoscapejs";
import cytoscape from "cytoscape";
import type { Core, ElementDefinition } from "cytoscape";
// @ts-expect-error — cytoscape-fcose ships no bundled types.
import fcose from "cytoscape-fcose";

import type { GraphResponse } from "../api/types";
import { prepareElements } from "./sizing";
import { stylesheet } from "./stylesheet";
import { fcoseLayout } from "./layout";
import { useFontsReady } from "./useFontsReady";
import Legend from "./Legend";

cytoscape.use(fcose);

interface GraphViewProps {
  graph: GraphResponse | null;
  selectedId?: string | null;
  onSelectNode?: (id: string) => void;
  onBackgroundTap?: () => void;
  /** Bumping this re-runs the layout (e.g. after "expand connections"). */
  layoutNonce?: number;
  /** Search term: matching nodes are highlighted and focused, others dimmed. */
  search?: string;
}

export default function GraphView({
  graph,
  selectedId,
  onSelectNode,
  onBackgroundTap,
  layoutNonce = 0,
  search = "",
}: GraphViewProps) {
  const fontsReady = useFontsReady();
  const cyRef = useRef<Core | null>(null);

  // Keep the latest callbacks in refs so listeners are registered only once.
  const onSelectRef = useRef(onSelectNode);
  const onBackgroundRef = useRef(onBackgroundTap);
  const selectedRef = useRef<string | null | undefined>(selectedId);
  onSelectRef.current = onSelectNode;
  onBackgroundRef.current = onBackgroundTap;
  selectedRef.current = selectedId;

  // Size nodes from measured text only after the webfont has loaded.
  const elements = useMemo<ElementDefinition[]>(
    () => (graph && fontsReady ? prepareElements(graph) : []),
    [graph, fontsReady],
  );

  const elementsKey = useMemo(
    () => (graph ? graph.nodes.map((n) => n.data.id).sort().join(",") : ""),
    [graph],
  );

  // (Re)run the layout whenever the element set changes. Fit explicitly on stop
  // so the whole graph is centred in the viewport regardless of timing.
  useEffect(() => {
    const cy = cyRef.current;
    if (!cy || elements.length === 0) return;
    const run = () => {
      const layout = cy.layout(fcoseLayout(false) as never);
      layout.one("layoutstop", () => cy.fit(undefined, 70));
      layout.run();
    };
    // Defer one frame so the canvas has its final size before fitting.
    const raf = requestAnimationFrame(run);
    return () => cancelAnimationFrame(raf);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [elementsKey, fontsReady, layoutNonce]);

  // Reflect selection: highlight the node, reveal its edge labels, centre it.
  useEffect(() => {
    const cy = cyRef.current;
    if (!cy) return;
    cy.batch(() => {
      cy.elements().removeClass("highlight show-label");
      if (selectedId) {
        const n = cy.getElementById(selectedId);
        if (n.nonempty()) {
          n.addClass("highlight");
          n.connectedEdges().addClass("show-label");
        }
      }
    });
    if (selectedId) {
      const n = cy.getElementById(selectedId);
      if (n.nonempty()) {
        cy.animate({ center: { eles: n }, duration: 350, easing: "ease-out" });
      }
    }
  }, [selectedId, elementsKey]);

  // Search: highlight matching nodes, dim the rest, focus the matches.
  useEffect(() => {
    const cy = cyRef.current;
    if (!cy) return;
    const q = search.trim().toLowerCase();
    cy.batch(() => {
      cy.elements().removeClass("search-hit search-dim");
      if (q) {
        const hits = cy.nodes().filter((n) => String(n.data("name") ?? "").toLowerCase().includes(q));
        if (hits.nonempty()) {
          cy.elements().addClass("search-dim");
          hits.removeClass("search-dim").addClass("search-hit");
          hits.connectedEdges().removeClass("search-dim");
        }
      }
    });
    if (q) {
      const hits = cy.nodes().filter((n) => String(n.data("name") ?? "").toLowerCase().includes(q));
      if (hits.nonempty()) cy.animate({ fit: { eles: hits, padding: 140 }, duration: 400, easing: "ease-out" });
    }
  }, [search, elementsKey]);

  // Bind listeners per cy *instance*. react-cytoscapejs calls this on every
  // render (same instance -> no-op), but StrictMode and element churn can create
  // a fresh instance; if we bound only once, taps would be lost on the new one.
  const registerCy = (cy: Core) => {
    if (cyRef.current === cy) return;
    cyRef.current = cy;
    if (import.meta.env.DEV) (window as unknown as { __cy?: Core }).__cy = cy;

    cy.on("tap", "node", (e) => onSelectRef.current?.(e.target.id()));
    cy.on("tap", (e) => {
      if (e.target === cy) onBackgroundRef.current?.();
    });
    cy.on("mouseover", "node", (e) => e.target.connectedEdges().addClass("show-label"));
    cy.on("mouseout", "node", (e) => {
      if (e.target.id() !== selectedRef.current) {
        e.target.connectedEdges().removeClass("show-label");
      }
    });
  };

  return (
    <div className="graph-canvas">
      {!fontsReady && <div className="graph-loading">Lighting the candles…</div>}
      <CytoscapeComponent
        elements={elements}
        stylesheet={stylesheet}
        layout={{ name: "preset" }}
        cy={registerCy}
        minZoom={0.15}
        maxZoom={2.5}
        wheelSensitivity={0.2}
        style={{ width: "100%", height: "100%" }}
      />
      <Legend />
    </div>
  );
}
