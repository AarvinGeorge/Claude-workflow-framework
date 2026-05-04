# Changelog

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
