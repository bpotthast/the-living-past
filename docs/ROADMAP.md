# Roadmap — First 10 Sessions

These are milestones, not literal calendar days — check items off as they're
actually done, regardless of how many sittings a step takes.

- [x] **Day 0 — Planning.** Reviewed project brief, resolved open design
      questions, wrote `V1_TECHNICAL_SPEC.md`, set up `docs/`.
- [x] **Day 1 — Establish the workshop.** Python, VS Code, Git, GitHub,
      venv, SQLite. Repo skeleton. Trivial app that runs and commits.
- [ ] **Day 2 — Design the historical world.** `WORLD_MODEL.md`: entities,
      properties, relationships, reviewed and critiqued before building.
- [ ] **Day 3 — Build the database.** SQLite tables per `V1_TECHNICAL_SPEC.md`
      §5. Seed dataset: ~10 people, ~10 places, ~10 events, ~5 objects.
      Query relationships via SQL.
- [ ] **Day 4 — Build the rabbit hole.** CLI: search, view an entity,
      navigate to related entities.
- [ ] **Day 5 — Add sources.** Display source info per entity.
- [ ] **Day 6 — Add time.** Query events within a date range.
- [ ] **Day 7 — Add the map.** FastAPI + Leaflet web interface. Click a
      place, see its history.
- [ ] **Day 8 — Combine time, space, and relationships.** Navigate freely
      among time / place / event / person / object.
- [ ] **Day 9 — Introduce Claude.** Retrieval-grounded AI explanations of
      supplied historical context.
- [ ] **Day 10 — First historical expedition.** Stop building. Actually
      explore something (Pompeii, Antikythera Mechanism, Fall of
      Constantinople, etc.) and see whether the rabbit-hole experience
      actually works.

See `V1_TECHNICAL_SPEC.md` §12 for the full Day 10 acceptance criteria.
