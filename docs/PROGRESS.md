# Progress Log

Append-only. Newest session at the top. At the start of a new session,
paste this top entry into the chat so Claude has context without you
re-explaining the project.

---
## Session 8 — 2026-08-24

What we did: Wrapped up the Claude.ai chat-based phase of the project and prepared the
handoff to Claude Code. Reviewed all project docs for consistency (README, V1_TECHNICAL_SPEC,
ROADMAP, BACKLOG, DECISIONS, PROGRESS, WORLD_MODEL, Cheat Sheet) — no contradictions found,
Day 3 status confirmed accurate everywhere. Created CLAUDE.md at the repo root, condensing
the mentor/three-strikes working style, V1 scope boundaries, established conventions, and
docs map into a single file Claude Code auto-loads each session, replacing the manual
"paste PROGRESS.md" habit used in the chat-based phase.

What I learned: Why a persistent project-context file matters more once the tool itself
has direct file/terminal access — nothing stops a more capable tool from silently building
ahead of scope or skipping the learning-coach pacing unless that's stated somewhere it
will actually read every session.

Where we left off: Day 3 is complete and verified. All docs are current and consistent.
No code changes this session — purely a documentation/handoff session.

Next session should start with: Day 4 in Claude Code — building the CLI exploration
interface (search, view an entity, navigate to related entities) per ROADMAP.md. CLAUDE.md
now provides session-start context automatically.

## Session 7 — 2026-08-24

What we did: Completed Day 3 seed data entry. Populated all 6 entity tables (3
people: Caesar, Cleopatra, Antony; 6 places, including two added mid-session —
Actium and Tusculum — to close gaps discovered while building relationships; 4
events; 5 objects; 14 culture_topics including a full broad-to-narrow hierarchy)
and all 12 relationship join tables, plus person_title_history. Learned and
applied real INSERT syntax: escaping apostrophes with '', keeping numeric columns
unquoted, and the difference between schema.sql's safe re-runnability (via
IF NOT EXISTS) versus seed.sql's lack of any equivalent protection for plain
INSERT statements — addressed by commenting out already-run sections. Hit and
recovered from two real incidents: a repeated typo creating a stray lviing_past.db
file (deleted, harmless), and a real near-miss where an uncommented place section
got re-run accidentally, silently duplicating 4 rows (caught via row-count checks,
cleaned up via targeted DELETE by id). Discovered mid-session that culture_topic
was the only entity type without a self-referencing relationship table, blocking
the desired broad-to-narrow topic hierarchy (e.g. Roman Politics -> Roman
Republic -> Rule of Julius Caesar); added culture_topic_culture_topic_relationships
following the existing person_person/event_event pattern, plus a sub_topic_of
vocabulary entry, and logged the decision. Built a full topic hierarchy including
an intentional dual-parent case (Ptolemaic Kingdom under both Egyptian Politics
and Hellenistic World), made possible by the earlier 3-column composite key
decision. Verified historical facts via web search before entering data
(coordinates, dates, discovery years) rather than relying on memory, catching one
real error along the way (initial Alexandria coordinates pointed to Alexandria,
Virginia, not Egypt). Ran real traversal queries joining person -> event and
person -> event -> place across relationship tables, confirming the schema
actually supports rabbit-hole-style navigation as designed.

What I learned: Why plain INSERT has no re-run safety net the way
CREATE TABLE IF NOT EXISTS does, and why that makes disciplined commenting-out of
already-run sections a real necessity, not just tidiness. How to recover from a
partial duplicate-insert incident safely (verify via SELECT before any DELETE,
delete by specific id rather than by name). Why composite primary keys on
relationship tables catch accidental re-inserts loudly (UNIQUE constraint
failures) while plain-id entity tables don't catch them at all. How to reason
about coordinate ambiguity for real-world place names (Alexandria, Actium) and
verify facts before trusting them. Why a topic can have more than one legitimate
parent in a hierarchy, and how a composite key makes that safely representable.
How to write and read multi-table JOIN queries that walk relationships across
more than one hop.

Where we left off: Full Day 3 dataset is live and verified: 6 entity tables, 12
relationship-pair tables, 5 source-relationship tables (still empty --
person/place/event/object/culture_topic_source_relationships have no rows yet),
and person_title_history, all populated and internally consistent except for the
source tables. Traversal queries confirmed working end-to-end.

Next session should start with: Day 4 -- building a CLI exploration interface
(search, view an entity, navigate to related entities) per ROADMAP.md. Optionally,
populate the source-relationship tables first if source/provenance display is
wanted before the CLI work begins.

## Session 6 — 2026-08-24

What we did: Reviewed WORLD_MODEL.md, DECISIONS.md, and BACKLOG.md updates made in a
separate brainstorming session, and identified one change with real impact on the
live schema: person.occupation_title being replaced by a new person_title_history
table (to support people holding multiple titles over time, e.g. Caesar as consul
then dictator). Performed a live schema migration for the first time — used
ALTER TABLE person DROP COLUMN occupation_title against the running database, and
separately walked through (without needing to use) the older drop/rename/recreate
workaround for SQLite versions that lack DROP COLUMN support. Learned that foreign
keys are not enforced by SQLite unless PRAGMA foreign_keys = ON is set per connection.
Created person_title_history with its first two foreign keys (to person and
culture_topic). Made and logged a schema-wide decision: all relationship join tables
use a 3-column composite primary key (entity_a_id, entity_b_id, relation_type) rather
than a surrogate id or a 2-column composite key, after working through a concrete
case (Romulus & Remus needing both sibling_of and enemies_with as separate rows)
showing why a 2-column key would incorrectly block that scenario. Built all remaining
16 join tables from WORLD_MODEL.md: 11 entity-pair relationship tables
(person_place, person_person, person_event, event_event, person_object,
person_culture_topic, place_event, place_object, place_culture_topic,
event_culture_topic, object_culture_topic) and 5 source-linkage tables
(person/place/event/object/culture_topic_source_relationships), the latter using a
simpler 2-column composite key since they carry no relation_type. Caught and fixed a
repeated typo (source_id_id instead of source_id) across all five source-relationship
tables before running. Ran the complete schema.sql against living_past.db and
verified all 23 tables exist via .tables.

What I learned: The difference between ALTER TABLE ... DROP COLUMN (modern SQLite)
and the older rename/recreate/copy/drop workaround, and why the workaround is
riskier (manual column enumeration, more steps, real data-loss risk on a live
table). Why FOREIGN KEY and PRIMARY KEY have to be separate table-level clauses
rather than inline column modifiers, unlike NOT NULL/CHECK. Why foreign keys aren't
enforced by default in SQLite and have to be turned on per connection. How to reason
about composite primary key design based on the actual semantics of a relationship
(can a pair legitimately have more than one relation_type between them?) rather than
defaulting to one pattern everywhere.

Where we left off: Full schema (23 tables: 6 entity tables, person_title_history,
11 relationship-pair tables, 5 source-relationship tables) is built, verified, and
matches WORLD_MODEL.md and DECISIONS.md. No seed data has been entered yet.

Next session should start with: Seed data entry — translating the Caesar/Cleopatra/
Antony sketch (and remaining people/places/events/objects/cultures to reach
V1_TECHNICAL_SPEC.md §10 targets) into INSERT statements, including the
chicken-and-egg problem of needing entity IDs before relationship rows can reference
them.

## Session 5 — 2026-08-23

What we did: Set up the SQLite CLI (was previously only using the Python sqlite3
library implicitly) — downloaded the Windows precompiled binary, added it to PATH,
verified with sqlite3 --version. Wrote CREATE TABLE statements for all six entity
tables (source, person, place, event, object, culture_topic) in data/schema.sql,
translating the WORLD_MODEL.md sketch into real SQLite syntax. Along the way, fixed
several real dialect mistakes: Postgres/MySQL syntax (SERIAL, VARCHAR(255), ON UPDATE
CURRENT_TIMESTAMP) that isn't valid SQLite; a stray extra parenthesis and a trailing
comma; a PowerShell quirk where the `<` input-redirection operator doesn't work
(resolved via `.read schema.sql`, and switched all six tables to
`CREATE TABLE IF NOT EXISTS` so the whole file can be safely re-run anytime instead of
manually commenting tables in/out). Made and logged several real design decisions:
NULL (not a magic 'Unknown' string) represents unknown birth/death precision;
historical_names stays a single comma-delimited TEXT column for V1, with a dedicated
join table deferred until the dataset needs it; latitude/longitude renamed from
WORLD_MODEL.md's original lat/long; start_date/start_year/create_date are NOT NULL
across event, culture_topic, and object (loose precision values like 'century' can
always be assigned, so NULL is reserved for genuinely absent dates), while end_date/
end_year stay nullable, including recognizing that "open-ended" (US Senate, British
Parliament) is a distinct concept from "imprecise." Also decided to track schema.sql
in Git instead of the binary living_past.db file itself, resolving the open question
left in .gitignore. Ran the finished schema against a real database and verified all
six tables exist via .tables and .schema.

What I learned: SQLite's type affinity system and why VARCHAR(255) silently becomes
TEXT. The INTEGER PRIMARY KEY auto-increment idiom, and why SERIAL/AUTOINCREMENT
keywords from other databases don't apply. CHECK constraints as the mechanism for
enum-like fields, and that they're case-sensitive — casing has to be picked once and
used consistently across the whole schema. Why NOT NULL vs nullable is a real modeling
decision, not just a formality — and specifically why "imprecise" (covered by a
precision field) and "open-ended" (a null end date) and "unknown" (null, no separate
flag) are three different concepts that shouldn't be conflated. PowerShell's `<`
redirection limitation and the Get-Content/.read workarounds. Why CREATE TABLE IF NOT
EXISTS matters for safely re-running a schema file repeatedly, versus commenting
sections in and out by hand.

Where we left off: All 6 entity tables exist in living_past.db and schema.sql. Join/
relationship tables (person_place, person_event, event_event, the *_source_relationships
tables, etc., per WORLD_MODEL.md) have not been started yet. Seed data has not been
entered.

Next session should start with: Continuing Day 3 — join/relationship tables (new
concepts: foreign keys, composite relationships), then seed data entry.

## Session 4 — 2026-08-23

What we did: Designed WORLD_MODEL.md through four rounds of draft/critique, per the
project's stated Day 2 process (user drafts, Claude critiques rather than designs).
Landed on six entity tables (person, place, event, object, culture_topic, source) and
join tables for every relationship pair, following the typed-by-pair pattern from
V1_TECHNICAL_SPEC.md §5. Caught and fixed several real bugs along the way: a
self-referencing FK naming collision on person_person_relationships, a relation_type
column that went missing during a rename, a source/sources naming mismatch that took
three passes to fully stamp out across table name, column names, and FK comments, and
several invalid-identifier issues (slashes and spaces in culture/topic, lat/long, and
historical name(s)). Made and documented several real design decisions: sources are
modeled as their own table plus per-entity-type join tables (not embedded fields);
object location is expressed via relationship rows, not embedded location fields;
event_object_relationships is excluded from V1 (no use case in the seed sketch);
discovery_date has no precision field for now, on the assumption discovery dates are
well-documented, with a note to revisit if needed; source_subtype is freetext for V1,
with its detailed taxonomy pushed to backlog rather than built now. Cleaned up the
relation_type vocabulary, collapsing redundant inverse-verb pairs (precedes/succeeds,
several parent_of variants, governed_over/ruled_by) into single directional verbs per
the app-layer-reversal convention already established for event_event_relationships.
Sketched seed entities: Julius Caesar, Cleopatra, Mark Antony; Rome, Rubicon River,
Alexandria, Egypt; First Triumvirate formed, Crossing of the Rubicon, Battle of Actium;
Cleopatra's Needles, Elephant Denarius; Roman Senate, Egyptian Politics, Ancient Rome,
Ancient Egypt.

What I learned: How naming inconsistencies hide across a growing document even after
you think you've fixed them — the source/sources bug survived three rounds because
each fix only caught one of the three places the name appeared. The value of
cross-checking a schema against actual seed data rather than reviewing it in the
abstract (several relationship pairs and vocab gaps only became visible once checked
against the Caesar/Cleopatra/Antony sketch). Why directional relationships should use
one verb with app-layer reversal instead of separate forward/inverse vocabulary
entries. Why a single FK column can't reference "whichever table" in SQLite, and why
that forces a join-table-per-entity-type approach for something like sources.

Where we left off: WORLD_MODEL.md content is finalized and all documents updated to reflect session 4 progress.

Next session should start with: Day 3 activities.

## Session 3 — 2026-08-20

What we did: Completed Day 1 for real. Built the actual repo skeleton (src/, tests/, data/, docs/), moved the planning docs into place, ran git init. Wrote a first Python script from scratch (src/main.py) — this was the user's first Python code ever, coached through basic syntax (print, functions, indentation vs. Java's braces, the if __name__ == "__main__": idiom). Created the project's real .venv (separate from the earlier throwaway test venv). Staged, committed, and pushed the first commit to a new GitHub repo (github.com/bpotthast/the-living-past). Day 1 milestone achieved: the app runs and changes are committed (and now pushed).

What I learned: Basic Python syntax coming from a Java background (no semicolons/braces, indentation-based blocks, no forced entry point, def for functions). Hit two more environment snags along the way, both resolved: a stray non-dotted venv folder got created alongside the correct .venv one (path mismatch, not a real error); and PowerShell treats commas as list separators, not command separators — chaining multiple git commands on one line with commas silently merged them into one broken command instead of three separate ones (semicolons are the correct PowerShell chain separator).

Where we left off: Day 1 is fully complete and pushed to GitHub. Day 2 (designing WORLD_MODEL.md) has not started.

Next session should start with: Day 2 — design the entity/relationship world model, to be critiqued before anything gets built from it, per docs/ROADMAP.md.

## Session 2 — 2026-08-19

What we did: Installed and verified the full Day 1 tooling stack on Windows — Python, Git, VS Code, pip — and confirmed the GitHub account is ready to go. Test-drove a throwaway virtual environment ahead of Day 1 itself, which surfaced two Windows/PowerShell-specific snags, both now permanently resolved on this machine: PowerShell requires an explicit .\ prefix to run a local script (unlike Command Prompt), and PowerShell's default execution policy blocks script execution until enabled once via Set-ExecutionPolicy -Scope CurrentUser RemoteSigned.

What I learned: Why PowerShell needs the .\ prefix for local scripts, and what an execution-policy error means and how to fix it (a one-time, per-machine setting, not something to redo each session).

Where we left off: Tooling is fully installed and verified. The actual Day 1 work — git init, the repo skeleton (src/, tests/, data/, docs/), and the first trivial running app — has not started yet.

Next session should start with: Day 1 proper — git init, folder skeleton, and a trivial running app per docs/ROADMAP.md.

## Session 1 — 2026-08-19

**What we did:** Wrote and reviewed the full project brief. Identified and
resolved four open design questions (see DECISIONS.md, all dated
2026-08-19): a fifth Culture/Topic entity type, typed-join-table
relationship storage, astronomical-year date model, entity+claim-level
provenance. Drafted and agreed on `V1_TECHNICAL_SPEC.md`. Set up the
`docs/` folder itself (README, ROADMAP, DECISIONS, PROGRESS, BACKLOG).

**What I learned:** Why a single generic "relationships" table loses
foreign-key integrity, and the typed-pair-table alternative. Why BCE dates
break naive SQL date handling.

**Where we left off:** Day 1 of the roadmap (environment setup, repo
skeleton, trivial running app) has not started yet.

**Next session should start with:** Day 1 — set up Python venv, Git repo,
folder structure, and a trivial running app per `docs/ROADMAP.md`.
