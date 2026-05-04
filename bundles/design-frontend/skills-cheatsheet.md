# Skills Cheatsheet — `design-frontend` Bundle

Decision tree, capabilities, and pre-flight requirements for the five
skills in this bundle. Read once before relying on them.

> **Note:** Skills activate at session start. After installing or
> changing skills, restart Claude Code (`/exit` then `claude`).

---

## Decision tree — which skill for which moment?

| You're about to… | Reach for | Notes |
|---|---|---|
| Pick a layout, color palette, font pairing for a new surface | **`ui-ux-pro-max`** | Generates a full design system from product type + keywords |
| Start interface-design discovery (intent + signature + defaults to reject) | **`interface-design`** | Strict "intent-first" workflow; persists decisions to `.interface-design/system.md` |
| Run a structured audit / critique / polish on existing UI | **`impeccable`** | 23 sub-commands; **needs `PRODUCT.md` to exist first** (see caveats) |
| Add or fix a shadcn component, register, or installation issue | **`shadcn`** | Auto-triggers on shadcn-related tasks; reads `components.json` |
| Tune motion, easing, micro-interactions, button feedback | **`emil-design-eng`** | Animation philosophy; produces Before/After tables |

---

## Skill cards

### 1. `shadcn`

**What it is.** Working knowledge of shadcn/ui — CLI flags, registry
search, component composition, OKLCH/Tailwind v4 patterns, accessibility
enforcement.

**When to invoke.**
- Adding a component: *"add a button / dialog / data-table"*
- Fixing component bugs: *"why is this Select not closing?"*
- Reviewing existing shadcn code for anti-patterns
- Working with `components.json`, presets, registries

**Important caveats.**
- **Auto-triggered only** (`user-invocable: false`). Fires when context
  matches; no `/shadcn` command.
- Wants `components.json` to exist. Without it, reduced context — set
  up shadcn (Next.js + Tailwind + `npx shadcn@latest init`) first.
- Critical rules:
  - Use `flex` + `gap-*`, never `space-x-*` / `space-y-*`
  - Use `size-*` when w == h (`size-10`, not `w-10 h-10`)
  - Use semantic tokens (`bg-primary`), never raw colors (`bg-blue-500`)
  - Forms use `FieldGroup` + `Field` — never raw `div + Label`
  - Icons in buttons use `data-icon`, not sizing classes

**How invoked.** Auto. Just describe a shadcn task.

---

### 2. `emil-design-eng`

**What it is.** Emil Kowalski's design-engineering philosophy — the
invisible details that make UIs feel right. Animation decision
framework, spring physics, micro-interactions, performance rules.

**When to invoke.**
- *"This loading spinner feels off"*
- *"Make this button feel more responsive"*
- *"Should I animate this state change?"*
- Reviewing animations for craft

**Important caveats.**
- **Required first response.** When invoked fresh, must say *"I'm ready
  to help you build interfaces that feel right…"* before doing anything.
- **Required review format.** UI reviews must be a markdown table with
  `| Before | After | Why |` columns. Lists not allowed.
- Strict rules: never `transition: all`, never `scale(0)` entry, never
  `ease-in` on UI, no animation on keyboard-triggered actions.
- Recommends specific easing (`cubic-bezier(0.23, 1, 0.32, 1)` for ease-out).

**How invoked.** Auto on motion/polish language, or `/emil-design-eng` directly.

---

### 3. `impeccable`

**What it is.** A 23-command design intelligence skill. Pattern:
`/impeccable <command> [target]`.

**Sub-commands by group.**
- **Build:** `craft`, `shape`, `teach`, `document`, `extract`
- **Evaluate:** `critique`, `audit`
- **Refine:** `polish`, `bolder`, `quieter`, `distill`, `harden`, `onboard`
- **Enhance:** `animate`, `colorize`, `typeset`, `layout`, `delight`, `overdrive`
- **Fix:** `clarify`, `adapt`, `optimize`
- **Iterate:** `live` (browser-based variant mode)

**When to invoke.**
- *"Audit the dashboard"* → `/impeccable audit`
- *"Polish before shipping"* → `/impeccable polish`
- *"Make this feel bolder"* → `/impeccable bolder`
- *"Critique this UX"* → `/impeccable critique`
- *"Strip this back to essence"* → `/impeccable distill`

**⚠ Important caveats.**
- **Hard-blocks without `PRODUCT.md`.** Pre-flight loads `PRODUCT.md` and
  `DESIGN.md` from the project root. **First real use requires you to
  scaffold `PRODUCT.md`** — either via `/impeccable teach` or by hand.
  Should cover: users, brand, tone, anti-references, register.
- After `PRODUCT.md` exists, also requires a confirmed "shape brief"
  (`/impeccable shape`) before mutations.
- Hard "absolute bans": side-stripe borders, gradient text, glassmorphism
  by default, modal-as-first-thought, em dashes.
- "AI slop test": first-order ("could someone guess theme from
  category?") and second-order checks against category clichés.
- Requires `npx impeccable` to load context via the skill's load script.

**How invoked.** `/impeccable [command] [target]`.

---

### 4. `interface-design`

**What it is.** Discovery-first skill for *interface* design (dashboards,
admin, tools, SaaS). Forces intent before code, rejects defaults,
persists decisions.

**When to invoke.**
- Designing any dashboard / admin / SaaS surface for the first time
- *"Establish the design language for this app"*
- *"Document our component system"*
- *"Critique my build for craft"*

**Required outputs before any direction is proposed:**
1. **Domain** — 5+ concepts/metaphors from the product's world
2. **Color world** — 5+ colors that exist naturally in this domain
3. **Signature** — one element unique to THIS product
4. **Defaults** — 3 obvious choices that should be rejected

**Important caveats.**
- **Strict scope.** Refuses marketing/landing/campaign work — punts to
  `/frontend-design`.
- After completing a build, asks *"Want me to save these patterns?"* —
  yes writes to `.interface-design/system.md` (canonical decisions
  file).
- Built-in tests:
  - **Swap test:** swap typeface/layout for the standard one — does it
    still feel like this product?
  - **Squint test:** can you still perceive hierarchy with eyes blurred?
  - **Signature test:** can you point to 5 specific elements where the
    signature appears?
  - **Token test:** read CSS variables aloud — could they belong to any
    project, or only this one?

**How invoked.** `/interface-design` directly, or auto on dashboard work.

---

### 5. `ui-ux-pro-max`

**What it is.** Searchable design database — 50+ styles, 161 color
palettes, 161 product types with reasoning, 99 UX guidelines, 25 chart
types. Powered by Python scripts that query bundled CSV data.

**When to invoke.**
- *"Generate a design system for a SaaS dashboard"*
- *"What palette fits a healthcare product?"*
- *"Recommend font pairings for fintech"*
- *"Pre-launch UX checklist"*
- *"Implement dark mode"*

**Workflow** (4 steps):
1. **Analyze** — extract product type, audience, style keywords
2. **Generate design system** (REQUIRED first call):
   ```
   python3 .claude/plugins/cache/.../scripts/search.py "<keywords>" --design-system -p "Project Name"
   ```
3. **Domain searches** — supplement with `--domain product|style|color|typography|chart|ux|landing`
4. **Stack guidelines** — `--stack react-native` (verify which stack
   data ships with your install)

**Important caveats.**
- **Python required.** Mac has it built-in (`python3 --version`).
- **Persists** to `design-system/MASTER.md` with `--persist` flag, plus
  `design-system/pages/<page>.md` for page overrides.
- Marketing claims 10 stacks supported but actual ships may vary —
  verify before relying on others.
- 10 priority categories (1=Accessibility CRITICAL, 10=Charts LOW). Run
  through 1–3 (CRITICAL + HIGH) as a final review pass.

**How invoked.** `/ui-ux-pro-max` directly, or auto-triggered.

---

## How they layer on a real task

Imagine: *"Design the main page for our app."*

```
1. interface-design   → forces discovery: domain, color world,
                          signature, defaults to reject
2. ui-ux-pro-max     → generate full design system (palette, type,
                          spacing, charts) keyed to product type
3. shadcn            → wire up the actual components from shadcn
                          library (post-scaffold)
4. emil-design-eng   → polish micro-interactions
5. impeccable        → audit + polish + harden pass before declaring
                          done; persist to .interface-design/system.md
```

Each is a specialist; use in succession, not instead of each other.

---

## Pre-flight checklist (per project)

Things to set up **before** the bundle is fully effective:

| Need | Affects | When to do it |
|---|---|---|
| `PRODUCT.md` at project root | `impeccable` (hard-blocks without it) | Phase 1 (Discover) — covers users, brand, tone, anti-refs |
| `DESIGN.md` at project root | `impeccable` (soft-warns) | Phase 3 (Design) — first visual decisions |
| `.interface-design/system.md` | `interface-design` | Auto-created on first save prompt |
| Next.js + Tailwind + shadcn scaffold (or your stack equivalent) | `shadcn` (reduced context without) | Phase 4 (Develop) start |
| `design-system/MASTER.md` | `ui-ux-pro-max` (optional persistence) | First `--persist` run |

---

## Caveats across the board

- **Lazy loading by design.** Skill bodies load only when invoked. The
  cheatsheet above is the *map*; territory comes from invocation.
- **Restart for new installs.** Anything installed mid-session needs
  `/exit` + `claude` restart to register.
- **Scope matters.** Project vs user — confirm with `claude plugin list`
  and `.claude/settings.json`.
- **`impeccable` runs scripts.** Review before invoking destructive
  commands.
