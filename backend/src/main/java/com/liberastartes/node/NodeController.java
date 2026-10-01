package com.liberastartes.node;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.liberastartes.common.GraphResponse;
import com.liberastartes.graph.GraphService;

@RestController
@RequestMapping("/api/nodes")
public class NodeController {

    private final NodeService nodeService;
    private final GraphService graphService;

    public NodeController(NodeService nodeService, GraphService graphService) {
        this.nodeService = nodeService;
        this.graphService = graphService;
    }

    @GetMapping("/{id}")
    public NodeDetails details(@PathVariable String id) {
        return nodeService.details(id);
    }

    @GetMapping("/{id}/neighbours")
    public GraphResponse neighbours(@PathVariable String id,
                                    @RequestParam(defaultValue = "1") int depth) {
        return graphService.neighbours(id, depth);
    }
}
