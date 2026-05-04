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

From your project root (after creating from the framework template and
renaming `CLAUDE.md.template` to `CLAUDE.md`):

```bash
./.framework/scripts/install-bundle.sh design-frontend
```

The script:
- copies `shadcn/` and `emil-design-eng/` into `.claude-plugin/skills/`
- merges plugin entries (`impeccable`, `interface-design`,
  `ui-ux-pro-max`) into `.claude/settings.json`
- appends this bundle's CLAUDE.md additions (Design System tier table,
  token-canonical sync, phased adoption, How You Work additions)

**Requires `jq`.** If you don't have it: `brew install jq`.

After running, restart Claude Code (`/exit`, then `claude`) so the
new plugins register. Verify:

```bash
claude plugin list
```

Should show `local-toolkit`, `impeccable`, `interface-design`, and
`ui-ux-pro-max` all enabled at project scope.

### Read the cheatsheet

Before starting real design work, read
[`skills-cheatsheet.md`](skills-cheatsheet.md). It's the decision tree
for which skill to use when, and lists pre-flight requirements (e.g.
`impeccable` needs `PRODUCT.md` to exist before it'll do real work).

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
