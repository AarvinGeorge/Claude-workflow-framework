# CLAUDE.md — <project name>

> **What this is.** Static framework instructions: rituals, methodology
> references, bundle selection guidance, how-you-work rules. **Read
> this for "how to operate"; read [`STATE.md`](STATE.md) for "where we
> are."**
>
> **Project state lives in [STATE.md](STATE.md)**, not here. As
> decisions land, update STATE.md in the same response (per the
> Per-Turn Ritual). CLAUDE.md is the rules; STATE.md is the state.

---

## Session Start Verification (first session of a new project only)

Before greeting the user or starting Discover, verify the framework's
prerequisites are in place. Run this once via the Bash tool:

```bash
./.framework/scripts/check-setup.sh
```

The script reports tools (`claude`, `gh`, `jq`), always-on plugins
(`superpowers`, `context7-plugin`), and project scaffold state
(including `STATE.md`).

- **If everything is OK** → continue to greeting and Phase 1 kickoff.
- **If anything is missing** → tell the user what's missing, why each
  piece matters, and offer to install with their approval. Run the
  install commands the script suggests via Bash. After installs, ask
  the user to restart Claude Code (`/exit`, then `claude`) so plugins
  register, then resume Phase 1 in the next session.

**Skip this check** on subsequent sessions. The SessionStart hook
(`.claude/hooks/session-start.sh`) injects current state from
`STATE.md` into the session — if you see real project state in the
injected context, the project is mid-flight; verification is already
done.

---

## Per-Turn Ritual

Run through these three questions before each response. Non-negotiable —
the framework's promise of "guide me throughout the project" depends on
this loop running every turn, not just at the start of the project.

1. **What phase of the 6 D's are we in?** Check
   [`STATE.md`](STATE.md) > *Current Phase*. If the user's request
   implies a phase transition (e.g. wants to start coding while we're
   still in Define), pause and confirm before proceeding. Don't drift.
2. **Does a skill match this task?** Check
   [`.framework/CAPABILITY_MAP.md`](.framework/CAPABILITY_MAP.md). If
   the answer is "even 1% yes," invoke it via the Skill tool.
3. **Does this complete a phase or change project state?** If yes,
   update the relevant section in [`STATE.md`](STATE.md) (Current Phase,
   Done-When, Project, End Users, Constraints, Tech Stack, Bundles
   Installed, Repo State, Decision Log) **in the same response** —
   don't defer.

---

## Methodology — 6 D's

This project follows the 6 D's: **Discover → Define → Design →
Develop → Deliver → Evolve**. See
[`.framework/METHODOLOGY.md`](.framework/METHODOLOGY.md) for the full
description of each phase, with activities, outputs, and done-when
criteria.

The current phase and the active Done-When checklist live in
[`STATE.md`](STATE.md). Update STATE.md when a phase completes — don't
edit this file.

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

via the Bash tool. The install script:
- copies skills into `.claude-plugin/skills/`
- merges marketplace plugins into `.claude/settings.json`
- appends bundle's static design rules to this CLAUDE.md
- **records install state in STATE.md** (Done-When marked, Bundles
  Installed list updated)

After install, ask the user to **commit and restart** Claude Code
(`git add -A && git commit -m "Install <bundle> bundle"`, then `/exit`,
then `claude`). The commit step is essential — see *How You Work*
below for cadence guidance.

If no available bundle fits the project, say so honestly. The project
will rely on always-on (L1) skills, which is sufficient for many
domains.

---

## Tooling & Skills

**Always-on (user scope):** superpowers, context7, claude-api,
skill-creator, pdf/docx/xlsx/pptx, harness ops.

**Project-scope bundles installed:** see
[`STATE.md`](STATE.md) > *Bundles Installed*.

See [`.framework/CAPABILITY_MAP.md`](.framework/CAPABILITY_MAP.md) for
the skill-to-phase mapping.

---

## How You Work

1. **Run the Per-Turn Ritual** at the start of every response.
2. **Pull context.** Read this file (rules), [`STATE.md`](STATE.md)
   (current state), and any project artifacts (`research/`,
   `system.md`, `tokens.json`, code) relevant to the task.
3. **Use the right skill for the current phase**
   ([CAPABILITY_MAP](.framework/CAPABILITY_MAP.md)).
4. **Keep STATE.md current.** As facts solidify (decisions, persona
   names, constraint commitments, phase transitions), update STATE.md
   **in the same response** that produced the information. Don't
   defer; staleness breaks future sessions' guidance.
5. **Commit STATE.md before `/exit`.** Claude Code may spawn future
   sessions with limited visibility into uncommitted working-tree
   changes, depending on configuration. To guarantee cross-session
   continuity:
   - After updating STATE.md, encourage the user to commit:
     `git add STATE.md && git commit -m "Phase 1: <decision>"`
   - Major foundation changes (new hooks, settings.json edits,
     bundle installs) should be committed before the user runs
     `/exit`.
   - The framework's SessionStart hook reads committed state, so
     uncommitted updates may not be visible to the next session.
6. Confirm done-when criteria before transitioning phases.
7. Verify before declaring done
   (`superpowers:verification-before-completion`).

**Confirm before creating canonical artifacts.** For new schemas,
contracts, design system entries, or research synthesis docs, present
the structure for approval before writing files.

---

## Quick reference

| Need to… | Read | Edit |
|---|---|---|
| Know the rules | This file | (read-only — framework instructions) |
| Know where we are | [`STATE.md`](STATE.md) | [`STATE.md`](STATE.md) |
| Know which skill applies | [`.framework/CAPABILITY_MAP.md`](.framework/CAPABILITY_MAP.md) | (read-only) |
| Know what each phase requires | [`.framework/METHODOLOGY.md`](.framework/METHODOLOGY.md) | (read-only) |
| Add a bundle | Bundle's `bundles/<name>/README.md` | Run `install-bundle.sh`, which edits STATE.md and CLAUDE.md |
