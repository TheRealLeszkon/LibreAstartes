package com.liberastartes.common;

import java.util.Map;

/**
 * A Cytoscape element — a node or an edge — in the shape Cytoscape.js expects:
 * {@code { "data": { ... } }}. The {@code data} map is built by a Cypher map
 * projection, so the API never leaks Neo4j internal ids.
 */
public record CyElement(Map<String, Object> data) {
}
