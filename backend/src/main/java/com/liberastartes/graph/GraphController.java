package com.liberastartes.graph;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.liberastartes.common.GraphFilters;
import com.liberastartes.common.GraphResponse;

@RestController
@RequestMapping("/api/graph")
public class GraphController {

    private final GraphService graphService;

    public GraphController(GraphService graphService) {
        this.graphService = graphService;
    }

    @GetMapping
    public GraphResponse graph(
            @RequestParam(required = false) List<String> types,
            @RequestParam(required = false) String allegiance,
            @RequestParam(required = false) List<String> legions,
            @RequestParam(required = false) List<String> gods,
            @RequestParam(required = false) List<String> events,
            @RequestParam(required = false) String q) {
        return graphService.graph(new GraphFilters(types, allegiance, legions, gods, events, q));
    }

    @GetMapping("/legion/{legionId}")
    public GraphResponse legionGraph(
            @PathVariable String legionId,
            @RequestParam(required = false) List<String> types,
            @RequestParam(required = false) String allegiance,
            @RequestParam(required = false) List<String> legions,
            @RequestParam(required = false) List<String> gods,
            @RequestParam(required = false) List<String> events,
            @RequestParam(required = false) String q) {
        return graphService.legionGraph(legionId,
                new GraphFilters(types, allegiance, legions, gods, events, q));
    }
}
