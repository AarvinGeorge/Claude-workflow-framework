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

A condensed dialogue from `claude` opening through the end of Discover.
Italicized lines are *what's happening behind the scenes* — not visible
to the user.

```
─── Session 0 ──────────────────────────────────────────────────────────────────

CLAUDE   *reads CLAUDE.md → sees "Phase: Discover (not started)"*
         *reads CLAUDE.md → sees Session Start Verification block*
         *runs ./.framework/scripts/check-setup.sh via Bash*

         "Quick setup check — superpowers and context7 are installed at
          user scope, jq and gh are available. We're ready.

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

CLAUDE   *Discover yielding clarity on project type*

         "Based on what you've described, this needs:
          - <key capability 1>
          - <key capability 2>
          - <key constraint>

          I can install the matching capabilities — <bundle skills,
          framed as benefits>. They'll auto-trigger when relevant.
          OK to set up?"

YOU      "Yes."

CLAUDE   *runs ./.framework/scripts/install-bundle.sh <bundle> via Bash*
         *script: copies skills, jq-merges settings, appends CLAUDE.md snippet*

         "Done. The plugins need a restart to register. Run:
          /exit
          claude
          and we'll continue from where we left off."

[ /exit, claude ]

─── Session 1 ──────────────────────────────────────────────────────────────────

CLAUDE   *reads CLAUDE.md → Phase: Discover, but Project section now filled*
         *skips Session Start Verification (already done)*
         *runs Per-Turn Ritual: Phase=Discover, near completion*

         "Good — I see we have the project framing and the bundle
          installed. To wrap Discover, I need:
          - A short feasibility check
          - Confirmation we're ready to move to Define

          Want me to do a quick research pass?"

[ ... feasibility check, summary ... ]

CLAUDE   *all Discover done-when checks pass*
         *Per-Turn Ritual question 3: yes, this completes a phase*
         *updates CLAUDE.md: Phase: Define, swaps done-when checklist*

         "Discover is complete:
          ✓ Problem statement
          ✓ Stakeholder map
          ✓ Feasibility check
          ✓ Bundle installed

          Phase 2 (Define) is next: personas, JTBD, constraints,
          eval design. Ready?"
```

You see: discovery → recommendation → install → transition. You never
edit JSON, never manually invoke a skill, never wonder which phase
you're in.

---

## 3. Who does what (per-phase swim lanes)

| Phase | YOU | CLAUDE | CLAUDE.md becomes | Skills active |
|---|---|---|---|---|
| **Kickoff** | `gh repo create … --template`, `cd`, `claude` | (not running yet) | template state | — |
| **Session start** | wait | runs `check-setup.sh`, greets | unchanged | (none yet) |
| **Discover** | describe in plain English, approve bundle | brainstorms, recommends bundle, runs install | `Project`, `End Users` (drafted); `Phase: Define` once done | `superpowers:brainstorming` |
| **Define** | confirm personas, name constraints | drafts personas + JTBD + evals | `End Users`, `Constraints` filled; `Phase: Design` | `writing-plans`, `interface-design:init` (if installed) |
| **Design** | pick stack, approve contracts | drafts architecture, picks tech, designs prompts | `Tech Stack` filled; `Phase: Develop` | `writing-plans`, `claude-api`, `shadcn`, `interface-design`, `ui-ux-pro-max` |
| **Develop** | review code, answer Qs | TDD, parallel work, debugging | `Repo State` updated each session | `test-driven-development`, `executing-plans`, `dispatching-parallel-agents`, `using-git-worktrees`, `systematic-debugging`, `shadcn` |
| **Deliver** | approve PR, confirm ship | verification, audit, ship, instrument | `Phase: Evolve` once shipped | `verification-before-completion`, `requesting-code-review`, `finishing-a-development-branch`, `impeccable:audit` |
| **Evolve** | suggest improvements | refactors, codifies skills, trims dead code | living state | `simplify`, `skill-creator`, `consolidate-memory`, `update-config` |

The framework's promise: **you only do the YOU column.** Everything
else is Claude executing what's in CLAUDE.md.

For the full skill-to-phase reference, see
[`CAPABILITY_MAP.md`](CAPABILITY_MAP.md).

---

## 4. How CLAUDE.md fills in over time

```
SESSION 0 (Discover starts)
─────────────────────────────────────
# CLAUDE.md — <project name>
## Status: Phase: Discover (not started)
## Per-Turn Ritual: ...
## Your Role: To be set during Phase 1
## Project: To be filled during Phase 1
## End Users: To be filled during Phase 2
## Constraints: To be filled during Phase 2
## Tech Stack: To be filled during Phase 3
...

         │
         │  Discover yields project framing
         ▼

AFTER DISCOVER
─────────────────────────────────────
# CLAUDE.md — <project name>
## Status: Phase: Define
## Your Role: <role drafted from project context>
## Project: <one-line summary + deliverables>
## End Users: To be filled during Phase 2
## Constraints: To be filled during Phase 2
## Tech Stack: To be filled during Phase 3
## Bundles installed: <bundle name>

         │
         │  Define yields personas + constraints
         ▼

AFTER DEFINE
─────────────────────────────────────
## Status: Phase: Design
## End Users:
   - <persona 1>
   - <persona 2>
## Constraints:
   - <constraint 1>
   - <constraint 2>
## Tech Stack: To be filled during Phase 3

         │
         │  Design yields tech stack + architecture
         ▼

AFTER DESIGN
─────────────────────────────────────
## Status: Phase: Develop
## Tech Stack:
   - <framework / language>
   - <storage / data layer>
   - <UI / styling>
   - <build / dist>

[ … and so on through Develop, Deliver, Evolve … ]
```

The CLAUDE.md is a **living charter** that grows with the project.
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
