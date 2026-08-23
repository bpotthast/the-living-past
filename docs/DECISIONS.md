# Decisions Log

Append-only. Newest entries at the top. Never edit or delete a past entry —
if a decision is later reversed, add a new entry that says so and links back
to the one it replaces.

Format per entry: what was decided, why, and what the alternatives were.

---
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
