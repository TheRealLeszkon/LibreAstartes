package com.liberastartes.character;

import jakarta.validation.constraints.NotBlank;

/**
 * Create/update payload for a character. `type` is the subtype label and is
 * validated against a whitelist before being used in Cypher. `legionId`/`role`
 * optionally attach a MEMBER_OF relationship.
 */
public record CharacterRequest(
        String id,
        @NotBlank(message = "name is required") String name,
        @NotBlank(message = "type is required") String type,
        String subtitle,
        String description,
        String motivations,
        String fate,
        String loreNote,
        String image,
        String legionId,
        String role) {
}
