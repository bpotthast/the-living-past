# World Model — Draft

## Entity Tables
### person
- id (INTEGER, PK)
- name (TEXT, NOT NULL)
- gender (TEXT: Male|Female|Other|Unknown)
- birth_year (INTEGER, nullable)
- death_year (INTEGER, nullable)
- birth_precision (TEXT: Exact|Circa|Decade|Century)
- death_precision (TEXT: Exact|Circa|Decade|Century)
- description (free text)

### person_title_history
- id (INTEGER, PK)
- person_id (FK -> person.id)
- title (TEXT)
- culture_topic_id (FK -> culture_topic.id, nullable)
- start_year (INTEGER)
- end_year (INTEGER, nullable)
- start_precision (TEXT: Exact|Circa|Decade|Century)
- end_precision (TEXT: Exact|Circa|Decade|Century)

### place
- id (INTEGER, PK)
- name (TEXT, NOT NULL)
- historical_names (TEXT, comma delimited)
- latitude (NUMERIC, nullable)
- longitude (NUMERIC, nullable)
- description (TEXT)

### event
- id (INTEGER, PK)
- name (TEXT, NOT NULL)
- start_date (INTEGER)
- end_date (INTEGER, nullable)
- start_precision (TEXT: Exact|Circa|Decade|Century)
- end_precision (TEXT: Exact|Circa|Decade|Century)
- description (TEXT)
- causes (TEXT)
- consequences (free text in V1)

### object
- id (INTEGER, PK)
- name (TEXT, NOT NULL)
- type (TEXT: freetext for V1 - hard set of values to be determined as dataset builds out)
- create_date (INTEGER, NOT NULL)
- create_precision (TEXT: exact|circa|decade|century)
- discovery_date (INTEGER, nullable) //assumed that all discovery dates are well documented. 
- description (TEXT)

### culture_topic
- id (INTEGER, PK)
- name (TEXT, NOT NULL)
- description (TEXT)
- start_year (INTEGER, nullable)
- end_year (INTEGER, nullable)
- start_precision (TEXT: exact|circa|decade|century)
- end_precision (TEXT: exact|circa|decade|century)

### source
- id (INTEGER, PK)
- name (TEXT)
- institution (TEXT)
- url (TEXT)
- source_type (TEXT: Primary|Secondary|Tertiary)
- source_subtype (TEXT) //freetext for v1
- publication_info (nullable)


## Relationship Tables
### person_place_relationships
- person_id (FK -> person.id)
- place_id (FK -> place.id)
- relation_type (TEXT)

### person_person_relationships
- person_a_id (FK -> person.id)
- person_b_id (FK -> person.id)
- relation_type (TEXT)

### person_event_relationships
- person_id (FK -> person.id)
- event_id (FK -> event.id)
- relation_type (TEXT)

### event_event_relationships
- event_a_id (FK -> event.id)
- event_b_id (FK -> event.id)
- relation_type (TEXT)

### person_object_relationships
- person_id (FK -> person.id)
- object_id (FK -> object.id)
- relation_type (TEXT)

### person_culture_topic_relationships
- person_id (FK -> person.id)
- culture_topic_id (FK -> culture_topic.id)
- relation_type (TEXT)

### place_event_relationships
- place_id (FK -> place.id)
- event_id (FK -> event.id)
- relation_type (TEXT)

### place_object_relationships
- place_id (FK -> place.id)
- object_id (FK -> object.id)
- relation_type (TEXT)

### place_culture_topic_relationships
- place_id (FK -> place.id)
- culture_topic_id (FK -> culture_topic.id)
- relation_type (TEXT)

### event_culture_topic_relationships
- event_id (FK -> event.id)
- culture_topic_id (FK -> culture_topic.id)
- relation_type (TEXT)

### object_culture_topic_relationships
- object_id (FK -> object.id)
- culture_topic_id (FK -> culture_topic.id)
- relation_type (TEXT)

### person_source_relationships
- person_id (FK -> person.id)
- source_id (FK -> source.id)

### place_source_relationships
- place_id (FK -> place.id)
- source_id (FK -> source.id)

### event_source_relationships
- event_id (FK -> event.id)
- source_id (FK -> source.id)

### object_source_relationships
- object_id (FK -> object.id)
- source_id (FK -> source.id)

### culture_topic_source_relationships
- culture_topic_id (FK -> culture_topic.id)
- source_id (FK -> source.id)


## relation_type_vocabulary
- participated_in
- owned_by
- governed_over
- took_place_in
- partnered_with
- parent_of
- enemies_with
- sibling_of
- cousin_of
- precedes
- contributed_to
- created_by
- created_in
- discovered_at
- currently_located_at
- member_of
- associated_with
- created_during
- occurred_during
- part_of
- lived_in
- lived_during

## Seed entity sketch
person: Julius Caesar, Cleopatra, Mark Antony
place: Rome, Rubicon River, Alexandria, Egypt
event: First Roman Triumvirate formed, Crossing of the Rubicon River, Battle of Actium
object: Cleopatra's Needles, The Elephant Denarius
culture_topic: Roman Senate, Egyptian Politics, Ancient Rome, Ancient Egypt

## Future / Not Yet Built — V2 backlog sketches

See BACKLOG.md and DECISIONS.md (2026-08-24) for full context. Not part
of the current schema — captured here only so the shape isn't lost.

### alternate_history (sketch)
- id (PK)
- name (TEXT)
- description (TEXT)
- diverged_from_event_id (FK -> event.id)
- divergence_description (TEXT)

### fictional_universe (sketch)
- id (PK)
- name (TEXT)
- description (TEXT)
- creator_person_id (FK -> person.id)
- source_work (TEXT — may become its own `work` entity later; open question)

### Entity table extension (sketch)
Each of person/place/event/object/culture_topic would eventually gain:
- alternate_history_id (FK -> alternate_history.id, nullable)
- fictional_universe_id (FK -> fictional_universe.id, nullable)
(App-layer rule: at most one of these two should be set per entity.)

### mythos (sketch)
- id (PK)
- name (TEXT)                              -- "Greek Mythology", "Norse Mythology"
- associated_culture_topic_id (FK -> culture_topic.id)  -- ties back to real history
- description (TEXT)

### deity_figure (sketch)
- id (PK)
- mythos_id (FK -> mythos.id)
- name (TEXT)                              -- "Zeus", "Odin"
- domain (TEXT)                            -- "sky/thunder", "war", "wisdom"
- description (TEXT)
- (sources via existing source join-table pattern, once built)

### deity_relationships (sketch)
- figure_a_id (FK -> deity_figure.id)
- figure_b_id (FK -> deity_figure.id)
- relation_type (TEXT)   -- father_of, sibling_of, spouse_of, enemies_with
-- Same-mythos genealogy/relationships (Zeus father of Hercules).
-- Kept separate from mythos_comparison_relationships below, which is
-- cross-mythos only (Zeus parallels Odin).

### mythos_comparison_relationships (sketch)
- figure_a_id (FK -> deity_figure.id)
- figure_b_id (FK -> deity_figure.id)
- relation_type (TEXT)                     -- "parallels", "syncretized_with", "analogous_to"
- comparison_notes (TEXT)
-- NOTE: first relationship table designed to cross universe boundaries;
-- every other relationship table so far assumes same-universe entities.

Open questions for whenever this gets built:
- Do myths need their own source-confidence framing distinct from the
  existing established_fact/scholarly_interpretation/disputed/
  speculation flags (e.g. "religious/traditional belief" as a fifth
  category, not a truth-value at all)?
- Does deity_figure need person-style fields (birth/death-equivalent
  events like "Ragnarok") or is that overreach for what's meant to be a
  lightweight comparison feature?