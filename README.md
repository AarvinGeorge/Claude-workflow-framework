# <project name>

*Replace this README with your project's own once Phase 1 (Discover)
yields a clear summary.*

---

## What this is

This project was created from the
[Claude Workflow Framework](https://github.com/AarvinGeorge/Claude-workflow-framework).
The framework's docs and bundles live in [`.framework/`](.framework/).

## How to start

1. Rename the project charter:
   ```bash
   mv CLAUDE.md.template CLAUDE.md
   ```
2. (Optional) Install a bundle that fits the project domain. See
   [`.framework/bundles/BUNDLE_GUIDE.md`](.framework/bundles/BUNDLE_GUIDE.md):
   ```bash
   ./.framework/scripts/install-bundle.sh design-frontend
   ```
3. Open Claude Code in this directory:
   ```bash
   claude
   ```

Claude reads `CLAUDE.md`, sees the project is fresh, and starts Phase 1
(Discover) with you. No placeholders to fill in up front — discovery
happens in conversation.

## Methodology

Follows the 6 D's: Discover → Define → Design → Develop → Deliver →
Evolve. See [`.framework/METHODOLOGY.md`](.framework/METHODOLOGY.md).
