package com.liberastartes.character;

import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;

/**
 * Shallow CRUD entity for Character nodes. Deliberately maps no relationships,
 * so a save rewrites only this node's properties, never half the graph. The
 * subtype label (Astartes/Dreadnought/…) and any relationships are managed with
 * hand-written Cypher in {@link CharacterService}.
 */
@Node("Character")
public class CharacterEntity {

    @Id
    private String id;
    private String name;
    private String subtitle;
    private String description;
    private String motivations;
    private String fate;
    private String loreNote;
    private String image;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMotivations() {
        return motivations;
    }

    public void setMotivations(String motivations) {
        this.motivations = motivations;
    }

    public String getFate() {
        return fate;
    }

    public void setFate(String fate) {
        this.fate = fate;
    }

    public String getLoreNote() {
        return loreNote;
    }

    public void setLoreNote(String loreNote) {
        this.loreNote = loreNote;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
