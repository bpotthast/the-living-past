# The Living Past — V1 Technical Specification

Status: DRAFT — for review before Day 1 begins
Last updated: 2026-08-19

---

## 1. V1 Goal

Build a factually grounded, source-aware historical exploration tool. A user
enters history through a time, place, person, event, or object, and follows
relationships outward into a self-directed "rabbit hole." V1 is not a game
and does not simulate history — it retrieves and displays real historical
information and lets the user navigate its connections.

Success is experiential, not just functional: starting from one entity, a
curious user should want to keep clicking.

## 2. Non-Goals (V1)

Explicitly out of scope for this build:

- Alternate history / branching timelines (V2)
- RPG mechanics, character creation, NPCs, roleplay (V3)
- Civilization simulation, autonomous agents, persistent worlds (V4)
- Voice interfaces, local LLMs, vector databases / embeddings
- Large-scale historical datasets — V1 uses a small curated set
- Cloud infrastructure, authentication, user accounts, monetization
- Polished UI/UX — functional and legible is sufficient
- A graph database — SQLite with explicit join tables is sufficient at this scale

## 3. Core User Experience

Entry points: time ("the world around 44 BCE"), place ("Rome"), event
("Battle of Hastings"), person ("Julius Caesar"), object ("Antikythera
Mechanism"). From any entity, the user sees its related entities and can move
to any of them, indefinitely.

Example traversal:

```
Julius Caesar → Roman Civil War → Battle of Pharsalus → Pompey
→ Egypt → Alexandria → Cleopatra → Ptolemaic Egypt → Hellenistic World
```

## 4. Entity Types

Five entity types in V1 (Culture/Topic added to cover civilizations,
periods, and abstract subjects like "Ancient Greek astronomy" that don't fit
Person/Place/Event/Object but appear naturally in real exploration paths):

**Person** — name, birth, death (with precision, see §6), description,
occupation/title, sources.

**Place** — name, historical name(s), lat/long (nullable — not every site has
confident coordinates), description, sources.

**Event** — name, start date, end date (nullable), description, causes,
consequences (free text in V1; structured causal links are relationship
rows, see §5), sources.

**Object** — name, type, estimated date, discovery location, current
location, description, sources.

**Culture/Topic** — name, description, approximate time span, sources.
Covers civilizations (Hellenistic Greece), polities (Roman Republic), and
fields/phenomena (Ancient Greek astronomy, Mediterranean trade). Deliberately
loose scope for V1 — refine after Day 3 data reveals actual usage patterns.

All five share a `sources` relationship (§7) and get their own SQLite table.

## 5. Relationship Model

Explicit join tables, typed by **entity-type pair**, with a `relation_type`
text column carrying the specific verb. This keeps real foreign-key
integrity (unlike a single generic edges table) without a table per verb
(unlike a table per exact relationship name).

Initial set — build only the pairs the Day 3 dataset actually needs:

```
person_event_relationships    (person_id, event_id, relation_type)
event_place_relationships     (event_id, place_id, relation_type)
person_place_relationships    (person_id, place_id, relation_type)
event_event_relationships     (event_a_id, event_b_id, relation_type)
object_place_relationships    (object_id, place_id, relation_type)
object_person_relationships   (object_id, person_id, relation_type)
object_culture_relationships  (object_id, culture_id, relation_type)
person_person_relationships   (person_a_id, person_b_id, relation_type)
```

Directional relationships (e.g. `event_event.preceded`) store one row;
symmetric relationships (e.g. `person_person.related_to`) also store one row,
queried in both directions at the application layer. New verbs cost nothing
(just a new `relation_type` value); new entity-type pairs cost one migration.
More pairs are added only when real data needs them.

## 6. Temporal Model

Dates stored as a signed integer **astronomical year** (44 BCE = -43, 1 CE =
1), avoiding SQLite's native date functions, which don't support BCE. Each
date field is paired with a `precision` value (`exact`, `circa`, `decade`,
`century`) so uncertain dates ("mid-4th century BCE") are representable
without false precision.

V1 does not attempt: multiple calendar systems, disputed-date resolution
logic, or a full temporal-versioning model of how an entity changes over
time (e.g. Rome-in-44-BCE vs Rome-in-410-CE as distinct states). That's
deferred — noted in DECISIONS.md as intentional V1 scope, revisited if the
exploration experience clearly needs it.

## 7. Source & Provenance Model

Two levels:

- **Entity-level sources** (default): every Person/Place/Event/Object/Culture
  has one or more associated sources (name, institution, URL, source type,
  publication info where available), shown whenever the entity is viewed.
- **Per-claim disputed flags** (as-needed): for specific contested facts
  (e.g. a birth date, a motive, an attribution), an optional flag marks that
  particular claim's confidence level — `established_fact`,
  `scholarly_interpretation`, `disputed`, or `speculation` — rather than
  applying one confidence level to the whole entity. Used sparingly, only
  where a claim is genuinely contentious; most fields don't need one.

V1 stores source *metadata*, not full external content — no bulk copying of
museum/archive text or images into the local database.

## 8. UI Requirements

- **Days 1–6:** command-line interface. Search, view an entity, list related
  entities, navigate by selecting one, basic timeline query.
- **Day 7+:** minimal web interface (FastAPI backend, plain HTML/CSS/JS,
  Leaflet + OpenStreetMap for the map view). Clicking a map location shows
  its historical information; clicking a related entity navigates to it.
- No accounts, no styling polish requirement, no mobile support.

## 9. Technology Stack

Python, SQLite, FastAPI, HTML/CSS/JS, Leaflet/OpenStreetMap, Git/GitHub,
Claude API (Day 9+). No PostgreSQL, cloud infra, vector DB, or local LLM in
V1 — introduced only when a concrete V1.x/V2 need justifies it.

## 10. Data Requirements

Small curated seed dataset, entered by hand (not scraped): roughly 10
people, 10 places, 10 events, 5 objects, a handful of cultures/topics, and
enough relationship rows to make traversal actually feel connected —
quality and interconnection matter more than volume.

## 11. AI's Role (Day 9+)

Retrieval before generation: the application fetches relevant structured
entities, relationships, and sources first, and supplies that as context to
the Claude API. The model explains and synthesizes the supplied context — it
is not asked to invent historical facts from general knowledge, and it
should surface uncertainty where the underlying source data reflects it.

## 12. V1 Acceptance Criteria

The prototype can:

- Search for entities across all five types
- Display an entity's details and its sources
- Follow relationships from any entity to related entities, indefinitely
- Query events within a time range
- Show places on a map and drill into their historical information
- Move between people, places, events, objects, and cultures/topics in one
  session
- Answer a contextual historical question using retrieved data, via the
  Claude API

It does not need to be polished, complete, or cover more than the seed
dataset.

## 13. Deferred / Open Items (tracked in DECISIONS.md going forward)

- Full temporal-state modeling of entities changing over time
- Claim-level provenance beyond the "disputed flag" mechanism above
- Constrained vocabulary for `relation_type` values (currently free text)
- Full-text search (SQLite FTS5) — start with plain `LIKE`, upgrade only if
  needed
- Additional relationship-pair tables beyond the initial eight, added as
  real data demands them
