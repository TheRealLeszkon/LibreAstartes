package com.liberastartes.node;

import java.util.List;
import java.util.Map;

/**
 * Full details for a single node: its own properties (plus computed {@code type})
 * and its relationships grouped by kind. Each related entry is a map projection
 * carrying at least {@code id}, {@code name} and {@code type}.
 */
public record NodeDetails(
        Map<String, Object> node,
        Map<String, Object> legion,
        List<Map<String, Object>> allegiance,
        List<Map<String, Object>> devotion,
        List<Map<String, Object>> events,
        List<Map<String, Object>> kills,
        List<Map<String, Object>> deaths,
        List<Map<String, Object>> members,
        List<Map<String, Object>> primarch,
        List<Map<String, Object>> connections) {
}
