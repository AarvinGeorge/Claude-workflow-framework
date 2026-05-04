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

From the project root, run the install script with the bundle name:

```bash
./.framework/scripts/install-bundle.sh <bundle-name>
```

The script:
1. **Copies skills** — `bundles/<name>/skills/*` → `.claude-plugin/skills/`
2. **Merges settings** — `settings-additions.json` is jq-merged into
   `.claude/settings.json` (the `_comment` field is stripped).
3. **Appends CLAUDE.md additions** — `claude-md-snippet.md` is appended
   with `<!-- begin/end: <bundle> bundle additions -->` delimiters. You
   can move sections around if you want different placement.
4. **(Optional) Seed files** — if a bundle ships `tokens.json.seed` etc.,
   copy them in by hand. The script doesn't move seeds (to avoid
   overwriting project files).

Requires: `jq` installed (`brew install jq`). Without jq, the settings
merge is skipped and you'll need to merge by hand from the bundle's
`settings-additions.json`.

After running, restart Claude Code (`/exit`, then `claude`) and verify
with `claude plugin list`.

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

3. Bump the framework version in [`CHANGELOG.md`](../CHANGELOG.md).

4. Test by installing in a fresh project. Friction = bundle bug.

---

## Bundle vs L1 skills

Don't put something in a bundle if it should be at L1 (always-on). The
test:

> *Would I use this skill in projects across totally different domains
> (frontend, backend, AI, data)?*

If yes → L1 (user scope), not a bundle.

If only useful for a class of projects → bundle.
