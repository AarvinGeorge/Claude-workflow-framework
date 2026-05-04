# Bundle Guide

Bundles are domain-specific add-ons. Pick one (or none) per project,
based on what you're building.

---

## Available bundles

| Bundle | When to use | Skills included |
|---|---|---|
| [`design-frontend`](design-frontend/) | Any project with significant UI work — web apps, browser extensions, design systems | `shadcn`, `emil-design-eng`, plus suggested marketplace plugins (`impeccable`, `interface-design`, `ui-ux-pro-max`) |

---

## Future bundles (not yet authored)

These will be created as projects need them. Don't pre-build.

| Bundle | Will cover |
|---|---|
| `ai-engineering` | Prompt design, eval scaffolds, agent topology, model selection patterns |
| `backend-api` | Service scaffolds, contract testing, observability primitives |
| `data-research` | Notebook conventions, repro pipelines, data exploration patterns |
| `extension` | Browser extension manifests, content-script patterns, popup vs overlay UI |
| `mobile` | iOS / Android / cross-platform mobile patterns |

---

## How to install a bundle

Each bundle has its own README with the exact steps. The general shape:

1. **Copy skills** — `cp -r bundles/<name>/skills/* <project>/.claude-plugin/skills/`
2. **Add settings** — paste the bundle's `settings-additions.json`
   contents into your project's `.claude/settings.json` (merge by hand
   or with a JSON merge tool).
3. **Add CLAUDE.md sections** — paste the bundle's `claude-md-snippet.md`
   into the relevant sections of your project's `CLAUDE.md`.
4. **(Optional) Use seed files** — bundles may include starter
   `tokens.json`, `system.md`, etc. — copy if you want a head start, or
   build from scratch.

Then verify with `claude plugin list`.

---

## How to author a new bundle

When the same setup recurs across two or more projects, that's the
signal to extract a bundle.

1. Create `bundles/<bundle-name>/` with:
   - `README.md` — purpose, when to use, install steps
   - `claude-md-snippet.md` — sections to paste into project CLAUDE.md
   - `settings-additions.json` — settings.json additions
   - `skills/` — bundled SKILL.md files (only those without proper
     marketplace plugins; otherwise just reference the marketplace)
   - `skills-cheatsheet.md` — synthesis of how the bundle's skills
     interact
   - Optional seed files (`tokens.json.seed`, etc.)

2. Add a row to this guide.

3. Bump the framework version in [CHANGELOG.md](../CHANGELOG.md).

4. Test by installing in a fresh project. Friction = bundle bug.

---

## Bundle vs L1 skills

Don't put something in a bundle if it should be at L1 (always-on). The
test:

> *Would I use this skill in projects across totally different domains
> (frontend, backend, AI, data)?*

If yes → L1 (user scope), not a bundle.

If only useful for a class of projects → bundle.
