# Decisions Log

Append-only. Newest entries at the top. Never edit or delete a past entry —
if a decision is later reversed, add a new entry that says so and links back
to the one it replaces.

Format per entry: what was decided, why, and what the alternatives were.

---

## 2026-08-24 — Add culture_topic_culture_topic_relationships table

**Decision:** Added a new self-referencing join table,
culture_topic_culture_topic_relationships, following the same pattern
already used for person_person_relationships and
event_event_relationships. Added sub_topic_of to relation_type_vocabulary.

**Why:** Discovered mid-seed-data-entry that culture_topic was the only
entity type in the original schema without a way to relate to itself.
Every other entity table (person, event) already had this. Without it,
there was no way to express that a narrower topic (e.g. "Rule of Julius
Caesar") is a sub-topic of a broader one (e.g. "Roman Politics" ->
"Roman Republic") as a real, queryable relationship — only as
unstructured text in a description field, which the rabbit-hole
navigation can't traverse.

**Alternatives considered:** Describing the hierarchy only in each
topic's free-text description — rejected, since it wouldn't be a real
traversable link and defeats the purpose of the relational model.

**Status:** Live — added to schema.sql and applied to living_past.db.

## 2026-08-24 — Join tables use a 3-column composite primary key: (entity_a_id, entity_b_id, relation_type)

**Decision:** All relationship join tables use
`PRIMARY KEY (entity_a_id, entity_b_id, relation_type)` rather than a
surrogate `id` column or a 2-column composite key on the entity IDs alone.

**Why:** A 2-column composite key on just the two entity IDs would
prevent a single pair of entities from having more than one relationship
type — but that's a real case, not a hypothetical: Romulus and Remus are
both `sibling_of` and (per legend) `enemies_with` at once. Including
`relation_type` in the key allows multiple distinct relationships between
the same pair, while still preventing the exact same relationship
(same pair + same relation_type) from being inserted twice by accident.
A surrogate `id` alone would allow that exact duplicate silently.

**Alternatives considered:** Surrogate `id` primary key, no composite
uniqueness enforced — simplest, but allows accidental duplicate rows.
2-column composite key (entity_a_id, entity_b_id) — actively incorrect
for tables like person_person_relationships where a pair can legitimately
hold multiple relation_types.

**Status:** Applies to all relationship join tables going forward,
starting Day 3.

## 2026-08-24 — Replace person.occupation_title with person_title_history

**Decision:** Remove the single `occupation_title` TEXT column from
`person`. Add a new table, `person_title_history`, allowing a person to
hold multiple titles over time, each with its own date range and
optional link to the culture/polity the title belongs to.

**Why:** A single text field can't represent someone who held different
roles at different times (Eisenhower: General 1945–48, then President
1953–61) or simultaneous roles (Napoleon: General and Emperor at once).
This isn't a hypothetical edge case — Julius Caesar, already in the Day
3 seed sketch, held consul and dictator at different points. Discovered
before seed data entry began, so caught early rather than as a later
migration.

Deliberately NOT solving cross-culture title definitions (what
"President" means differs between the US and France; what "King" means
differs between George III and Charles III) as a separate controlled-
vocabulary/definitions system. Scoping each title row to a
`culture_topic_id` and letting title stay freetext (same pattern as
`relation_type`) disambiguates by context without inventing a formal
title taxonomy. A dedicated title-definitions system stays backlogged
if it turns out to be needed later.

**Alternatives considered:** Keeping `occupation_title` as a quick-
summary field alongside the new table — rejected as duplicate sources of
truth for the same information; `person_title_history` becomes the sole
source, with app-layer code responsible for showing a "current/primary"
title if a summary view is ever needed.

**Status:** In progress — Day 3, before seed data entry.

## 2026-08-24 — Mythology gets its own schema, separate from fictional_universe

**Decision:** Backlogged mythology/religion as a third category —
`mythos` and `deity_figure` tables — rather than reusing
`fictional_universe`. `mythos` links back to a real `culture_topic` row
(e.g. Greek Mythology → Ancient Greek Religion); `fictional_universe`
does not link to real culture at all.

Two separate relationship tables for `deity_figure`, not one:
`deity_relationships` for same-mythos genealogy/relations (Zeus father
of Hercules, sibling of Hades), and `mythos_comparison_relationships`
for cross-mythos comparison (Zeus parallels Odin). Same reasoning as
keeping `alternate_history` and `fictional_universe` separate — "family
relationships within one belief system" and "scholarly comparison across
two belief systems" are different kinds of claims and shouldn't share a
table.

**Why:** A myth and an authored fictional world are different kinds of
claims. Middle-earth is fiction Tolkien knew was fiction. Greek
mythology was genuinely believed and practiced by a real historical
culture — the belief system itself is a real historical fact, even
though the deities within it aren't independently verifiable the way a
historical person is. Bucketing deity figures the same way as Bilbo
Baggins would blur the established_fact / scholarly_interpretation /
disputed / speculation distinction the provenance model already relies
on for V1. Keeping mythology separate, and explicitly tied back to real
culture_topic, keeps that distinction intact.

Splitting `deity_relationships` from `mythos_comparison_relationships`
follows the same logic one level down: `deity_relationships` mirrors the
existing `person_person_relationships` pattern (same-universe, intra-
mythos), while `mythos_comparison_relationships` is the first
relationship table in the project designed to intentionally cross
universe/mythos boundaries — every other relationship table so far
assumes both sides belong to the same universe.

**Alternatives considered:** Reusing `fictional_universe` for
mythologies too — simpler, one less table pair, but forces a false
equivalence between authored fiction and historical religious belief,
and gives up the tie back to real culture_topic that makes "compare
Greek and Norse mythology" a meaningful historical-exploration feature
rather than just a fiction-browsing feature. For the relationship split:
a single `deity_relationships` table with a same-mythos/cross-mythos
flag column — rejected because a boolean flag doesn't stop someone from
mislabeling a cross-mythos row as same-mythos, whereas separate tables
make the distinction structural rather than a value that can be wrong.

**Status:** Backlogged (V2). No implementation, no changes to current V1
schema.

## 2026-08-24 — Alternate history and fictional universes: separate schemas, not one shared "universe" concept

**Decision:** Backlogged two separate future tables — `alternate_history`
and `fictional_universe` — rather than a single unified `universe`/
`reality` table covering both. Each existing entity table would eventually
get two nullable FKs (`alternate_history_id`, `fictional_universe_id`)
rather than one shared FK to a common table.

**Why:** The two ideas are structurally similar (both are "this entity
doesn't belong to real baseline history") but conceptually distinct in a
way that matters for correctness. An alternate history is real history
with one thing changed — it inherits everything upstream of its
divergence point and only diverges from there. A fictional universe
shares nothing with real history except, sometimes, a real-world creator
(Tolkien, GRRM) — there's no shared timeline to diverge from. Collapsing
both into one table risks either forcing fictional universes to fake a
divergence point they don't have, or forcing alternate histories to
duplicate everything instead of inheriting from baseline. Keeping them
separate, even at the cost of near-duplicate table shapes, keeps each
concept honest about what it actually is.

**Alternatives considered:** A single shared `universe` table with a
`universe_type` discriminator column (`baseline` | `alternate_history` |
`fictional`) — appealing for reducing schema sprawl, but risks nullable
columns that only make sense for one type (`diverged_from_event_id` is
meaningless for a fictional universe) and blurs a distinction that's
worth keeping explicit. Revisit only if, once actually built, the two
turn out to need identical query patterns and the duplication becomes a
real maintenance burden rather than a theoretical one.

**Status:** Both concepts remain fully backlogged (V2) — no implementation
work started, no schema changes made to the current V1 tables.

## 2026-08-23 — Track schema.sql + seed scripts, not the binary .db file

**Decision:** `data/schema.sql` (and a future seed script) are tracked in
Git; the generated `living_past.db` file itself stays gitignored, per the
note already left in `.gitignore`.

**Why:** SQLite `.db` files are binary — Git can't produce a meaningful
diff when a row or column changes, and merge conflicts on a binary file
are effectively unresolvable. Treating the `.db` as a build artifact,
regenerated from `schema.sql` via `sqlite3 living_past.db ".read schema.sql"`,
keeps the database itself out of version control while keeping every
structural change fully readable and diffable.

**Alternatives considered:** Tracking the `.db` file directly — simpler on
day one, but loses diffability and risks unresolvable binary merge
conflicts as the project continues.

## 2026-08-23 — object.create_date is NOT NULL, matching event.start_date

**Decision:** `object.create_date` is `NOT NULL`, using `create_precision`
(`exact`/`circa`/`decade`/`century`) to express uncertainty rather than
allowing the date itself to be absent. This overrides the nullable
`create_date` originally sketched in `WORLD_MODEL.md`; that doc has been
updated to match.

**Why:** Same reasoning already applied to `event.start_date` — a loosely
precise estimate (e.g. `century`) can be given even for genuinely
uncertain objects, so `NULL` is unnecessary and would introduce an
inconsistent way of expressing "unknown" across entity tables.

**Alternatives considered:** Nullable `create_date` (the original
`WORLD_MODEL.md` sketch) — rejected for consistency with the `event` table
and because a rough estimate is realistically always assignable.

## 2026-08-23 — historical_names stored as comma-delimited TEXT for V1

**Decision:** `place.historical_names` is a single comma-delimited TEXT
column for V1, not a separate `place_historical_names` table.

**Why:** Simpler for the current small seed dataset and matches V1's
"start conventional" philosophy. Not easily queryable (can't cleanly
`WHERE`-match an individual historical name without fragile `LIKE`
matching), but that limitation isn't hit yet at this scale.

**Alternatives considered:** A dedicated `place_historical_names` table,
one row per name, joined to `place` — the more correct relational
approach, but unnecessary complexity before the dataset actually needs
it. Revisit and migrate to this once historical-name lookups become a
real use case.

## 2026-08-23 — Remove event_object_relationships table

**Decision:** Removed "event_object_relationships" table from v1 scope. 

**Why:** There is no use case for this table with the v1 dataset, removed table to reduce initial complexity. 


## 2026-08-23 — Defer source_subtype list to v1.x

**Decision:** Source_subtype will be freetext for v1. This is also being added to BACKLOG.md for v1.x scope

**Why:** Too many possible subtypes to solidify a subset list. This is unnecessary complexity for the current v1 delivery. 

**Alternatives considered:** (historical item [letter/diary/speech], official records [census data, survey results, lab notes], media [photo, audio recording, poem], book, critique, article, reference material [encyclopedia], guides [textbook, alminac, directory])

## 2026-08-23 — Omit discovery_precision field

**Decision:** Do not include discovery_precision as part of object table. 

**Why:** Assumed that all discovery dates are well documented. Will add discovery_precision at a later time if needed.


## 2026-08-19 — Source/provenance granularity: entity-level + per-claim flags

**Decision:** Every entity carries entity-level sources by default. A
narrower, optional mechanism allows flagging *specific* contested claims
(a birth date, a motive, an attribution) with a confidence level
(established fact / scholarly interpretation / disputed / speculation),
used only where a claim is genuinely contentious.

**Why:** Confidence is really a property of individual claims, not whole
entities — a Person can have both rock-solid facts and disputed ones. Full
claim-level provenance for every field would be more correct but is more
than V1 needs.

**Alternatives considered:** Entity-level only (simpler, but loses nuance);
full per-field provenance on every field (too heavy for V1).

## 2026-08-19 — Relationship storage: typed join tables, keyed by entity pair

**Decision:** Relationships are stored in explicit SQLite join tables, one
per *pair* of entity types (e.g. `person_event_relationships`), with a
`relation_type` text column carrying the specific verb inside each table.
Start with ~8 pair tables covering the relationships actually used in the
Day 3 seed dataset; add more pairs only when real data needs them.

**Why:** A single generic `relationships` table loses real foreign-key
integrity (a column can't reference multiple tables at once). A table per
exact verb doesn't scale — too many tables too fast. Typed-by-pair is the
middle ground: real FKs, bounded table count.

**Alternatives considered:** Single generic edges table (rejected — no FK
integrity); table per relationship verb (rejected — table sprawl); a graph
database (rejected — unnecessary at this scale and against the "start
conventional" principle).

## 2026-08-19 — Fifth entity type: Culture/Topic

**Decision:** Added a fifth entity type, Culture/Topic, alongside Person,
Place, Event, and Object. Covers civilizations, polities, and fields/themes
(e.g. "Hellenistic Greece," "Ancient Greek astronomy") that don't fit the
other four types but show up naturally in exploration paths.

**Why:** The example rabbit hole in the original project brief itself
required nodes like "Hellenistic Greece" that aren't people, places, events,
or objects. Scope is intentionally loose for V1 — refine once Day 3 data
shows how it's actually used.

**Alternatives considered:** Modeling these as tags/labels on existing
entities instead of first-class nodes; excluding abstract entities from V1
entirely and only linking concrete things.

## 2026-08-19 — Temporal model: astronomical year integer + precision field

**Decision:** Dates are stored as a signed integer astronomical year
(44 BCE = -43), not SQLite's native date functions, paired with a
`precision` field (`exact`, `circa`, `decade`, `century`).

**Why:** SQLite's date functions don't support BCE/negative years. A
precision field lets uncertain dates be represented honestly instead of
forcing false exactness.

**Alternatives considered:** Storing raw text dates (rejected — not
queryable/sortable); full multi-calendar-system modeling (rejected —
out of scope for V1).
