# Capability Map

Which skills, plugins, and MCPs serve which phase of the [6 D's
methodology](METHODOLOGY.md). A living document — update it whenever
your toolkit changes.

**Three skill tiers:**
- **Always-on (L1)** — installed at user scope (`~/.claude/`), works in
  every project.
- **Bundle (L2)** — opt-in per project via [bundles/](bundles/).
- **Built-in / external** — Claude Code's built-in commands or MCP
  servers.

---

## The map

| Phase | Always-on (L1) | Bundle skills (L2) | Built-in / MCP |
|---|---|---|---|
| **Discover** | `superpowers:brainstorming`, `context7-plugin:docs`, `anthropic-skills:pdf/docx/xlsx` | — | WebSearch, WebFetch |
| **Define** | `superpowers:brainstorming`, `superpowers:writing-plans`, `anthropic-skills:skill-creator` (codify eval patterns) | `interface-design:init` (design-frontend), `ui-ux-pro-max` (design rules) | — |
| **Design** | `superpowers:writing-plans`, `claude-api` (LLM-system design), `anthropic-skills:pptx/docx` (artifacts) | `shadcn`, `emil-design-eng`, `interface-design`, `ui-ux-pro-max`, `impeccable` (design-frontend); Figma MCP | — |
| **Develop** | `superpowers:test-driven-development`, `executing-plans`, `dispatching-parallel-agents`, `subagent-driven-development`, `using-git-worktrees`, `systematic-debugging`, `claude-api` | `shadcn`, `impeccable` (design-frontend); future bundles add their own | Playwright MCP, Chrome MCP, Claude Preview |
| **Deliver** | `superpowers:verification-before-completion`, `requesting-code-review`, `receiving-code-review`, `finishing-a-development-branch`, `loop`, `schedule` | `interface-design:audit`, `impeccable:critique` / `:polish` | `/review`, `/security-review`, scheduled-tasks MCP |
| **Evolve** | `anthropic-skills:skill-creator`, `superpowers:writing-skills`, `consolidate-memory`, `simplify`, `update-config` | (any bundle's update path) | — |

---

## Cross-cutting (active in every phase)

| Skill / tool | Role |
|---|---|
| `superpowers:using-superpowers` | Entry point — establishes how to find and use skills |
| `context7-plugin:docs` | Library docs lookup — useful any time code touches a third-party lib |
| Auto-memory system | Persists user/project/feedback/reference memories across sessions |
| `loop`, `anthropic-skills:schedule` | Periodic checks (deploy status, drift monitoring, scheduled audits) |
| Built-in `/review`, `/security-review` | Code review and security review on the current branch |

---

## How to read this

When starting a task, ask:

1. **What phase am I in?** (Discover / Define / Design / Develop /
   Deliver / Evolve)
2. **What L1 skill fits?** (default tools, always available)
3. **What bundle skill fits?** (only if a relevant bundle is installed)
4. **Any MCP / built-in command?** (Playwright for browser testing, gh
   for PRs, etc.)

If no skill fits well, that's a signal to either:
- Use general tools (Read/Edit/Write/Bash + reasoning), or
- Hunt for a new skill / plugin / MCP that would fit (see
  [EVOLUTION.md](EVOLUTION.md)).

---

## Coverage gaps (v0.1)

Phases or activities where **no bundle exists yet** and you'd be
relying on general tools + L1 skills:

| Domain | What's missing | Mitigation today |
|---|---|---|
| AI engineering (prompts, evals, agents) | No `ai-engineering` bundle | Use `claude-api` skill (L1) directly; codify eval patterns with `skill-creator` |
| Backend / API services | No `backend-api` bundle | TDD + general dev skills work fine |
| Data / research / notebooks | No `data-research` bundle | `xlsx`, `pdf`, `docx` skills (L1) cover most of it |
| Browser extensions | No `extension` bundle | Tech-stack-specific; falls under design-frontend for UI craft |
| Mobile (iOS / Android) | No mobile bundle | — |

These get authored as you encounter them. Don't pre-build.

---

## Update log

- 2026-05-04 — v0.1 initial capability map.
