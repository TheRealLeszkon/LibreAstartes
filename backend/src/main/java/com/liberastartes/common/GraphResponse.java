package com.liberastartes.common;

import java.util.List;

/** A filtered graph as Cytoscape-ready elements. */
public record GraphResponse(List<CyElement> nodes, List<CyElement> edges) {
}
