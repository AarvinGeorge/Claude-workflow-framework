# Bundle: `design-frontend`

For projects with significant UI work — web apps, dashboards, browser
extensions, design systems. Bundles UI-craft and component-library
skills.

---

## What's inside

**Bundled skills** (copied into your project's `.claude-plugin/skills/`):
- [`shadcn`](skills/shadcn/) — shadcn/ui component knowledge: CLI flags,
  registry search, OKLCH/Tailwind v4 patterns, accessibility rules,
  composition guidelines.
- [`emil-design-eng`](skills/emil-design-eng/) — Emil Kowalski's
  design-engineering philosophy: animation decision framework, motion
  budget, micro-interactions, the invisible details.

**Marketplace plugins** (installed via `claude plugin install`, declared
in your project's `.claude/settings.json`):
- `impeccable` — 23-command design audit / polish / craft skill
- `interface-design` — discovery-first interface design with persistent
  decisions in `.interface-design/system.md`
- `ui-ux-pro-max` — searchable design DB: 50+ styles, 161 palettes, 161
  product types, 99 UX guidelines

**Suggested CLAUDE.md sections** in [`claude-md-snippet.md`](claude-md-snippet.md)
— design system tier model, token-canonical sync, phased adoption.

**Settings additions** in [`settings-additions.json`](settings-additions.json)
— enable the three marketplace plugins.

**Skills cheatsheet** in [`skills-cheatsheet.md`](skills-cheatsheet.md)
— decision tree for which skill to use when, plus caveats.

---

## When to use this bundle

✅ Use it for:
- Web apps (Next.js, Vue, Svelte, plain React)
- Browser extensions with non-trivial UI (popups, side panels, overlays)
- Internal dashboards / admin tools
- Design system projects

⚠️ Use selectively for:
- Projects on non-shadcn stacks (skip the `shadcn` skill, keep the
  others — they're framework-agnostic)
- Marketing sites (the bundled skills are tuned for *interface* design,
  not landing-page craft)

❌ Skip for:
- Pure backend projects
- CLI tools without UI
- Data-only / notebook projects

---

## Install

From your project root, **after** you've created it from the framework
template:

### Step 1 — Copy bundled skills

```bash
# Adjust path to wherever you've cloned the framework
FRAMEWORK=~/path/to/Claude-workflow-framework

cp -r $FRAMEWORK/bundles/design-frontend/skills/* .claude-plugin/skills/
```

Verify:
```bash
ls .claude-plugin/skills/
# Should show: emil-design-eng/  shadcn/
```

### Step 2 — Merge settings additions

Open [`settings-additions.json`](settings-additions.json) and merge its
contents into your `.claude/settings.json`. By hand or with `jq`:

```bash
# By hand (recommended for v0.1 — easy to verify what's added):
# Open both files, paste plugins/marketplaces from the additions file
# into the corresponding objects in your settings.json.
```

After merging, `.claude/settings.json` should enable:
- `local-toolkit@local` (already there from the template)
- `impeccable@impeccable`
- `interface-design@interface-design`
- `ui-ux-pro-max@ui-ux-pro-max-skill`

### Step 3 — Add CLAUDE.md sections

Open [`claude-md-snippet.md`](claude-md-snippet.md) and paste the
relevant sections into your project's `CLAUDE.md`. Replace any
placeholders with project-specific values.

### Step 4 — Verify

In a Claude Code session inside the project:

```bash
claude plugin list
```

Confirm all four plugins (`local-toolkit`, `impeccable`,
`interface-design`, `ui-ux-pro-max`) are enabled at project scope. If
not, you may need to restart Claude Code (`/exit`, then `claude`).

### Step 5 — Read the cheatsheet

Read [`skills-cheatsheet.md`](skills-cheatsheet.md) once before starting
real design work. It's the decision tree for which skill to use when,
and lists pre-flight requirements (e.g. `impeccable` needs
`PRODUCT.md` to exist before it'll do real work).

---

## Stack-specific notes

**Next.js + Tailwind v4 + shadcn** — primary stack the bundle was
authored against. Everything works out of the box.

**Other React (Vite, Remix, Astro)** — `shadcn` skill applies. Other
skills are framework-agnostic.

**Vue / Svelte / SolidJS** — skip `shadcn`, keep the rest. Component
knowledge becomes generic.

**Browser extensions** — manifest v3 + content scripts + popup or
overlay UI. The bundle's skills apply to the popup/overlay UI; you'll
also need extension-specific guidance which isn't yet in a bundle.

**SwiftUI / Jetpack Compose / Flutter** — bundle is web-leaning. Use
`emil-design-eng` for motion philosophy; skip the rest.

---

## Updating the bundle

When you discover a better pattern, refine a rule, or add a new skill:

1. Make the change in your project first
2. Once stable across 2+ uses, port back to this bundle in the
   framework repo
3. Bump version in framework's [CHANGELOG.md](../../CHANGELOG.md)
