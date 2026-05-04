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
scaffold** that lands at the root of every new project: `CLAUDE.md`,
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

See [INIT.md](INIT.md) for the full checklist. The TL;DR — **2 commands**:

```bash
gh repo create AarvinGeorge/<my-new-project> \
    --template AarvinGeorge/Claude-workflow-framework \
    --private --clone
cd <my-new-project>

claude
```

That's it. Claude reads `CLAUDE.md`, kicks off Phase 1 (Discover) with
you, and recommends + installs a bundle on its own once it understands
the project type. No placeholder-filling, no rename, no manual install.

---

## Philosophy

**The framework's job is to make Claude Code immediately useful, not to
extract project facts up front.** Three principles:

1. **Discovery happens with Claude, not before it.** CLAUDE.md is a
   kickoff doc, not a form. Sections fill in during conversation as
   facts solidify.
2. **Claude makes informed tooling decisions.** Bundle selection is an
   *output* of Discover, not a prerequisite. Claude proposes; user
   approves; Claude installs.
3. **The framework guides Claude every turn.** A Per-Turn Ritual in
   CLAUDE.md (3 questions Claude runs each response) keeps phase
   awareness, skill invocation, and state-keeping continuous —
   not just at kickoff.

---

## Status

**v0.3** — continuous guidance baked in. CLAUDE.md now has a Per-Turn
Ritual that Claude runs before every response, ensuring the framework
guides skill invocation and phase tracking *throughout* the project,
not just at kickoff. New-project flow is 2 commands.

Friction discovered while using the framework on real projects feeds
back as future versions.
