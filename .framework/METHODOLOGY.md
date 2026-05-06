# The 6 D's — Methodology

The shape of every project, regardless of domain. AI engineering, web
apps, browser extensions, CLI tools, mobile, data work — all fit this
backbone. The **shape** never changes; the **content** of each phase
varies by project type.

```
Discover → Define → Design → Develop → Deliver → Evolve
```

Each phase has: **purpose**, **typical activities**, **outputs**,
**done-when** criteria. Skills suggested per phase live in
[CAPABILITY_MAP.md](CAPABILITY_MAP.md).

---

## 1. Discover

**Purpose.** Frame the problem. Understand who you're building for, what
they need, and whether the problem is worth solving.

**Activities.**
- Stakeholder / user conversations
- Market and competitor scan
- Tech feasibility check (libraries, models, costs)
- *AI-engineering twist:* data availability check, model capability
  survey, baseline cost/latency estimate

**Outputs.**
- Problem statement (1-pager)
- Stakeholder map
- Competitor / reference notes
- Feasibility assessment
- **Bundle recommendation** — which framework bundle (if any) fits the
  project. Claude should propose this proactively based on project type;
  see CLAUDE.md's *Bundle Selection* section for the recommendation
  workflow; install state is recorded automatically in STATE.md
  workflow.

**Done when.** You can state in one sentence: *who* the user is, *what*
they're trying to do, *why* current options fail them, and *whether*
this is technically buildable. AND: a bundle has been recommended (and
installed if applicable) or it's been confirmed that no bundle fits.

---

## 2. Define

**Purpose.** Lock the scope. Turn a fuzzy problem into a measurable spec
with clear success criteria.

**Activities.**
- Personas, user stories, JTBD
- Functional requirements + non-functional constraints (compliance,
  performance, accessibility)
- Success metrics — how you'll know it works
- *AI-engineering twist:* **eval design** (write evals before features),
  safety constraints, hallucination tolerance, refusal patterns

**Outputs.**
- `research/personas.md`, `research/user-stories.md`
- Constraints + End Users sections filled in `STATE.md`
- Eval suite (for AI projects) or test plan (for non-AI)

**Done when.** Anyone reading the project charter can predict whether a
proposed feature is in or out of scope.

---

## 3. Design

**Purpose.** Decide *how* to build it. Architecture, UX, data model,
contracts.

**Activities.**
- System architecture / data flow
- API contracts, type definitions
- UX flows + wireframes (low-fi → high-fi)
- Design system / token decisions
- *AI-engineering twist:* prompt design, agent topology, RAG vs
  fine-tune choice, model selection, tool/function spec

**Outputs.**
- Architecture sketch (markdown or diagram)
- Wireframes / Figma artifacts
- API / type contracts
- `.interface-design/system.md` (if frontend)
- Prompt library / agent spec (if AI)

**Done when.** You could hand the design to another engineer and they'd
build the same thing.

---

## 4. Develop

**Purpose.** Build it. Test-first, incrementally, with verifiable
checkpoints.

**Activities.**
- Test-driven implementation
- Component / endpoint authoring
- Integration with external systems
- Parallel work via worktrees / subagents when tasks are independent
- *AI-engineering twist:* prompt iteration, eval-driven dev, caching
  strategy, model fallback paths

**Outputs.**
- Working code with passing tests
- Storybook stories / API docs / notebook outputs
- Code Connect mappings (if Figma-linked design system)

**Done when.** Tests pass, the feature works in a manual smoke test, and
the change is reviewable in a single PR.

---

## 5. Deliver

**Purpose.** Verify quality, ship safely, observe in production.

**Activities.**
- Code review (self + peer)
- Design audit / craft polish
- Security + a11y review
- Staged rollout / feature flags
- Instrumentation
- *AI-engineering twist:* offline + online evals, red-team probes,
  cost/latency benchmarks, observability for traces

**Outputs.**
- Reviewed PR, merged
- Deployed artifact (extension build, web deploy, model release)
- Dashboards / alerts wired

**Done when.** It's live, you can see it working, and you'd know within
minutes if it broke.

---

## 6. Evolve

**Purpose.** Learn. Codify what worked. Refactor what didn't. Retire
what's obsolete.

**Activities.**
- Capture patterns into reusable skills (`skill-creator`)
- Update memory / docs / capability map
- Refactor for simplicity (`/simplify`)
- Drift checks for AI: re-run evals, monitor live metrics
- Bump model versions when warranted

**Outputs.**
- New / updated skills
- Updated `system.md`, `tokens.json`, `CHANGELOG.md`
- Backported framework improvements (this repo)

**Done when.** The next project that needs this pattern can pick it up
without re-discovering it from scratch.

---

## How to use this in a session

1. Read this file at project start (it's small).
2. Identify which phase you're in.
3. Consult [CAPABILITY_MAP.md](CAPABILITY_MAP.md) for the skills that
   accelerate that phase.
4. When transitioning phases, **pause** and confirm done-when criteria.
   Don't start *Develop* before *Design* is locked. Don't claim
   *Deliver* without verification.

The 6 D's aren't a one-pass waterfall — you'll loop. Discover often
re-opens during Define. Design often gets revised during Develop. The
framing exists to keep you honest about *which* mode you're in at any
moment, not to gate you.
