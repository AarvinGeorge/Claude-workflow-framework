# Claude Workflow Framework

A reusable methodology and capability map for software projects built
with [Claude Code](https://claude.com/claude-code). Two commands and
Claude is ready to lead a fresh project from problem-framing to ship —
invoking the right skills at the right time, recommending the right
tooling, tracking the right phase, every turn.

> **About this README.** This file is what visitors to the framework
> repo see. It's also the README that lands at the root of every new
> project created from this template. Once your project's Discover
> phase yields a clear summary, replace this file with your own
> project README — the framework's docs live in
> [`.framework/`](.framework/) and stay accessible after the swap.

---

## Why this exists

Every software project — AI engineering, web app, browser extension,
CLI tool, mobile app, data work — has the same shape: discover the
problem, define scope, design the solution, build it, ship it, learn.
And every Claude Code session benefits from the same disciplines:
brainstorming before coding, planning before building, verifying before
declaring done.

But every new project starts from a blank `claude` session that has no
memory of any of this. You re-explain methodology, re-pick skills,
re-set up plugins, re-decide what "done" looks like. By the time
discovery actually starts, the session is half-spent.

This framework removes that overhead. One template, one capability
map, one philosophy — applied consistently across every project, with
Claude doing the steering inside each session.

---

## Philosophy

Four principles run through every design decision in this framework.
If something violates one, it gets reworked.

### 1. Discovery happens *with* Claude, not before it.
Older versions of this framework asked the user to fill placeholders
(end-users, constraints, tech stack) before starting work. That's
backwards — those facts *emerge from* discovery. STATE.md is a
kickoff scaffold, not a form. Sections fill in during conversation.

### 2. Claude makes the informed decisions for you.
You shouldn't need to know which bundle to install, which skill
applies to which phase, or whether your machine has the right plugins.
Claude checks setup on first session, recommends bundles after
Discover, invokes the right skill per phase, and writes facts into
STATE.md as they solidify. You describe the project; Claude
orchestrates the toolkit.

### 3. The framework guides Claude *every turn*, not just at kickoff.
A Per-Turn Ritual baked into CLAUDE.md asks Claude three questions
before every response: what phase are we in, does a skill match this
task, does this change project state. A SessionStart hook reads
STATE.md at every new session start and re-anchors Claude to current
state. The framework's promise of "guide me throughout" is enforced
by these mechanisms — not by hope that Claude remembers.

### 4. Rules and state live in separate files.
**CLAUDE.md** holds the rules — static framework instructions, never
edited mid-project. **STATE.md** holds the state — current phase,
project facts, decisions, installed bundles, updated every turn.
Install scripts and hooks edit only STATE.md; CLAUDE.md stays clean.
This separation prevents the entire bug class where install tooling
pollutes instructions or stale instructions get mistaken for state.

---

## What's in the box

Concrete deliverables, all verifiable:

| What | Where | Status |
|---|---|---|
| 6 D's methodology | [`.framework/METHODOLOGY.md`](.framework/METHODOLOGY.md) | Discover → Define → Design → Develop → Deliver → Evolve, with done-when criteria for each |
| Capability map | [`.framework/CAPABILITY_MAP.md`](.framework/CAPABILITY_MAP.md) | Skill-to-phase mapping, including AI engineering twists |
| Workflow visualization | [`.framework/WORKFLOW.md`](.framework/WORKFLOW.md) | Lifecycle diagram, dialogue snapshot, swim lanes, CLAUDE.md evolution |
| Evolution loop | [`.framework/EVOLUTION.md`](.framework/EVOLUTION.md) | 4-question process for adding new skills/plugins/MCPs to your toolkit |
| Project rules / kickoff doc | [`CLAUDE.md`](CLAUDE.md) | **Static** — tells Claude how to start, run the per-turn ritual, recommend bundles, when to commit |
| Living project state | [`STATE.md`](STATE.md) | **Dynamic** — current phase, project facts, constraints, bundles installed. Read at session start by the hook; updated by Claude every turn |
| SessionStart hook | [`.claude/hooks/session-start.sh`](.claude/hooks/session-start.sh) | Reads STATE.md and injects current state into new sessions — ensures reliable cross-session resume |
| Project scaffold | `.claude/`, `.claude-plugin/`, `.gitignore` | Ready-to-use Claude Code config (hook registered) |
| Setup verification script | [`.framework/scripts/check-setup.sh`](.framework/scripts/check-setup.sh) | Runs on first session; reports missing tools and plugins |
| Bundle install script | [`.framework/scripts/install-bundle.sh`](.framework/scripts/install-bundle.sh) | One command: copies skills, jq-merges settings, appends CLAUDE.md sections |
| `design-frontend` bundle | [`.framework/bundles/design-frontend/`](.framework/bundles/design-frontend/) | Bundles `shadcn` + `emil-design-eng` skills directly; references `impeccable`, `interface-design`, `ui-ux-pro-max` marketplaces |

### What's bundled vs. what's expected

The framework distinguishes between **bundled** (ships in this repo,
zero install effort) and **expected** (assumed at user scope, framework
checks for them and helps install if missing).

**Bundled directly** (ship as files in this repo):
- `shadcn` skill — full content, copied into `.claude-plugin/skills/`
  by the install script
- `emil-design-eng` skill — same

**Bundled by reference** (settings.json points to GitHub-hosted
marketplaces; Claude Code resolves them on restart):
- `impeccable@impeccable`
- `interface-design@interface-design`
- `ui-ux-pro-max@ui-ux-pro-max-skill`

**Expected at user scope** (framework verifies, offers to install):
- `superpowers` — brainstorming, TDD, debugging, verification, code-review,
  parallel agents, plans, etc.
- `context7-plugin` — library docs lookup

If these are missing, `check-setup.sh` reports them on first session
and Claude offers to install them via `claude plugin install … --scope user`.
You don't have to know they exist; the framework tells you.

---

## How a project unfolds

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
                                                framework version improvements ────────────────────┘
                                                via .framework/EVOLUTION.md
```

The 6 D's loop, gated by done-when criteria at each phase boundary.
Claude updates the project charter in conversation as facts solidify;
phase transitions happen explicitly, not by drift. Real projects loop
backwards too (Develop → Design when an architecture flaw surfaces),
and the framework supports that — phase tracking makes the loop
*visible* rather than hidden.

For the full visualization (dialogue snapshot of a real first session,
who-does-what swim lanes per phase, and how CLAUDE.md grows over time),
see [`.framework/WORKFLOW.md`](.framework/WORKFLOW.md).

---

## How to use it (for a new project)

```bash
gh repo create AarvinGeorge/<project-name> \
    --template AarvinGeorge/Claude-workflow-framework \
    --private --clone

cd <project-name>
claude
```

That's it. Two commands. After `claude` opens:

1. Claude runs `check-setup.sh` to verify your machine is ready. Any
   missing pieces get flagged with install commands; Claude offers to
   run them with your approval.
2. Claude greets you and asks: *"What are we building, and what do you
   already know about it?"*
3. You describe the project in plain English.
4. `superpowers:brainstorming` auto-invokes. Phase 1 (Discover) begins.
5. As Discover yields project type, Claude **proactively recommends a
   bundle** — framed as capabilities, not architecture. *"Sounds like
   there's significant UI work — I can install some design-engineering
   capabilities. OK?"* On approval, Claude runs the install script
   itself.
6. Phase 1 completes. CLAUDE.md updates: `Current Phase` flips to
   "Define," done-when checklist swaps. Phase 2 begins.
7. The cycle continues — phase by phase, skill by skill — until the
   project ships.

You never manually install plugins, never edit JSON, never decide which
skill to invoke. You describe, you confirm, you build.

---

## What Claude actually does for you

| Stage | What Claude does | Backed by |
|---|---|---|
| Session start | Hook reads STATE.md → injects current state into context (or self-skips on fresh project) | `.claude/hooks/session-start.sh` |
| First session only | Verifies tools + plugins, offers to install what's missing | `check-setup.sh` + CLAUDE.md "Session Start Verification" |
| Phase 1 (Discover) | Auto-invokes brainstorming, walks problem framing, stakeholder map, feasibility, recommends bundle | CLAUDE.md kickoff + METHODOLOGY.md done-when |
| Phase 2–6 | Invokes the right skill per phase, tracks done-when, transitions on completion | Per-Turn Ritual + CAPABILITY_MAP |
| Every response | Runs 3-question ritual (phase, skill, state change) before answering | Per-Turn Ritual in CLAUDE.md |
| Bundle install | Recommends + executes via Bash on user approval; records install in STATE.md | CLAUDE.md "Bundle Selection" + install-bundle.sh |
| Phase transitions | Updates `Current Phase`, swaps done-when checklist in STATE.md, in the same response | Per-Turn Ritual question 3 |
| Project state | Keeps STATE.md sections current as facts solidify; reminds you to commit | "How You Work" rules 4 + 5 |

---

## What this framework does *not* do

Honest list of limits:

- **Doesn't run on Windows without WSL.** Scripts are bash-only.
- **Doesn't auto-restart Claude Code after plugin install.** That's a
  Claude Code limitation; you `/exit` and re-run `claude` manually.
- **Doesn't auto-commit STATE.md.** Cross-session resume depends on
  committed state. Claude reminds you to commit after major updates,
  but the actual `git commit` is a user action. (See *How You Work* in
  CLAUDE.md.)
- **Doesn't enforce the Per-Turn Ritual.** Claude has to honor the
  guidance. Long contexts can drift; opening a fresh session re-reads
  CLAUDE.md + STATE.md (via the hook) and re-anchors. If you notice
  ritual skipping, prompting *"run the per-turn ritual"* is the fix.
- **Doesn't (yet) cover every domain.** Currently one bundle:
  `design-frontend`. AI engineering, backend, data, mobile, extension —
  to be authored as projects need them. The framework explicitly
  designs for this — see [EVOLUTION.md](.framework/EVOLUTION.md).
- **Doesn't replace the user.** Phase transitions still need someone
  to confirm. Bundle recommendations still need user approval. The
  framework removes mechanical work, not judgment.

---

## How the framework evolves

Every project that uses this framework should feed friction back. The
evolution loop is documented in
[`.framework/EVOLUTION.md`](.framework/EVOLUTION.md):

1. Notice friction in a project (a missing bundle, a confusing
   instruction, a skill that didn't auto-trigger)
2. Decide: is this fix universal (L1, user scope), domain-specific
   (L2 bundle), or one-off (L3, project only)?
3. Land the change in the framework repo (or your own scope)
4. Bump the CHANGELOG with the rationale

Versions visible:
- **v0.1** — initial extraction
- **v0.2** — restructure for zero-prep bootstrap
- **v0.3** — Per-Turn Ritual + Bundle Selection (continuous guidance)
- **v0.4** — setup verification (`check-setup.sh`)
- **v0.5** — workflow visualization in `WORKFLOW.md`
- **v0.6** — separate state from instructions (STATE.md + SessionStart hook); install-bundle records state; cleaner bundle additions (this version)

---

## Layout

```
Claude-workflow-framework/         ← repo root = project root after cloning
├── README.md                      ← this file (replaced by user during their project)
├── CLAUDE.md                      ← STATIC framework rules (rituals, methodology refs, how-you-work)
├── STATE.md                       ← LIVING project state (phase, project, constraints, bundles)
├── .claude/
│   ├── settings.json              ← baseline Claude Code config (SessionStart hook registered)
│   └── hooks/
│       └── session-start.sh       ← reads STATE.md and injects current state at session start
├── .claude-plugin/                ← local plugin shell, populated by bundles
│   ├── plugin.json
│   ├── marketplace.json
│   └── skills/                    ← empty until a bundle is installed
├── .gitignore
└── .framework/                    ← framework material; persists in your project
    ├── README.md                  ← docs index
    ├── METHODOLOGY.md             ← the 6 D's, fully described
    ├── CAPABILITY_MAP.md          ← skill ↔ phase mapping
    ├── WORKFLOW.md                ← visual workflow (lifecycle, dialogue, swim lanes, STATE.md evolution)
    ├── EVOLUTION.md               ← 4-question loop for new skills
    ├── INIT.md                    ← starter checklist
    ├── CHANGELOG.md               ← framework version history
    ├── LICENSE                    ← MIT
    ├── scripts/
    │   ├── check-setup.sh         ← verifies tools + plugins + STATE.md on first session
    │   └── install-bundle.sh      ← one-command bundle install (also records install in STATE.md)
    └── bundles/
        ├── BUNDLE_GUIDE.md        ← which bundle when, how to author new ones
        └── design-frontend/       ← v0.6's only bundle
            ├── README.md
            ├── claude-md-additions.md   ← static design rules, ready-to-append (v0.6+ name)
            ├── settings-additions.json
            ├── skills-cheatsheet.md
            └── skills/            ← shadcn, emil-design-eng (full content)
```

---

## Prerequisites (one-time, on your machine)

Required:
- [Claude Code](https://claude.com/claude-code) — `claude` CLI
- [GitHub CLI](https://cli.github.com/) — `gh` (for `gh repo create --template`)
- [jq](https://jqlang.github.io/jq/) — `brew install jq` (for the install scripts)
- L1 plugins at user scope:
  ```
  claude plugin install superpowers --scope user
  claude plugin install context7-plugin --scope user
  ```

The framework's `check-setup.sh` will tell you on first session if any
of these are missing. You don't need to memorize this list.

---

## License

MIT — see [`.framework/LICENSE`](.framework/LICENSE).
