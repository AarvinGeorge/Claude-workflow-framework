# Evolution — How the Framework Grows

When you find a new skill, plugin, or MCP server that improves your
workflow, run it through this 4-question loop. The output: it lands in
the right scope and the [Capability Map](CAPABILITY_MAP.md) stays
current.

---

## The 4-question loop

### 1. What activity does it accelerate?

Map the new tool to a phase in the [6 D's](METHODOLOGY.md):

- *Discover* — research, problem framing, feasibility
- *Define* — requirements, evals, scope
- *Design* — architecture, UX, contracts
- *Develop* — implementation, integration
- *Deliver* — verification, ship, observe
- *Evolve* — learning, refactor, retire

Or **cross-cutting** (works in many phases — e.g. `context7-plugin:docs`
for any library lookup).

### 2. How universal is it?

| Reach | Scope | Where to install |
|---|---|---|
| Useful in **all projects regardless of domain** | **L1** | User scope (`~/.claude/`) |
| Useful in **a class of projects** (frontend, AI, data) | **L2 bundle** | Add to existing or new bundle in `bundles/` |
| Useful only for **this project** | **L3** | Project scope (`.claude/settings.json`) |

If you're unsure, default to L3 first. You can always promote later
when patterns emerge across multiple projects.

### 3. Where's it from?

| Source | What to do |
|---|---|
| Marketplace plugin (e.g. GitHub-hosted) | `claude plugin install …` at the right scope |
| Loose `SKILL.md` (no plugin) | Bundle it under `bundles/<name>/skills/<skill-name>/` and load via local plugin shell |
| Your own pattern (recurring guidance you keep restating) | Author with `anthropic-skills:skill-creator`; live at the appropriate scope |
| MCP server | Configure in `.mcp.json` at project scope, or per-user MCP config |

### 4. Update the map

Open [CAPABILITY_MAP.md](CAPABILITY_MAP.md) and add the new tool to the
right phase row. Add a note to [CHANGELOG.md](CHANGELOG.md). If the new
tool obsoletes an old one, remove the old one too.

---

## Example walkthrough — adding a new skill

> *I just discovered a great skill for prompt-eval design called
> `prompt-eval-pro`. Where does it go?*

1. **Activity?** It accelerates *Define* (eval design) and *Deliver*
   (running evals).
2. **Universality?** Useful in any AI engineering project, not in a
   pure frontend or backend project. → **L2 bundle**, specifically a
   future `ai-engineering` bundle.
3. **Source?** It's a marketplace plugin → install via
   `claude plugin install` when starting an AI project.
4. **Update map.** Add to the *Define* and *Deliver* rows of
   `CAPABILITY_MAP.md`. Note in `CHANGELOG.md` v0.X: "Added
   prompt-eval-pro to ai-engineering bundle."

If `ai-engineering` bundle doesn't exist yet, this might be the first
skill that justifies creating it. Create the bundle dir, add a README
explaining its purpose, and document the install steps.

---

## When to author your own skill

Use `anthropic-skills:skill-creator` when:

- You've given Claude the same correction or guidance **3+ times** in
  separate sessions
- You have a workflow recipe that takes more than a few steps and
  benefits from being repeatable
- A coding/design rule applies across files and you're tired of
  re-stating it

Don't author a skill for:

- One-off project quirks (use CLAUDE.md project instructions instead)
- Things one good memory entry would solve (use the auto-memory system)
- Standard practices already covered by `superpowers:*` skills

---

## When to retire something

A skill / plugin / MCP earns its place by being used. If you haven't
reached for it in 3+ projects:

- **L1 (user-scope)?** Disable it — it's clutter in every project.
- **L2 (bundle)?** Move it to a `deprecated/` subfolder of the bundle
  with a note about why.
- **L3 (project-scope)?** Remove from the project's settings.

Retiring is healthy. The framework is meant to feel sharp, not
bloated.

---

## Promoting between scopes

Patterns sometimes generalize:

- A project-scope skill that worked great → promote to a bundle
- A bundle skill used in 5+ different bundles → promote to L1 user scope

Conversely, demote if you find a tool was less universal than you
thought. Don't be precious; the map should reflect *current* reality.

---

## Keeping the docs in sync

When a framework change alters user-visible workflow — new scripts,
new phases, new bundle classes, behavior changes in CLAUDE.md — update
both:

- [`CHANGELOG.md`](CHANGELOG.md) for the *what changed and why*
- [`WORKFLOW.md`](WORKFLOW.md) for the *what it feels like*

The CHANGELOG is the system of record; WORKFLOW.md is the visualization
the user (and future-you) refers to when picturing the work. Both
should advance together.

When a change is internal-only (refactoring scripts, doc cleanup,
typo fixes), only the CHANGELOG needs updating.
