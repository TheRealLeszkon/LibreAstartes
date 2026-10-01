// Uniqueness constraints on the stable slug `id` for every label.
// Idempotent: IF NOT EXISTS. Characters carry two labels, so constrain the
// specific subtype labels as well as the base Character label.
CREATE CONSTRAINT character_id IF NOT EXISTS FOR (n:Character) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT emperor_id IF NOT EXISTS FOR (n:Emperor) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT primarch_id IF NOT EXISTS FOR (n:Primarch) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT astartes_id IF NOT EXISTS FOR (n:Astartes) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT dreadnought_id IF NOT EXISTS FOR (n:Dreadnought) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT custodes_id IF NOT EXISTS FOR (n:Custodes) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT sisters_id IF NOT EXISTS FOR (n:SistersOfSilence) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT mechanicum_id IF NOT EXISTS FOR (n:Mechanicum) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT imperialis_id IF NOT EXISTS FOR (n:Imperialis) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT daemon_id IF NOT EXISTS FOR (n:Daemon) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT legion_id IF NOT EXISTS FOR (n:Legion) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT chaosgod_id IF NOT EXISTS FOR (n:ChaosGod) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT event_id IF NOT EXISTS FOR (n:Event) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT allegiance_id IF NOT EXISTS FOR (n:Allegiance) REQUIRE n.id IS UNIQUE;
