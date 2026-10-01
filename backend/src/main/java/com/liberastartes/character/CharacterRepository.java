package com.liberastartes.character;

import org.springframework.data.neo4j.repository.Neo4jRepository;

/** CRUD-only repository for Character nodes. */
public interface CharacterRepository extends Neo4jRepository<CharacterEntity, String> {
}
