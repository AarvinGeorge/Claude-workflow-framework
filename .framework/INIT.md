# INIT — Starting a New Project

Two commands from clone to "Claude is asking the first discovery
question." Everything else happens in conversation.

---

## Prerequisites (one-time, on your machine)

You only do this once. After this, every new project skips straight to
the per-project flow below.

### 1. Always-on baseline plugins (L1, user scope)

These work in every project automatically. Install at user scope:

```bash
# Process discipline
claude plugin install superpowers --scope user

# Library docs lookup
claude plugin install context7-plugin --scope user

# Anthropic skills (skill-creator, pdf, docx, xlsx, pptx, schedule, etc.)
# These are bundled with Anthropic's defaults; verify with:
claude plugin list --scope user
```

### 2. GitHub CLI + jq

```bash
gh auth status        # confirm logged in
brew install jq       # used by the bundle install script
```

---

## Per-project flow (2 commands)

### 1. Clone from the template

```bash
gh repo create AarvinGeorge/<project-name> \
    --template AarvinGeorge/Claude-workflow-framework \
    --private --clone

cd <project-name>
```

The cloned repo already has the project scaffold at root:
- `CLAUDE.md` — kickoff doc; tells Claude the project is fresh and to
  facilitate Phase 1 with you
- `.claude/settings.json` — baseline plugin config
- `.claude-plugin/` — empty local plugin shell, ready for bundles
- `.gitignore` — standard
- `README.md` — project README starter
- `.framework/` — methodology, capability map, bundles, scripts

No restructure step. No file rename. No placeholder-filling.

### 2. Open Claude Code

```bash
claude
```

Claude reads `CLAUDE.md`, sees "Phase: Discover (not started)," and:

1. Greets you briefly
2. Asks: *"What are we building, and what do you already know about it?"*
3. Invokes `superpowers:brainstorming` once you describe the project
4. Walks Phase 1 (Discover): problem framing, stakeholder map,
   feasibility check
5. **Proactively recommends a bundle** based on project type ("sounds
   like there's significant UI work — I can install some
   design-engineering capabilities, OK?")
6. On approval, runs the install script itself via Bash, then asks you
   to restart Claude Code so plugins register
7. Continues guiding you through Define → Design → Develop → Deliver →
   Evolve, invoking the right skill for each phase

**Sections of CLAUDE.md fill in *during* the conversation**, not before.
Roles, constraints, tech stack — all emerge from discovery.

---

## Verify (after first restart)

```bash
# Inside the new Claude session:
claude plugin list
```

Confirm:
- User-scope plugins are enabled (superpowers, context7, etc.)
- Project-scope `local-toolkit@local` is enabled
- If a bundle was installed, its marketplaces should be enabled too
  (e.g. `impeccable@impeccable`, `interface-design@interface-design`)

If something's missing, see the troubleshooting list below.

---

## What the Per-Turn Ritual buys you

CLAUDE.md instructs Claude to run a 3-question check **before every
response**:

1. What phase are we in?
2. Does a skill match this task? Invoke it.
3. Does this complete a phase or change project state? Update CLAUDE.md
   in the same response.

This is what makes the framework guide you *throughout* the project,
not just at kickoff. As long as Claude honors the ritual, phase
transitions, skill activation, and state-keeping happen by themselves.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `claude plugin list` shows no plugins | Marketplaces not added | Re-run plugin install commands at the right scope |
| Bundle skills don't auto-trigger | Local plugin not enabled, or restart not done | Check `.claude/settings.json`; `/exit` then `claude` |
| Skills duplicated in listing | Plugin enabled at both user and project scope | Decide which scope is canonical; disable the other |
| `CLAUDE.md` not picked up | Wrong filename or location | Must be at project root, named exactly `CLAUDE.md` |
| Bundle install script fails on jq | jq not installed | `brew install jq` |
| Script run from wrong dir | Run from project root, not from `.framework/` | `cd` to project root first |
| Claude doesn't recommend a bundle | Discover not yet yielded enough context | Continue Discover; the recommendation comes once project type is clear |

---

## Aftercare

As you work, the framework gets better:

- Notice friction → file a brief note, then later open a PR against the
  framework repo.
- Discover a useful skill → run it through
  [EVOLUTION.md](EVOLUTION.md) and add to the map.
- Establish a pattern that recurs → consider authoring a skill via
  `skill-creator`.

The framework's CHANGELOG should grow at roughly the rate you take on
new projects.
