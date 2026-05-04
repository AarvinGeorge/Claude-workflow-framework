# Changelog

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
