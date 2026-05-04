# Claude Workflow Framework

A reusable methodology + capability map for software projects built with
Claude Code. Spin up a new project with a working skill set, a clear
phase model, and a path for evolving both as you take on more work.

This is a **GitHub template repository** — click "Use this template" to
create a new project repo seeded with everything in `templates/`. Then
copy in the bundle that matches the project's domain.

---

## What's inside

| File / dir | Purpose |
|---|---|
| [`METHODOLOGY.md`](METHODOLOGY.md) | The 6 D's — universal SDLC backbone (Discover → Define → Design → Develop → Deliver → Evolve) |
| [`CAPABILITY_MAP.md`](CAPABILITY_MAP.md) | Which skills serve which phase. Living doc; update when toolkit changes |
| [`EVOLUTION.md`](EVOLUTION.md) | How to incorporate new skills/plugins/MCPs as you find them |
| [`INIT.md`](INIT.md) | Step-by-step: starting a new project from this template |
| [`CHANGELOG.md`](CHANGELOG.md) | Framework version history |
| [`templates/`](templates/) | Project scaffold copied into every new repo |
| [`bundles/`](bundles/) | Domain add-ons (design-frontend, future: ai-engineering, backend-api, …) |

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

See [INIT.md](INIT.md) for the full checklist. The TL;DR:

```bash
gh repo create AarvinGeorge/<my-new-project> \
    --template AarvinGeorge/Claude-workflow-framework \
    --public --clone

cd <my-new-project>

# Copy a bundle (or skip if no domain match)
cp -r ../Claude-workflow-framework/bundles/design-frontend/skills/* \
      .claude-plugin/skills/

# Fill in CLAUDE.md placeholders, then start working
```

---

## Status

**v0.1** — first cut, extracted from the AI Assistant Platform project.
Expect rough edges. The framework evolves with each project that uses it
— file friction back as a CHANGELOG entry, not a complaint.
