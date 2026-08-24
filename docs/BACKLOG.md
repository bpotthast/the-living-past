# Backlog

Ideas that aren't part of the current build, sorted by which future version
they most plausibly belong to. When a new idea comes up mid-session, it goes
here instead of into the current scope — see `V1_TECHNICAL_SPEC.md` for what
V1 actually is.

## V1.x (small enhancements after V1 ships, before V1.5's AI layer)

- source_subtype list. Possible options include (historical item [letter/diary/speech], official records [census data, survey results, lab notes], media [photo, audio recording, poem], book, critique, article, reference material [encyclopedia], guides [textbook, almanac, directory])

## V1.5 — AI Historical Guide

- Retrieval strategy design: how the app decides what structured context to
  hand the LLM for a given question (deferred from Day 9's simpler version)

## V2 — Alternate Timelines

- Alternate timeline divergence points (original concept — real history
  as baseline, user picks a divergence event, explores how things unfold
  differently from there)
- **Companion concept — Fictional Universe exploration** (kept as a
  separate schema/system from alternate history, not merged, even though
  the two will likely share a similar table shape): support entities and
  relationships scoped to a wholly separate fictional reality (Middle-
  earth, Westeros) rather than a divergence from real history. Entry
  point: discover a fictional-work relationship on a real person (e.g.
  Tolkien → authored → The Hobbit) and descend into that universe's own
  explorable graph. See WORLD_MODEL.md notes for a conceptual schema
  sketch of both.
   - Conceptual schema sketch (two separate tables, same general shape):
		Alternate_History
		- id (PK)
		- name (TEXT)                          -- "No Rubicon Crossing"
		- description (TEXT)
		- diverged_from_event_id (FK -> event.id)   -- the real-history fork point
		- divergence_description (TEXT)

		fictional_universe
		- id (PK)
		- name (TEXT)                          -- "Middle-earth", "Westeros"
		- description (TEXT)
		- creator_person_id (FK -> person.id)  -- Tolkien, GRRM (a real-history person)
		- source_work (TEXT or FK to a future `work` entity)

		Then each existing entity table (person, place, event, object, culture_topic) would eventually get two nullable FKs, not one shared column:

		alternate_history_id  (FK -> alternate_history.id, nullable)
		fictional_universe_id (FK -> fictional_universe.id, nullable)
- **Mythology & religion exploration.** Own category, not folded into
  fictional_universe — myths were genuinely believed/practiced by real
  historical cultures, unlike authored fiction, and that distinction
  matters for the provenance model. New entities: `mythos` (Greek
  Mythology, Norse Mythology — each tied back to a real `culture_topic`
  row) and `deity_figure` (Zeus, Odin, etc., scoped to a mythos). New
  capability, not just new tables: cross-mythos comparison — a
  relationship type that spans two different mythologies (e.g. Zeus
  parallels Odin as a sky/king-of-gods archetype), which none of the
  existing same-universe relationship tables support. See
  WORLD_MODEL.md sketch and DECISIONS.md (2026-08-24) for the schema and
  reasoning.		


## V3 — Interactive Historical Storytelling

_(none yet — see original project brief for the general concept)_

## V4 — Living Historical Worlds

_(none yet — see original project brief for the general concept)_

## Future / Unscheduled

- **Mobile support.** Not tied to any specific version tier — it's a
  delivery/platform concern, not a content milestone. Likely path: responsive
  CSS on the Day 7+ web UI, possibly a PWA wrapper later. No case for a
  native app unless a concrete reason shows up. Revisit once the web
  interface is stable, not before.
- Full-text search (SQLite FTS5) — only if plain `LIKE` search turns out to
  be inadequate
- Constrained vocabulary for `relation_type` values (currently free text)
- Additional relationship-pair tables beyond the initial eight in
  `V1_TECHNICAL_SPEC.md` §5
