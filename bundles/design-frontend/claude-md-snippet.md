# CLAUDE.md snippet — `design-frontend` bundle

Paste these sections into your project's `CLAUDE.md`. Customize
placeholders for your stack.

---

## Design System

### Component tiers
| Tier | What | Examples | Authoring |
|---|---|---|---|
| **L1 Primitives** | shadcn components tokenized to our brand | Button, Input, Dialog, Tabs | shadcn CLI; tweak tokens, not internals |
| **L2 Composed patterns** | Product-specific, reusable, built from L1 | <YourCard>, <YourTile> | Authored by us, published to Figma library |
| **L3 Domain surfaces** | Page-specific UI from L1+L2 | <SomePageCanvas>, <SomeTable> | Authored by us, lives in its page |

Rule: a thing that appears more than twice gets lifted to L2.

### Token-canonical sync
Single source of truth: **`tokens.json`** in the repo.

```
tokens.json  ─►  Tailwind config + shadcn CSS vars  ─►  code components
     │
     └─────────►  Figma Variables  ─────────────────►  Figma library
```

- Token names are identical in code and Figma (`--bg-surface`,
  `--text-primary`, `--space-4`, `--radius-md`, etc.).
- Components in both worlds reference tokens — never raw values.
- Code Connect mappings link every L2 Figma component to its code path.

### Decisions and changelog
- `tokens.json` — values
- `.interface-design/system.md` — *rules*: when to compose, naming, motion
  budget, a11y bar, plus a dated changelog entry for every token or rule
  change. Maintained by the `interface-design` skill.
- `components.json` (shadcn) — framework / aliases / installed components.

### Phased adoption
Architecture is fixed; tooling rolls in as it earns its keep:
- **Phase 0:** `tokens.json` hand-maintained; Figma Variables mirrored
  manually; Storybook stories alongside each L2; Code Connect mappings
  per L2.
- **Phase 1 (10+ L2 components):** Style Dictionary or Figma Variables
  REST sync to automate `tokens.json` ↔ Figma.
- **Phase 2 (team grows):** CI checks for token drift, visual regression
  on Storybook, automated a11y audits.

---

## Tooling & Skills additions

Add to your existing `Tooling & Skills` section:

**Project-scope bundles installed:**
- `design-frontend` — UI-craft + shadcn knowledge

**Bundled skills auto-trigger on:**
- `shadcn` — any shadcn / `components.json` work
- `emil-design-eng` — motion / polish / micro-interaction work

**Marketplace skills available (run as commands or auto-trigger):**
- `impeccable` — `/impeccable audit`, `/impeccable polish`, etc. (23 sub-commands)
- `interface-design` — discovery-first interface work, persists to `.interface-design/system.md`
- `ui-ux-pro-max` — design system generation from product type + keywords

See [`skills-cheatsheet.md`](skills-cheatsheet.md) in this bundle for the
decision tree on which to use when.

---

## How You Work — design additions

Add to your `How You Work` section, between phase awareness and
verification:

> 4a. **Pull design context** — Figma file (if any), `system.md`,
>     `tokens.json`, `components.json`.
> 4b. **Sketch low-fidelity wireframe / flow** before high-fidelity comps.
> 4c. **Use L1 primitives where possible.** Lift to L2 when reuse appears.
>     Build L3 only when genuinely page-specific.
> 4d. **Reference tokens, never raw values.**
> 4e. **Add a Storybook story for every L2 component.** Add a Code
>     Connect mapping for every L2 component.
> 4f. **Run `/impeccable audit` before declaring done.**
