# INIT — Starting a New Project

Step-by-step to get a new project running with this framework. Aim:
under 5 minutes from clean slate to "ready for Phase 1 (Discover)".

---

## Prerequisites (one-time, on your machine)

You only do this once per machine. After this, every new project skips
straight to the per-project flow below.

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

### 2. GitHub CLI

```bash
gh auth status   # confirm logged in
```

---

## Per-project flow

### Step 1 — Create the project repo from this template

```bash
gh repo create AarvinGeorge/<project-name> \
    --template AarvinGeorge/Claude-workflow-framework \
    --public --clone

cd <project-name>
```

The cloned repo contains the full framework. **Move just the
`templates/` contents to the project root**, then delete the framework
docs/bundles you don't need:

```bash
# Move template contents to root
mv templates/.claude templates/.claude-plugin templates/.gitignore templates/CLAUDE.md.template ./
mv CLAUDE.md.template CLAUDE.md

# Optional — keep BUNDLE_GUIDE for reference, drop framework docs
# (you can always git-clone the framework repo separately for reference)
```

> Alternative: keep the whole framework structure inside your project
> as a self-contained reference. Slightly more cluttered but lets you
> evolve docs in-place. Your call.

### Step 2 — Install a bundle (if one fits)

Check [`bundles/BUNDLE_GUIDE.md`](bundles/BUNDLE_GUIDE.md) to see what's
available. If a bundle matches the project's domain:

```bash
# Example: install design-frontend bundle
cp -r bundles/design-frontend/skills/* .claude-plugin/skills/

# Append the bundle's settings additions to your .claude/settings.json
# (see bundle README for exact instructions)

# Append the bundle's CLAUDE.md snippet to your CLAUDE.md
# (see bundle README for exact instructions)
```

If no bundle fits → skip this step. Use general L1 skills only.

### Step 3 — Fill in CLAUDE.md placeholders

Open `CLAUDE.md` and replace every `<placeholder>` with real content:

- `<project-name>` — the project's actual name
- `<project-summary>` — one-sentence description
- `<role>` — what role you want Claude to take (default given is
  software engineer; swap if you're doing design / research / data)
- `<end-users>` — who this is for
- `<constraints>` — non-negotiables (compliance, performance, a11y,
  privacy)
- `<tech-stack>` — what you're building with
- `<repo-state>` — where things stand at session start

Save it.

### Step 4 — Verify

```bash
# In a Claude Code session inside the project:
claude plugin list

# Confirm:
# - User-scope plugins are enabled (superpowers, context7, etc.)
# - Project-scope local plugin (local-toolkit) is enabled
# - Any bundle marketplaces you added are enabled
```

If something's missing, see the troubleshooting list at the bottom.

### Step 5 — Start Phase 1 (Discover)

Open a Claude Code session in the project root. The session reads
`CLAUDE.md`, picks up the right skills, and is ready to brainstorm
discovery artifacts.

A good first prompt:
> *"Per CLAUDE.md, we're at the Discover phase of a fresh project.
> Help me draft the problem statement and stakeholder map."*

`superpowers:brainstorming` should auto-invoke. From there, follow
the [methodology](METHODOLOGY.md).

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `claude plugin list` shows no plugins | Marketplaces not added | Re-run plugin install commands at the right scope |
| Bundle skills don't auto-trigger | Local plugin not enabled at project scope | Check `.claude/settings.json` has `local-toolkit@local: true` |
| Skills duplicated in listing | Plugin enabled at both user and project scope | Decide which scope is canonical; disable the other |
| `CLAUDE.md` not picked up | Wrong filename or location | Must be at project root, named exactly `CLAUDE.md` |

---

## Aftercare

As you work, the framework gets better:

- Notice friction → file a brief note in your project's notes, then
  later open a PR against the framework repo.
- Discover a useful skill → run it through [EVOLUTION.md](EVOLUTION.md)
  and add to the map.
- Establish a pattern that recurs → consider authoring a skill via
  `skill-creator`.

The framework's CHANGELOG should grow at roughly the rate you take on
new projects.
