# Progress Log

Append-only. Newest session at the top. At the start of a new session,
paste this top entry into the chat so Claude has context without you
re-explaining the project.

---
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
