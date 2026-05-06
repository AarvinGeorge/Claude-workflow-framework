# Workflow — How a Project Unfolds

Four views of what working with this framework looks like in practice.
For any project type, regardless of domain.

> **Maintenance note:** Update this doc whenever a framework change
> alters user-visible workflow — new scripts, new phases, new bundle
> classes, behavior changes in CLAUDE.md. The CHANGELOG should capture
> the *what*; this doc captures the *what it feels like*.

---

## 1. The whole-project lifecycle

```
                                                                                    feedback
                                                                                    ◄──────────────┐
                                                                                                   │
   KICKOFF  ──►  DISCOVER  ──►  DEFINE  ──►  DESIGN  ──►  DEVELOP  ──►  DELIVER  ──►  EVOLVE       │
   ────────     ──────────     ────────     ────────     ──────────     ──────────     ────────    │
                                                                                                   │
   2 cmds       problem        personas     architecture  TDD            verify         refactor   │
                stakeholders   JTBD         UX            integrate      audit          codify     │
                feasibility    constraints  prompts       parallel       review         skills     │
                bundle pick    evals        tokens        agents         ship           memory     │
                                                                         observe                   │
                                                                                                   │
   ⏱ 0–2 min    ~1 session    ~1 session   ~2–3          loops          1–2            ongoing    │
                                                                                                   │
                                                                                                   │
                                                framework version improvements ────────────────────┘
                                                via .framework/EVOLUTION.md
```

The 6 D's loop. Phase boundaries are confirmation-gated — Claude
pauses at each transition to verify done-when criteria before moving
on. Lessons feed back into the framework itself, not just this
project.

See [`METHODOLOGY.md`](METHODOLOGY.md) for the per-phase activities,
outputs, and done-when criteria.

---

## 2. What a first session actually feels like

> **Illustrative example only — not a template to follow literally.**
> The text in this dialogue (e.g. *"Phase: Discover (not started)"*)
> is a snapshot of one possible state, not a prescription for every
> session. Actual session-start behavior is driven by:
>
> - **CLAUDE.md** — static framework rules
> - **STATE.md** — live project state (read at session start by the
>   SessionStart hook in `.claude/hooks/session-start.sh`)
>
> Don't pattern-match this dialogue against your own session's state.

A condensed dialogue from `claude` opening through the end of Discover.
Italicized lines are *what's happening behind the scenes* — not visible
to the user.

```
─── Session 0 ──────────────────────────────────────────────────────────────────

CLAUDE   *SessionStart hook reads STATE.md → sees fresh-project marker → exits silently*
         *reads CLAUDE.md → sees "Session Start Verification" instruction*
         *runs ./.framework/scripts/check-setup.sh via Bash*

         "Quick setup check — tools, plugins, and STATE.md all present.
          We're ready.

          What are we building, and what do you already know about it?"

YOU      "[describes the project in plain English]"

CLAUDE   *invokes superpowers:brainstorming*
         *Per-Turn Ritual: Phase=Discover, brainstorming matches, no state change yet*

         "Got it. Let me work through this with you. A few framing
          questions:
          1. Who's the primary user?
          2. What's the constraint we should be most careful about?
          3. ..."

[ ... 4–6 turns of brainstorming, narrowing scope ... ]

CLAUDE   *Discover yields clarity; updates STATE.md (Project section, Your Role)*
         *Per-Turn Ritual question 3: state changed — STATE.md updated in same response*

         "Based on what you've described, this needs:
          - <key capability 1>
          - <key capability 2>
          - <key constraint>

          I can install the matching capabilities — <bundle skills,
          framed as benefits>. They'll auto-trigger when relevant.
          OK to set up?"

YOU      "Yes."

CLAUDE   *runs ./.framework/scripts/install-bundle.sh <bundle> via Bash*
         *script: copies skills, jq-merges settings, appends CLAUDE.md additions,
          AND records install state in STATE.md (Done-When + Bundles Installed)*

         "Done. Two things to do before continuing:
          1. Commit so the next session sees the updates:
             git add -A && git commit -m \"Install <bundle> bundle\"
          2. Restart Claude Code so plugins register:
             /exit
             claude
          We'll pick up where we left off — the SessionStart hook
          reads STATE.md and re-injects current state."

[ git commit, /exit, claude ]

─── Session 1 ──────────────────────────────────────────────────────────────────

CLAUDE   *SessionStart hook reads STATE.md → sees "Phase: Discover (in progress)"*
         *injects current state into session context (banner + key sections)*
         *I see populated Project, Your Role, Constraints, Bundle installed; Done-When 4/5 checked*

         "Good — picking up Discover, ~80% complete. Project framing
          and bundle install are locked. Outstanding item: feasibility
          check. Want me to run a quick research pass?"

[ ... feasibility check, summary ... ]

CLAUDE   *all Discover done-when checks pass*
         *Per-Turn Ritual question 3: phase complete — update STATE.md*
         *flips Current Phase to "Define"; replaces Done-When with Define's checklist*

         "Discover is complete:
          ✓ Problem statement
          ✓ Stakeholder map
          ✓ Feasibility check
          ✓ Bundle installed

          STATE.md updated: Current Phase → Define. Phase 2 (Define) is
          next: personas, JTBD, constraints, eval design. Commit and
          ready to start?"
```

You see: discovery → recommendation → install → commit → restart →
auto-resume → transition. You never edit JSON, never manually invoke a
skill, never wonder which phase you're in. Cross-session resume works
because the SessionStart hook reads committed STATE.md.

---

## 3. Who does what (per-phase swim lanes)

| Phase | YOU | CLAUDE | CLAUDE.md becomes | Skills active |
|---|---|---|---|---|
| **Kickoff** | `gh repo create … --template`, `cd`, `claude` | (not running yet) | template state | — |
| **Session start** | wait | runs `check-setup.sh`, greets | unchanged | (none yet) |
| **Discover** | describe in plain English, approve bundle | brainstorms, recommends bundle, runs install | `Project`, `End Users` (drafted); `Phase: Define` once done | `superpowers:brainstorming` |
| **Define** | confirm personas, name constraints | drafts personas + JTBD + evals | `End Users`, `Constraints` filled; `Phase: Design` | `writing-plans`, `interface-design:init` (if installed) |
| **Design** | pick stack, approve contracts | drafts architecture, picks tech, designs prompts | `Tech Stack` filled in STATE.md; `Phase: Develop` | `writing-plans`, `claude-api`, `shadcn`, `interface-design`, `ui-ux-pro-max` |
| **Develop** | review code, answer Qs | TDD, parallel work, debugging | `Repo State` updated each session | `test-driven-development`, `executing-plans`, `dispatching-parallel-agents`, `using-git-worktrees`, `systematic-debugging`, `shadcn` |
| **Deliver** | approve PR, confirm ship | verification, audit, ship, instrument | `Phase: Evolve` once shipped | `verification-before-completion`, `requesting-code-review`, `finishing-a-development-branch`, `impeccable:audit` |
| **Evolve** | suggest improvements | refactors, codifies skills, trims dead code | living state | `simplify`, `skill-creator`, `consolidate-memory`, `update-config` |

The framework's promise: **you only do the YOU column.** Everything
else is Claude executing what's in CLAUDE.md (rules) and recording in
STATE.md (state). The one user task that recurs across phases is
**`git commit`** — to make sure the next session sees what this one
produced.

For the full skill-to-phase reference, see
[`CAPABILITY_MAP.md`](CAPABILITY_MAP.md).

---

## 4. How STATE.md fills in over time

```
SESSION 0 (Discover starts)
─────────────────────────────────────
# STATE.md — <project name>
## Status: Fresh project. Phase: Discover (not yet started).
## Current Phase: Discover (not started)
## Your Role: To be set during Phase 1
## Project: To be filled during Phase 1
## End Users: To be filled during Phase 2
## Constraints: To be filled during Phase 2
## Tech Stack: To be filled during Phase 3
## Bundles Installed: None yet
...

         │
         │  Discover yields project framing
         │  (Claude updates STATE.md in same response per Per-Turn Ritual)
         │  YOU then: git commit STATE.md
         ▼

AFTER DISCOVER
─────────────────────────────────────
## Status: Discover (in progress, ~80%)
## Current Phase: Discover (in progress, ~80%)
## Your Role: <role drafted from project context>
## Project: <one-line summary + deliverables>
## End Users: To be filled during Phase 2
## Constraints: To be filled during Phase 2
## Tech Stack: To be filled during Phase 3
## Bundles Installed:
   - <bundle name> — installed YYYY-MM-DD
## Done-When: 4 of 5 checked

         │
         │  Define yields personas + constraints
         ▼

AFTER DEFINE
─────────────────────────────────────
## Current Phase: Design
## End Users:
   - <persona 1>
   - <persona 2>
## Constraints:
   - <constraint 1>
   - <constraint 2>
## Tech Stack: To be filled during Phase 3
## Done-When: (Define done-when checklist)

         │
         │  Design yields tech stack + architecture
         ▼

AFTER DESIGN
─────────────────────────────────────
## Current Phase: Develop
## Tech Stack:
   - <framework / language>
   - <storage / data layer>
   - <UI / styling>
   - <build / dist>
## Done-When: (Develop done-when checklist)

[ … and so on through Develop, Deliver, Evolve … ]
```

STATE.md is the **living charter** that grows with the project.
CLAUDE.md (the rules) stays static and gets updated only on framework
version bumps; STATE.md (the state) grows as decisions land. The
SessionStart hook reads STATE.md at every new session and re-anchors
Claude to current state — so cross-session resume works reliably.
Each future session reads it and re-anchors immediately — no
context-loss between sessions.

---

## Caveats

These diagrams are idealized. Real projects loop:

- **Develop sometimes re-opens Design.** An architecture flaw
  surfaces while building; you go back, revise, come forward.
- **Deliver sometimes re-opens Develop.** A code review finds a real
  bug; you fix it, re-verify, re-deliver.
- **Evolve continuously feeds back to Define.** Learnings from
  shipped behavior reshape the original scope.

The framework supports loops. Phase tracking just makes it **explicit**
when you're going backwards instead of pretending you're going
forwards.

---

## Related docs

- [`METHODOLOGY.md`](METHODOLOGY.md) — phase-by-phase detail
- [`CAPABILITY_MAP.md`](CAPABILITY_MAP.md) — skill-to-phase reference
- [`../CLAUDE.md`](../CLAUDE.md) — the active brain that drives this
  workflow
- [`EVOLUTION.md`](EVOLUTION.md) — how the framework itself evolves
- [`CHANGELOG.md`](CHANGELOG.md) — what's changed
