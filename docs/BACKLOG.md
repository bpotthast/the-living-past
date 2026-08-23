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

_(none yet — see original project brief for the general concept)_

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
