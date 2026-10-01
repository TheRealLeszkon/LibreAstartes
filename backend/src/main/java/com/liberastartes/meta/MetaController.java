package com.liberastartes.meta;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.liberastartes.common.GraphFilters;

@RestController
@RequestMapping("/api/meta")
public class MetaController {

    private final Neo4jClient neo4j;

    public MetaController(Neo4jClient neo4j) {
        this.neo4j = neo4j;
    }

    @GetMapping("/filters")
    public FilterOptions filters() {
        List<Map<String, Object>> legions = list("""
                MATCH (l:Legion)
                RETURN l {.id, .name, .numeral, .expunged} AS o
                ORDER BY coalesce(l.numeral, '')
                """);
        // Keep legions in Roman-numeral (I..XX) order, which string sort won't do.
        legions.sort((a, b) -> Integer.compare(romanOrder(a), romanOrder(b)));

        List<Map<String, Object>> gods = list("""
                MATCH (g:ChaosGod)
                RETURN g {.id, .name, .color, .kind} AS o
                ORDER BY g.name
                """);

        List<Map<String, Object>> events = list("""
                MATCH (e:Event)
                RETURN e {.id, .name, .order, .era} AS o
                ORDER BY e.order
                """);

        return new FilterOptions(GraphFilters.DEFAULT_TYPES, legions, gods, events);
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> list(String cypher) {
        List<Map<String, Object>> out = new ArrayList<>();
        for (Map<String, Object> row : neo4j.query(cypher).fetch().all()) {
            out.add((Map<String, Object>) row.get("o"));
        }
        return out;
    }

    private static int romanOrder(Map<String, Object> legion) {
        Object n = legion.get("numeral");
        return n == null ? Integer.MAX_VALUE : ROMAN.indexOf(n.toString().trim());
    }

    // Index position == legion order I..XX.
    private static final List<String> ROMAN = List.of(
            "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X",
            "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX");
}
