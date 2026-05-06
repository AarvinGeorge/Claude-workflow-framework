#!/usr/bin/env bash
# check-setup.sh — verify framework prerequisites are in place.
#
# Usage:
#   ./.framework/scripts/check-setup.sh
#
# Run from project root. Reports tool and plugin status. Exits 0 if
# everything's present, 1 if anything is missing.
#
# Designed to be called by Claude on the first session of a new project,
# so missing pieces can be flagged and offered to the user.

set +e   # we want to keep going even if individual checks fail

ALL_OK=1

green()  { printf "  \033[32m✓\033[0m %s\n" "$1"; }
yellow() { printf "  \033[33m·\033[0m %s\n" "$1"; }
red()    { printf "  \033[31m✗\033[0m %s\n" "$1"; ALL_OK=0; }

echo "Checking framework prerequisites…"
echo

# 1. CLI tools
echo "Tools:"
for tool in claude gh jq; do
    if command -v "$tool" >/dev/null 2>&1; then
        green "$tool installed"
    else
        case "$tool" in
            claude) red "claude (Claude Code CLI) NOT FOUND — install from https://claude.com/claude-code" ;;
            gh)     red "gh (GitHub CLI) NOT FOUND — install: brew install gh" ;;
            jq)     red "jq NOT FOUND — install: brew install jq (needed for bundle install)" ;;
        esac
    fi
done

echo

# 2. L1 plugins (user scope)
echo "Always-on plugins (user scope):"

USER_PLUGIN_IDS=""
if command -v claude >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    USER_PLUGIN_IDS=$(claude plugin list --json 2>/dev/null \
        | jq -r '.[] | select(.scope == "user" and .enabled == true) | .id' 2>/dev/null || echo "")
fi

# Plugins to look for. Each entry is "<plugin-id-fragment>|<description>|<install command>"
# The fragment is matched against the .id field (e.g. "superpowers@superpowers-marketplace").
declare -a L1_PLUGINS=(
    "superpowers|brainstorming, TDD, debugging, verification — process discipline|claude plugin install superpowers --scope user"
    "context7|library documentation lookup|claude plugin install context7-plugin --scope user"
)

for entry in "${L1_PLUGINS[@]}"; do
    IFS='|' read -r ID DESC CMD <<< "$entry"
    if echo "$USER_PLUGIN_IDS" | grep -qi "^${ID}"; then
        green "$ID installed — $DESC"
    else
        red "$ID NOT installed at user scope — $DESC"
        printf "      install: %s\n" "$CMD"
    fi
done

echo

# 3. Project-scope local plugin (should be enabled from the template)
echo "Project setup:"
if [[ -f .claude/settings.json ]]; then
    if grep -q "local-toolkit@local" .claude/settings.json 2>/dev/null; then
        green "local-toolkit@local enabled at project scope"
    else
        yellow "local-toolkit@local not found in .claude/settings.json (template may have been modified)"
    fi
else
    red ".claude/settings.json missing — template scaffold incomplete"
fi

if [[ -f CLAUDE.md ]]; then
    green "CLAUDE.md present at project root"
else
    red "CLAUDE.md missing — clone may be incomplete"
fi

if [[ -f STATE.md ]]; then
    green "STATE.md present at project root (living state)"
else
    red "STATE.md missing — required by v0.6+ for cross-session resume"
    printf "      see .framework/CHANGELOG.md for the v0.6 architecture change\n"
fi

if [[ -d .framework ]]; then
    green ".framework/ directory present"
else
    red ".framework/ missing — clone may be incomplete"
fi

if [[ -f .claude/hooks/session-start.sh ]]; then
    if [[ -x .claude/hooks/session-start.sh ]]; then
        green "SessionStart hook installed and executable"
    else
        yellow "SessionStart hook present but not executable (run: chmod +x .claude/hooks/session-start.sh)"
    fi
else
    yellow "SessionStart hook missing — cross-session resume may degrade"
    printf "      expected: .claude/hooks/session-start.sh\n"
fi

echo

# Summary
if [[ $ALL_OK -eq 1 ]]; then
    echo "All prerequisites satisfied."
    exit 0
else
    echo "Some prerequisites are missing. See messages above."
    echo
    echo "Claude can run the install commands for you with your approval."
    exit 1
fi
