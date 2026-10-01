package com.liberastartes.meta;

import java.util.List;
import java.util.Map;

/** Option lists that drive the filter UI. */
public record FilterOptions(
        List<String> types,
        List<Map<String, Object>> legions,
        List<Map<String, Object>> gods,
        List<Map<String, Object>> events) {
}
