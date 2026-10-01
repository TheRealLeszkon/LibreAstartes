package com.liberastartes.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Optional graph filters. Every field may be null / empty, in which case it
 * imposes no constraint. Converted to Cypher parameters so filtering happens
 * on the server in Cypher, never via string concatenation.
 */
public record GraphFilters(
        List<String> types,
        String allegiance,
        List<String> legions,
        List<String> gods,
        List<String> events,
        String q) {

    /** Node types shown by default — everything except Allegiance (hub clutter). */
    public static final List<String> DEFAULT_TYPES = List.of(
            "Emperor", "Primarch", "Astartes", "Dreadnought",
            "Legion", "ChaosGod", "Event");

    /**
     * Build the Cypher parameter map. Empty collections and blank strings become
     * {@code null} so the {@code ($param IS NULL OR ...)} clauses short-circuit.
     */
    public Map<String, Object> toParams() {
        Map<String, Object> p = new HashMap<>();
        p.put("types", (types == null || types.isEmpty()) ? DEFAULT_TYPES : types);
        p.put("allegiance", blankToNull(allegiance));
        p.put("legions", emptyToNull(legions));
        p.put("gods", emptyToNull(gods));
        p.put("events", emptyToNull(events));
        p.put("q", blankToNull(q));
        return p;
    }

    private static Object emptyToNull(List<String> list) {
        return (list == null || list.isEmpty()) ? null : list;
    }

    private static Object blankToNull(String s) {
        return (s == null || s.isBlank()) ? null : s;
    }
}
