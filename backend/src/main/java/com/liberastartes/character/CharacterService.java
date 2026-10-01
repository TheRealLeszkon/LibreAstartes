package com.liberastartes.character;

import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.liberastartes.node.NodeDetails;
import com.liberastartes.node.NodeService;

@Service
public class CharacterService {

    /** Subtype labels a character may carry (second label alongside :Character). */
    // Character subtype labels that CRUD may apply (Daemon is not a Character).
    private static final Set<String> ALLOWED_TYPES = Set.of(
            "Astartes", "Dreadnought", "Primarch", "Emperor",
            "Custodes", "SistersOfSilence", "Mechanicum", "Imperialis");

    private final CharacterRepository repository;
    private final Neo4jClient neo4j;
    private final NodeService nodeService;

    public CharacterService(CharacterRepository repository, Neo4jClient neo4j, NodeService nodeService) {
        this.repository = repository;
        this.neo4j = neo4j;
        this.nodeService = nodeService;
    }

    public NodeDetails create(CharacterRequest req) {
        String type = validatedType(req);
        String id = slug(req);
        if (repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "A node with id '" + id + "' already exists");
        }
        CharacterEntity entity = new CharacterEntity();
        entity.setId(id);
        apply(entity, req);
        repository.save(entity);

        // Add the subtype label (type is whitelisted, so safe to interpolate).
        neo4j.query("MATCH (c:Character {id: $id}) SET c:`" + type + "`").bind(id).to("id").run();
        attachLegion(id, req);
        return nodeService.details(id);
    }

    public NodeDetails update(String id, CharacterRequest req) {
        CharacterEntity entity = repository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No character with id " + id));
        validatedType(req); // still require a valid type in the payload
        apply(entity, req);
        repository.save(entity);
        attachLegion(id, req);
        return nodeService.details(id);
    }

    public void delete(String id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No character with id " + id);
        }
        repository.deleteById(id); // DETACH DELETE on the :Character node
    }

    private void attachLegion(String id, CharacterRequest req) {
        if (req.legionId() != null && !req.legionId().isBlank()) {
            neo4j.query("""
                    MATCH (c:Character {id: $id}), (l:Legion {id: $legionId})
                    MERGE (c)-[r:MEMBER_OF]->(l)
                    SET r.role = $role
                    """)
                    .bindAll(Map.of("id", id, "legionId", req.legionId(), "role",
                            req.role() == null ? "" : req.role()))
                    .run();
        }
    }

    private static void apply(CharacterEntity e, CharacterRequest req) {
        e.setName(req.name());
        e.setSubtitle(req.subtitle());
        e.setDescription(req.description());
        e.setMotivations(req.motivations());
        e.setFate(req.fate());
        e.setLoreNote(req.loreNote());
        e.setImage(req.image());
    }

    private static String validatedType(CharacterRequest req) {
        String type = req.type() == null ? "" : req.type().trim();
        if (!ALLOWED_TYPES.contains(type)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "type must be one of " + ALLOWED_TYPES);
        }
        return type;
    }

    private static String slug(CharacterRequest req) {
        String base = (req.id() != null && !req.id().isBlank()) ? req.id() : req.name();
        String s = base.toLowerCase(Locale.ROOT)
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("(^-|-$)", "");
        if (s.isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Could not derive a slug id from the name");
        }
        return s;
    }
}
