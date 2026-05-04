# Claude Workflow Framework

A reusable methodology + capability map for software projects built with
Claude Code. Spin up a new project with a working skill set, a clear
phase model, and a path for evolving both as you take on more work.

This is a **GitHub template repository** — click "Use this template" or
run `gh repo create … --template` to create a new project repo seeded
with the project scaffold at root, with framework material tucked in
`.framework/`.

---

## What's inside

| File / dir | Purpose |
|---|---|
| [`METHODOLOGY.md`](METHODOLOGY.md) | The 6 D's — universal SDLC backbone (Discover → Define → Design → Develop → Deliver → Evolve) |
| [`CAPABILITY_MAP.md`](CAPABILITY_MAP.md) | Which skills serve which phase. Living doc; update when toolkit changes |
| [`EVOLUTION.md`](EVOLUTION.md) | How to incorporate new skills/plugins/MCPs as you find them |
| [`INIT.md`](INIT.md) | Step-by-step: starting a new project from this template |
| [`CHANGELOG.md`](CHANGELOG.md) | Framework version history |
| [`bundles/`](bundles/) | Domain add-ons (design-frontend, future: ai-engineering, backend-api, …) |
| [`scripts/install-bundle.sh`](scripts/install-bundle.sh) | One-command bundle install |

The repo root (one level up from this directory) holds the **project
scaffold** that lands at the root of every new project: `CLAUDE.md.template`,
`.claude/`, `.claude-plugin/`, `.gitignore`, top-level `README.md`.

---

## The 3-layer model

```
L1  ALWAYS-ON BASELINE  (~/.claude/, user scope)
    Universal skills — superpowers, skill-creator, context7, claude-api,
    pdf/docx/xlsx, harness ops. Same in every project.

L2  THIS FRAMEWORK
    Methodology + bundles + templates. One repo, used as a template.

L3  PER-PROJECT REPO
    The actual project: code, decisions, research, scratch.
```

L1 is configured once on your machine. L2 is this repo. L3 is what you
get after `Use this template`.

---

## Quick start (for a new project)

See [INIT.md](INIT.md) for the full checklist. The TL;DR — 4 commands:

```bash
# 1. Clone from template
gh repo create AarvinGeorge/<my-new-project> \
    --template AarvinGeorge/Claude-workflow-framework \
    --private --clone

cd <my-new-project>

# 2. Rename the project charter
mv CLAUDE.md.template CLAUDE.md

# 3. (Optional) Install a bundle
./.framework/scripts/install-bundle.sh design-frontend

# 4. Open Claude Code — it reads CLAUDE.md, kicks off Phase 1 with you
claude
```

No placeholder-filling required. Discovery happens in conversation, not
via a one-shot form.

---

## Philosophy

**The framework's job is to make Claude Code immediately useful, not to
extract project facts up front.** Discovery is the first thing Claude
does *with* you, not a prerequisite. The CLAUDE.md template is a
*kickoff doc*, not a form — sections fill in during the
Discover/Define/Design conversations.

---

## Status

**v0.2** — restructured for true zero-prep new-project bootstrap.
Template lives at repo root; framework material in `.framework/`;
bundle install is one command. Friction discovered while using the
framework on real projects feeds back as future versions.
