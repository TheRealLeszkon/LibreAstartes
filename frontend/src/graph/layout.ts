// fcose layout tuned for a legible, well-spread lore graph.
export function fcoseLayout(animate: boolean): Record<string, unknown> {
  return {
    name: "fcose",
    quality: "proof",
    animate,
    animationDuration: 500,
    animationEasing: "ease-out",
    randomize: true,
    fit: true,
    padding: 70,
    nodeSeparation: 400,
    idealEdgeLength: 300,
    nodeRepulsion: 90000,
    gravity: 0.045,
    gravityRange: 4.0,
    numIter: 4500,
    packComponents: true,
    uniformNodeDimensions: false,
  };
}
