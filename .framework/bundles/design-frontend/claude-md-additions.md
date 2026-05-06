## Design System

This project follows a tiered component model. The
`design-frontend` bundle's skills auto-trigger when working in this
section's territory.

### Component tiers
| Tier | What | Examples | Authoring |
|---|---|---|---|
| **L1 Primitives** | shadcn components tokenized to project brand | Button, Input, Dialog, Tabs | shadcn CLI; tweak tokens, not internals |
| **L2 Composed patterns** | Product-specific, reusable, built from L1 | `<YourCard>`, `<YourTile>` | Authored in-project, published to Figma library |
| **L3 Domain surfaces** | Page-specific UI from L1 + L2 | `<SomePageCanvas>`, `<SomeTable>` | Authored in-project, lives in its page |

**Lift rule:** a thing that appears more than twice gets lifted to L2.

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
- `.interface-design/system.md` — *rules*: when to compose, naming,
  motion budget, a11y bar, plus a dated changelog entry for every
  token or rule change. Maintained by the `interface-design` skill.
- `components.json` (shadcn) — framework / aliases / installed components.

### Phased adoption
Architecture is fixed; tooling rolls in as it earns its keep:
- **Phase 0:** `tokens.json` hand-maintained; Figma Variables mirrored
  manually; Storybook stories alongside each L2; Code Connect mappings
  per L2.
- **Phase 1 (10+ L2 components):** Style Dictionary or Figma Variables
  REST sync to automate `tokens.json` ↔ Figma.
- **Phase 2 (team grows):** CI checks for token drift, visual
  regression on Storybook, automated a11y audits.

---

## Working on design tasks (additions to How You Work)

When the current task is design work — UI components, design systems,
visual polish — extend the standard *How You Work* steps with these
between phase awareness (step 1) and verification (step 7):

- **Pull design context.** Figma file (if any), `system.md`,
  `tokens.json`, `components.json`.
- **Sketch low-fidelity wireframe / flow** before high-fidelity comps.
- **Use L1 primitives where possible.** Lift to L2 when reuse appears.
  Build L3 only when genuinely page-specific.
- **Reference tokens, never raw values.**
- **Add a Storybook story for every L2 component.** Add a Code Connect
  mapping for every L2 component.
- **Run `/impeccable audit` before declaring done.**

The decision tree for which design skill to invoke for what task lives
at [`.framework/bundles/design-frontend/skills-cheatsheet.md`](.framework/bundles/design-frontend/skills-cheatsheet.md).
