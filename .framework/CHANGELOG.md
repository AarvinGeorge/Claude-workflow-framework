# Changelog

## v0.4.0 — 2026-05-04

**Setup verification: framework now checks the user's environment and
helps install missing pieces.**

User feedback: "does this framework package the right skills out of the
box? if the skills or plugins are not present does it check the system,
confirm, and recommend setup with the help of Claude Code?" The honest
answer for v0.3 was *no*. The framework expected L1 plugins
(`superpowers`, `context7-plugin`) at user scope but didn't verify or
help install them. v0.4 closes this gap.

**Changes:**
- **Added `.framework/scripts/check-setup.sh`** — verifies tools (`claude`,
  `gh`, `jq`), L1 plugins at user scope (parses `claude plugin list
  --json` with jq), and project scaffold (`CLAUDE.md`, `.claude/`,
  `.framework/`). Exits 0 if all good, 1 with install commands if any
  missing.
- **Added "Session Start Verification" to CLAUDE.md.** Tells Claude to
  run `check-setup.sh` on the first session of a fresh project. If
  anything's missing, Claude reports what's missing, explains what each
  piece does, and offers to install via Bash with user approval.
  Skipped on subsequent sessions.
- **Rewrote root README** as a proper framework README. Explains
  philosophy (3 principles), what's in the box vs. expected, what
  Claude actually does at each stage, honest limits, and how the
  framework evolves. Each claim is now backed by a concrete file or
  script.
- **Rewrote `.framework/README.md`** as a slim docs index — quick links
  to METHODOLOGY, CAPABILITY_MAP, EVOLUTION, scripts, and bundles.

**Verifiable now (audited against the README):**
- "2 commands and Claude is ready" → true; first command clones, second
  starts Claude which verifies setup
- "Framework checks setup on first session" → true; `check-setup.sh`
  exists and CLAUDE.md instructs Claude to run it
- "Claude offers to install missing pieces" → true; CLAUDE.md
  guidance tells Claude how
- "Right skills out of the box" → true with caveat: L2 (bundles) ship
  here, L1 (universal) is verified-and-installed-on-demand

**Known limitations:**
- `check-setup.sh` is bash-only (Windows users need WSL).
- Plugin install via Claude Code still requires manual restart for
  plugins to register; that's a Claude Code limitation, not framework.
- L1 plugin list is currently fixed (`superpowers`, `context7-plugin`).
  Future versions may expand or make it configurable.

---

## v0.3.0 — 2026-05-04

**Continuous guidance: the framework now guides Claude every turn,
not just at kickoff.**

User feedback: even with v0.2's zero-prep bootstrap, the framework
only really kicked in at the start. Bundle install was still a manual
step the user had to know to run, and skill invocation was reactive
(based on each skill's own description) rather than methodology-driven.
The framework promised "guide me throughout" but only delivered "set
me up."

**Changes:**
- **Dropped the `.template` suffix on CLAUDE.md.** Clone gives you a
  working CLAUDE.md immediately. New-project flow is now 2 commands
  (was 3).
- **Added Per-Turn Ritual to CLAUDE.md.** Claude runs a 3-question
  check before every response: (1) what phase are we in, (2) does a
  skill match this task, (3) does this complete a phase or change
  state. Non-negotiable — turns CLAUDE.md from a static charter into
  a live runbook.
- **Added Bundle Selection guidance to CLAUDE.md.** Claude proactively
  recommends bundles after Discover yields project type, frames as
  *capabilities* (not architecture), and runs the install script
  itself on user approval. The user never has to know which bundle to
  install up front.
- **Added Done-When checklist for current phase.** CLAUDE.md tracks
  phase-completion criteria visibly. When Phase 1 is done, the
  checklist gets replaced with Phase 2's criteria (and `Current Phase`
  updates) in the same response.
- **Updated METHODOLOGY.md Phase 1 outputs** to include bundle
  recommendation as an explicit Discover deliverable.
- **Updated all docs** to reflect 2-command flow.

**New-project flow** (was 3+ commands plus knowledge of bundles, now
just 2):
```bash
gh repo create … --template AarvinGeorge/Claude-workflow-framework --private --clone
cd <project>
claude
```

After `claude` opens, everything is conversation. Claude greets, asks
the discovery question, walks Phase 1, recommends a bundle when
appropriate, installs on approval, transitions phases on completion.

**Known limitations:**
- Per-Turn Ritual depends on Claude honoring it. Long contexts may see
  drift; a fresh session re-reads CLAUDE.md and re-anchors.
- Phase transitions still rely on Claude noticing them. The Done-When
  checklist makes this visible but not automatic.
- Restart for plugins is still a Claude Code limitation, not framework.

---

## v0.2.0 — 2026-05-04

**Philosophy shift: discovery happens with Claude, not before it.**

User feedback (paraphrased): the v0.1 init flow was too manual and
hands-on, and asking the user to fill in placeholders like end-users,
constraints, and tech stack before Phase 1 was anti-methodology — those
*emerge from* discovery, they don't precede it. The framework's job is
to get Claude ready to facilitate discovery, not to bypass it with a
form.

**Changes:**
- **Restructured for zero-prep bootstrap.** Template files moved to
  repo root; framework docs and bundles moved to `.framework/`. After
  `gh repo create --template`, the new project has the right layout
  immediately — no `mv` dance, no manual restructure.
- **Rewrote `CLAUDE.md.template` as a kickoff doc.** Tells Claude the
  project is fresh and to facilitate Phase 1 with the user. Sections
  marked "to be filled during Phase X" instead of `<placeholder>`
  markers — Claude updates them in conversation as facts solidify.
- **Added `.framework/scripts/install-bundle.sh`.** Single command does
  cp + jq merge of settings + appended CLAUDE.md snippet (with
  delimiters, idempotent). Bundle install is now one command.
- **Dropped planned `init-project.sh`.** Wrong instinct — that script
  would have demanded answers Claude can derive from discovery itself.
- **Updated `INIT.md`, `BUNDLE_GUIDE.md`, `bundles/design-frontend/README.md`**
  to reflect the new flow.
- **Added project README starter** at repo root (replaceable by user
  once Phase 1 yields a project summary).

**New-project flow** (was 10 manual steps, now 4 commands):
```bash
gh repo create … --template AarvinGeorge/Claude-workflow-framework --private --clone
cd <project>
mv CLAUDE.md.template CLAUDE.md
./.framework/scripts/install-bundle.sh design-frontend     # optional
claude
```

**Known limitations:**
- Bundle install script requires `jq`. Falls back to a clear warning if
  jq isn't installed.
- CLAUDE.md snippet append is end-of-file; user moves sections if they
  want different placement (delimiters mark the bundle's content).
- Still only one bundle (`design-frontend`). Others authored as needed.

---

## v0.1.0 — 2026-05-04

Initial extraction from the AI Assistant Platform project.

**Included:**
- 6 D's methodology (`METHODOLOGY.md`)
- Capability map for currently-installed skills (`CAPABILITY_MAP.md`)
- Evolution loop for adding new skills (`EVOLUTION.md`)
- New-project init checklist (`INIT.md`)
- Project template (`templates/`):
  - `CLAUDE.md.template` with placeholder sections
  - Baseline `.claude/settings.json`
  - Local plugin shell at `.claude-plugin/`
  - Standard `.gitignore`
- One bundle:
  - `design-frontend` — shadcn + emil-design-eng skills,
    CLAUDE.md snippet, settings additions, skills cheatsheet

**Known limitations:**
- Only one bundle. AI engineering, backend, data-research bundles to
  come as projects need them.
- No automated bundle install script — manual copy steps documented in
  bundle READMEs.
- Untested on a real new-project bootstrap. v0.2 will incorporate
  friction discovered when first used.
