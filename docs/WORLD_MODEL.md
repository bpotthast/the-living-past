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
- occupation_title (TEXT)

### place
- id (INTEGER, PK)
- name (TEXT, NOT NULL)
- historical_names (TEXT, comma delimited)
- lat (NUMERIC, nullable)
- long (NUMERIC, nullable)
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
- create_date (INTEGER, nullable)
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