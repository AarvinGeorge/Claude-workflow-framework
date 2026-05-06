# STATE — <project name>

> **What this is.** Living project state — current phase, project
> facts, decisions, installed bundles. Updated by Claude every turn
> as decisions land (per the Per-Turn Ritual in [CLAUDE.md](CLAUDE.md)).
> Read at session start by `.claude/hooks/session-start.sh` and
> injected into Claude's context, so cross-session resume is reliable.
>
> **Single source of truth for project state.** Install scripts and
> hooks edit only this file; CLAUDE.md is static instructions.
>
> **Commit changes before `/exit`.** State that isn't committed may
> not be visible to the next session — see CLAUDE.md > How You Work
> for cadence guidance.

---

## Status
**Fresh project. Phase: Discover (not yet started).**

<!-- Status above is the fresh-project marker; SessionStart hook
self-skips on it. Once Discover yields output, replace the line
with current state (e.g. "Discover in progress, ~80%" or
"Phase: Define"). -->

## Current Phase
**Discover (not started)**

<!-- Update when the phase changes. The Done-When checklist below
should match the current phase. -->


---

## Your Role
*To be set during Phase 1 — propose a role to the user once project
context is clear (e.g. "senior product engineer specialized in …").
The role should reflect what kind of expert lens this project most
needs.*

## Project
*To be filled during Phase 1 (Discover).*

**One-line summary:** *…*

**Deliverables in scope:**
- *…*

**Out of scope right now:** *…*

## End Users
*To be filled during Phase 2 (Define) — personas / JTBD emerge here.*

## Constraints (non-negotiable)
*To be filled during Phase 2 (Define).*

Common constraint categories to consider:
- Compliance (HIPAA, GDPR, SOC 2, etc.)
- Accessibility (WCAG 2.2 AA, keyboard nav, screen readers)
- Privacy / data handling
- Performance / latency budgets
- Cost / model selection (for AI projects)
- Out-of-scope flags (what we are NOT building yet)

## Tech Stack
*To be filled during Phase 3 (Design) — chosen after architecture
decisions land.*

---

## Done-When Checklist (Current Phase: Discover)

Discover is complete when:
- [ ] Problem statement (one paragraph)
- [ ] Stakeholder map (who's involved, decides, is affected)
- [ ] Tech feasibility check (libraries, models, costs are buildable)
- [ ] Bundle recommendation (see CLAUDE.md > *Bundle Selection*)
- [ ] User confirms readiness to move to Define

When all are checked: update **Current Phase** above to "Define" and
**replace this checklist** with Define's done-when criteria from
[`.framework/METHODOLOGY.md`](.framework/METHODOLOGY.md).

---

## Bundles Installed

<!-- bundles-installed:start -->
*None yet — bundles get recorded here automatically by `./.framework/scripts/install-bundle.sh`.*
<!-- bundles-installed:end -->

<!-- Format once populated (entries between the markers above):
- **<bundle-name>** — installed YYYY-MM-DD
  - skills: list
  - plugins enabled: list
  - cheatsheet: .framework/bundles/<bundle-name>/skills-cheatsheet.md
-->

---

## Repo State

- **Working dir:** *<auto-fill from `pwd` once known>*
- **Phase:** Discover not yet started
- **Outstanding:** everything; this is the first session
- **Last commit:** *<auto-update or note manually>*

---

## Decision Log

*Append decisions as they're locked. Format: date, what, why.*

<!-- Example entry once populated:
- **2026-05-05** — Locked persona: front-desk billing staff. Why:
  highest-volume use case from Discover; broadest reach across
  practices.
-->
