package com.liberastartes.seed;

import java.util.ArrayList;
import java.util.List;

/**
 * Splits a Cypher script into individual statements. Quote-aware so that
 * semicolons inside single-quoted string literals (and {@code //} line
 * comments) do not terminate a statement. Cypher escapes a single quote
 * inside a string by doubling it ({@code ''}).
 */
public final class CypherScript {

    private CypherScript() {
    }

    public static List<String> split(String script) {
        List<String> statements = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inString = false;
        int i = 0;
        int n = script.length();
        while (i < n) {
            char c = script.charAt(i);
            if (inString) {
                if (c == '\\' && i + 1 < n) {
                    // Cypher backslash escape: keep the escaped char verbatim.
                    current.append(c).append(script.charAt(i + 1));
                    i += 2;
                    continue;
                }
                if (c == '\'') {
                    inString = false;
                }
                current.append(c);
                i++;
                continue;
            }
            // Not in a string.
            if (c == '/' && i + 1 < n && script.charAt(i + 1) == '/') {
                // Line comment: skip to end of line.
                while (i < n && script.charAt(i) != '\n') {
                    i++;
                }
                continue;
            }
            if (c == '\'') {
                inString = true;
                current.append(c);
                i++;
                continue;
            }
            if (c == ';') {
                addIfNotBlank(statements, current);
                current.setLength(0);
                i++;
                continue;
            }
            current.append(c);
            i++;
        }
        addIfNotBlank(statements, current);
        return statements;
    }

    private static void addIfNotBlank(List<String> statements, StringBuilder sb) {
        String stmt = sb.toString().trim();
        if (!stmt.isEmpty()) {
            statements.add(stmt);
        }
    }
}
