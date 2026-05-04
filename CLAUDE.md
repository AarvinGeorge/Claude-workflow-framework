# CLAUDE.md — <project name>

## Status
**Fresh project. Phase: Discover (not yet started).**

When this CLAUDE.md is read at the start of a session and the sections
below are still empty or marked "to be filled," your job is to
**facilitate** Phase 1 (Discover) with the user — not to assume answers.

Begin the first session by greeting the user briefly and asking, in
plain English:

> *"What are we building, and what do you already know about it?"*

After the user responds, invoke `superpowers:brainstorming` to formalize
Phase 1 (Discover): problem framing, stakeholder map, feasibility check.
As facts solidify in conversation, **update the sections below in
place** — don't keep them empty once Discover yields answers.

---

## Session Start Verification (run on first session of a new project)

Before greeting the user or starting Discover, verify the framework's
prerequisites are in place. Run this once via the Bash tool:

```bash
./.framework/scripts/check-setup.sh
```

The script reports tools (`claude`, `gh`, `jq`), always-on plugins
(`superpowers`, `context7-plugin`), and project scaffold state.

- **If everything is OK** → continue to greeting and Phase 1 kickoff.
- **If anything is missing** → tell the user what's missing, why each
  piece matters, and offer to install with their approval. Run the
  install commands the script suggests via Bash. After installs, ask
  the user to restart Claude Code (`/exit`, then `claude`) so plugins
  register, then resume Phase 1 in the next session.

**Skip this check** on subsequent sessions (any session where Phase 1
already has output — i.e. Project / End Users sections are no longer
empty). The verification is one-time per project.

---

## Per-Turn Ritual

Run through these three questions before each response. Non-negotiable —
the framework's promise of "guide me throughout the project" depends on
this loop running every turn, not just at the start of the project.

1. **What phase of the 6 D's are we in?** Check *Current Phase* below.
   If the user's request implies a phase transition (e.g. wants to start
   coding while we're still in Define), pause and confirm before
   proceeding. Don't drift.
2. **Does a skill match this task?** Check
   [`.framework/CAPABILITY_MAP.md`](.framework/CAPABILITY_MAP.md). If
   the answer is "even 1% yes," invoke it via the Skill tool.
3. **Does this complete a phase or change project state?** If yes,
   update the relevant sections below (Current Phase, Done-When, Project,
   Constraints, etc.) **in the same response** — don't defer.

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

## Methodology — 6 D's

**Current Phase:** Discover (not started)

This project follows the 6 D's: Discover → Define → Design → Develop →
Deliver → Evolve. See [`.framework/METHODOLOGY.md`](.framework/METHODOLOGY.md)
for the full description of each phase.

### Done-When Checklist (Current Phase: Discover)

Discover is complete when:
- [ ] Problem statement (one paragraph)
- [ ] Stakeholder map (who's involved, decides, is affected)
- [ ] Tech feasibility check (libraries, models, costs are buildable)
- [ ] Bundle recommendation (see *Bundle Selection* below)
- [ ] User confirms readiness to move to Define

When all are checked: update *Current Phase* above to "Define" and
**replace this checklist** with Define's done-when criteria from
[METHODOLOGY.md](.framework/METHODOLOGY.md).

---

## Bundle Selection

Once Discover yields a clear sense of the project type, **proactively
recommend a bundle** to the user. Don't ask the user to pick — they may
not know what's available. You evaluate, you propose, you install on
approval.

| Project type | Recommended bundle |
|---|---|
| Web apps, dashboards, browser extensions, design systems | `design-frontend` |
| AI engineering, backend services, data / notebooks | *No bundle yet — rely on L1 skills (claude-api, context7, etc.)* |

**How to recommend.** Frame as *capabilities*, not architecture.
Bad: *"I recommend installing the design-frontend bundle."* Good:

> *"Sounds like there's significant UI work — chat overlay, popup,
> design system. I can install some design-engineering capabilities:
> shadcn knowledge, UI craft principles, an audit toolkit. They'll
> auto-trigger when relevant. OK to set up?"*

**On user approval, run:**
```bash
./.framework/scripts/install-bundle.sh <bundle-name>
```

via the Bash tool. Then ask the user to restart Claude Code (`/exit`,
then `claude`) so plugins register. Continue working with them after
restart.

If no available bundle fits the project, say so honestly. The project
will rely on always-on (L1) skills, which is sufficient for many
domains.

---

## Tooling & Skills
**Always-on (user scope):** superpowers, context7, claude-api,
skill-creator, pdf/docx/xlsx/pptx, harness ops.

**Project-scope bundles installed:**
*Listed automatically when bundles are installed via*
`./.framework/scripts/install-bundle.sh`*. Skill cheatsheet for each
bundle lives at* `.framework/bundles/<name>/skills-cheatsheet.md`.

See [`.framework/CAPABILITY_MAP.md`](.framework/CAPABILITY_MAP.md) for
the skill-to-phase mapping.

## How You Work
1. **Run the Per-Turn Ritual** at the start of every response.
2. Pull project context: this CLAUDE.md, any `system.md` /
   `tokens.json` / `research/` artifacts that exist.
3. Use the right skill for the current phase
   ([CAPABILITY_MAP](.framework/CAPABILITY_MAP.md)).
4. **Keep this document current.** As facts solidify, update the
   sections above in the same response that produced the information.
   Don't defer; staleness breaks future sessions' guidance.
5. Confirm done-when criteria before transitioning phases.
6. Verify before declaring done
   (`superpowers:verification-before-completion`).

**Confirm before creating canonical artifacts.** For new schemas,
contracts, design system entries, or research synthesis docs, present
the structure for approval before writing files.

## Repo State
- Working dir: *<auto-fill from `pwd`>*
- Phase: Discover not yet started
- Outstanding: everything; this is the first session
