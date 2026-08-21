# Decisions Log

Append-only. Newest entries at the top. Never edit or delete a past entry —
if a decision is later reversed, add a new entry that says so and links back
to the one it replaces.

Format per entry: what was decided, why, and what the alternatives were.

---

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
