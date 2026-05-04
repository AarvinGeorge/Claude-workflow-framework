#!/usr/bin/env bash
# install-bundle.sh — install a Claude-workflow-framework bundle into the current project.
#
# Usage:
#   ./.framework/scripts/install-bundle.sh <bundle-name>
#
# Example:
#   ./.framework/scripts/install-bundle.sh design-frontend
#
# What it does:
#   1. Copies bundle's skills/ into .claude-plugin/skills/
#   2. Merges bundle's settings-additions.json into .claude/settings.json (via jq)
#   3. Appends bundle's claude-md-snippet.md to CLAUDE.md (with delimiters)
#
# Run from the project root (where CLAUDE.md lives).

set -euo pipefail

BUNDLE="${1:-}"
if [[ -z "$BUNDLE" ]]; then
    echo "Usage: $0 <bundle-name>"
    echo
    echo "Available bundles:"
    ls -1 .framework/bundles/ 2>/dev/null | grep -v '\.md$' || echo "  (none found)"
    exit 1
fi

BUNDLE_DIR=".framework/bundles/$BUNDLE"

if [[ ! -d "$BUNDLE_DIR" ]]; then
    echo "Error: bundle not found: $BUNDLE_DIR"
    echo "Run from the project root (the directory containing CLAUDE.md)."
    exit 1
fi

echo "Installing bundle: $BUNDLE"
echo

# 1. Copy skills
if [[ -d "$BUNDLE_DIR/skills" ]] && [[ -n "$(ls -A "$BUNDLE_DIR/skills" 2>/dev/null)" ]]; then
    mkdir -p .claude-plugin/skills
    cp -r "$BUNDLE_DIR/skills/"* .claude-plugin/skills/
    echo "  ✓ Skills copied to .claude-plugin/skills/"
else
    echo "  · No skills to copy (bundle has no skills/ directory)"
fi

# 2. Merge settings.json
if [[ -f "$BUNDLE_DIR/settings-additions.json" ]]; then
    if ! command -v jq >/dev/null 2>&1; then
        echo "  ⚠ jq not installed — skipping settings.json merge."
        echo "    Install with: brew install jq"
        echo "    Or merge manually: open $BUNDLE_DIR/settings-additions.json"
    else
        # Strip the _comment field before merging
        ADDITIONS=$(jq 'del(._comment)' "$BUNDLE_DIR/settings-additions.json")
        TMP=$(mktemp)
        jq --argjson additions "$ADDITIONS" '
            .enabledPlugins = ((.enabledPlugins // {}) + ($additions.enabledPlugins // {})) |
            .extraKnownMarketplaces = ((.extraKnownMarketplaces // {}) + ($additions.extraKnownMarketplaces // {}))
        ' .claude/settings.json > "$TMP"
        mv "$TMP" .claude/settings.json
        echo "  ✓ Merged settings into .claude/settings.json"
    fi
fi

# 3. Append CLAUDE.md snippet
if [[ -f "$BUNDLE_DIR/claude-md-snippet.md" ]]; then
    if [[ ! -f "CLAUDE.md" ]]; then
        echo "  ⚠ CLAUDE.md not found — skipping snippet append."
        echo "    Did you rename CLAUDE.md.template to CLAUDE.md yet?"
    else
        # Idempotency check — don't append twice
        if grep -q "begin: $BUNDLE bundle additions" CLAUDE.md; then
            echo "  · CLAUDE.md already contains $BUNDLE additions — skipping"
        else
            {
                echo ""
                echo "<!-- begin: $BUNDLE bundle additions -->"
                cat "$BUNDLE_DIR/claude-md-snippet.md"
                echo "<!-- end: $BUNDLE bundle additions -->"
            } >> CLAUDE.md
            echo "  ✓ Appended snippet to CLAUDE.md"
            echo "    Note: snippet appended at end. Move sections to fit your"
            echo "    document structure if desired (see delimiters)."
        fi
    fi
fi

echo
echo "Bundle '$BUNDLE' installed."
echo "Next: restart Claude Code (\`/exit\` then \`claude\`) to pick up new plugins."
echo "Verify with: claude plugin list"
