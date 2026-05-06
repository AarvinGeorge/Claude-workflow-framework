#!/usr/bin/env bash
# install-bundle.sh — install a Claude-workflow-framework bundle into the current project.
#
# Usage:
#   ./.framework/scripts/install-bundle.sh <bundle-name>
#
# Example:
#   ./.framework/scripts/install-bundle.sh design-frontend
#
# What it does (v0.6+):
#   1. Copies bundle's skills/  → .claude-plugin/skills/
#   2. Merges bundle's settings-additions.json → .claude/settings.json (via jq)
#   3. Appends bundle's claude-md-additions.md → CLAUDE.md (static rules only)
#   4. Records install state in STATE.md:
#        - Marks Done-When "Bundle recommendation" line as installed
#        - Adds entry to "Bundles Installed" section (replacing placeholder)
#
# Run from the project root (where CLAUDE.md and STATE.md live).
# Idempotent: re-running for the same bundle is a no-op.

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
INSTALL_DATE=$(date +%Y-%m-%d)

if [[ ! -d "$BUNDLE_DIR" ]]; then
    echo "Error: bundle not found: $BUNDLE_DIR"
    echo "Run from the project root (the directory containing CLAUDE.md)."
    exit 1
fi

echo "Installing bundle: $BUNDLE"
echo

# 1. Copy skills
SKILLS_LIST=""
if [[ -d "$BUNDLE_DIR/skills" ]] && [[ -n "$(ls -A "$BUNDLE_DIR/skills" 2>/dev/null)" ]]; then
    mkdir -p .claude-plugin/skills
    cp -r "$BUNDLE_DIR/skills/"* .claude-plugin/skills/
    SKILLS_LIST=$(ls -1 "$BUNDLE_DIR/skills/" | tr '\n' ',' | sed 's/,$//; s/,/, /g')
    echo "  ✓ Skills copied to .claude-plugin/skills/ ($SKILLS_LIST)"
else
    echo "  · No skills to copy (bundle has no skills/ directory)"
fi

# 2. Merge settings.json
PLUGINS_LIST=""
if [[ -f "$BUNDLE_DIR/settings-additions.json" ]]; then
    if ! command -v jq >/dev/null 2>&1; then
        echo "  ⚠ jq not installed — skipping settings.json merge."
        echo "    Install with: brew install jq"
        echo "    Or merge manually: open $BUNDLE_DIR/settings-additions.json"
    else
        ADDITIONS=$(jq 'del(._comment)' "$BUNDLE_DIR/settings-additions.json")
        PLUGINS_LIST=$(echo "$ADDITIONS" | jq -r '.enabledPlugins // {} | keys | join(", ")')
        TMP=$(mktemp)
        jq --argjson additions "$ADDITIONS" '
            .enabledPlugins = ((.enabledPlugins // {}) + ($additions.enabledPlugins // {})) |
            .extraKnownMarketplaces = ((.extraKnownMarketplaces // {}) + ($additions.extraKnownMarketplaces // {}))
        ' .claude/settings.json > "$TMP"
        mv "$TMP" .claude/settings.json
        echo "  ✓ Merged settings into .claude/settings.json (plugins: $PLUGINS_LIST)"
    fi
fi

# 3. Append static design rules to CLAUDE.md
# (claude-md-additions.md is the v0.6+ name; falls back to claude-md-snippet.md
# for backward compat with older bundles.)
ADDITIONS_FILE=""
if [[ -f "$BUNDLE_DIR/claude-md-additions.md" ]]; then
    ADDITIONS_FILE="$BUNDLE_DIR/claude-md-additions.md"
elif [[ -f "$BUNDLE_DIR/claude-md-snippet.md" ]]; then
    ADDITIONS_FILE="$BUNDLE_DIR/claude-md-snippet.md"
fi

if [[ -n "$ADDITIONS_FILE" ]]; then
    if [[ ! -f "CLAUDE.md" ]]; then
        echo "  ⚠ CLAUDE.md not found — skipping additions append."
    elif grep -q "begin: $BUNDLE bundle additions" CLAUDE.md; then
        echo "  · CLAUDE.md already contains $BUNDLE additions — skipping"
    else
        {
            echo ""
            echo "<!-- begin: $BUNDLE bundle additions -->"
            cat "$ADDITIONS_FILE"
            echo "<!-- end: $BUNDLE bundle additions -->"
        } >> CLAUDE.md
        echo "  ✓ Appended bundle additions to CLAUDE.md"
    fi
fi

# 4. Record install state in STATE.md
if [[ -f "STATE.md" ]]; then

    # 4a. Mark Done-When "Bundle recommendation" line as installed (idempotent).
    # Pattern: "- [ ] Bundle recommendation*" → "- [x] Bundle recommendation — <bundle> installed YYYY-MM-DD"
    if grep -qE '^- \[ \] Bundle recommendation' STATE.md; then
        # Use a portable in-place sed (handles macOS BSD and GNU)
        sed -i.bak -E "s|^- \[ \] Bundle recommendation.*$|- [x] Bundle recommendation — ${BUNDLE} installed ${INSTALL_DATE}|" STATE.md
        rm -f STATE.md.bak
        echo "  ✓ Marked Done-When bundle line installed in STATE.md"
    fi

    # 4b. Update "Bundles Installed" section between markers.
    # Build the new entry (multi-line; awk reads this via a tmp file to preserve newlines).
    ENTRY_FILE=$(mktemp)
    {
        echo "- **${BUNDLE}** — installed ${INSTALL_DATE}"
        echo "  - skills: ${SKILLS_LIST:-(none)}"
        if [[ -n "$PLUGINS_LIST" ]]; then
            echo "  - plugins enabled: ${PLUGINS_LIST}"
        fi
        echo "  - cheatsheet: .framework/bundles/${BUNDLE}/skills-cheatsheet.md"
    } > "$ENTRY_FILE"

    # Idempotency: skip if this bundle is already listed in the markers block
    if awk '
        /<!-- bundles-installed:start -->/ { in_block=1; next }
        /<!-- bundles-installed:end -->/   { in_block=0 }
        in_block && /\*\*'"$BUNDLE"'\*\* — installed/ { found=1 }
        END { exit (found ? 0 : 1) }
    ' STATE.md; then
        echo "  · STATE.md already lists $BUNDLE — skipping"
    else
        TMP=$(mktemp)
        awk -v entry_file="$ENTRY_FILE" '
            BEGIN {
                # Slurp the entry block once
                while ((getline line < entry_file) > 0) entry = entry (entry == "" ? "" : "\n") line
                close(entry_file)
            }
            /<!-- bundles-installed:start -->/ { in_block=1; print; next }
            /<!-- bundles-installed:end -->/ {
                if (any_existing) {
                    print entry
                } else {
                    print entry
                }
                in_block=0; print; next
            }
            in_block {
                # Skip the "None yet" placeholder
                if ($0 ~ /^\*None yet/) next
                # Skip blank lines inside the block
                if ($0 ~ /^[[:space:]]*$/) next
                # Existing entries — keep
                any_existing=1
                print
                next
            }
            { print }
        ' STATE.md > "$TMP" && mv "$TMP" STATE.md
        echo "  ✓ Recorded $BUNDLE in STATE.md > Bundles Installed"
    fi
    rm -f "$ENTRY_FILE"
else
    echo "  ⚠ STATE.md not found — skipping state record."
    echo "    The framework requires STATE.md at project root (v0.6+)."
fi

echo
echo "Bundle '$BUNDLE' installed."
echo
echo "Next steps:"
echo "  1. Commit the changes:"
echo "       git add -A && git commit -m \"Install $BUNDLE bundle\""
echo "  2. Restart Claude Code so plugins register and the SessionStart"
echo "     hook sees committed state:"
echo "       /exit"
echo "       claude"
echo "  3. Verify: claude plugin list"
