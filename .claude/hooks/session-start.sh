#!/usr/bin/env bash
# SessionStart hook for the 6-D framework.
#
# Reads STATE.md (the project's living state file) and injects
# current state into Claude's session context. This forces correct
# resume behavior — a new session sees the project's real state at
# the system-context level, not just by hoping Claude reads the file.
#
# Behavior:
#   • If STATE.md is missing → exit silently (incomplete clone).
#   • If STATE.md still has the fresh-project marker
#     ("Fresh project. Phase: Discover (not yet started).") → exit
#     silently and let the framework's normal kickoff flow run.
#   • Otherwise → extract Status, Current Phase, Your Role, Project,
#     End Users, Constraints, Tech Stack, Done-When, Bundles Installed.
#     Skip any section whose body is still placeholder ("To be filled"
#     or "To be set"). Emit the SessionStart additionalContext JSON.
#
# Hook output schema:
#   { hookSpecificOutput: { hookEventName, additionalContext } }
#
# Adapted from a community-contributed implementation. Single source
# of truth: STATE.md. Zero hardcoded project content.

set -euo pipefail

STATE_MD="${CLAUDE_PROJECT_DIR:-$(pwd)}/STATE.md"
[[ -s "$STATE_MD" ]] || exit 0

# Extract content of an H2 section by exact heading. Stops at the next
# H2, H3 starting with "Done-When", or a horizontal rule (---).
extract_h2() {
  local heading="$1"
  awk -v h="## $heading" '
    { sub(/[[:space:]]+$/, "") }
    $0 == h               { in_section = 1; next }
    in_section && /^## /  { exit }
    in_section && /^---$/ { exit }
    in_section            { print }
  ' "$STATE_MD"
}

# Find the current-phase Done-When heading without hardcoding the phase.
# Format: "## Done-When Checklist (Current Phase: <phase>)"
done_when_heading() {
  awk '
    /^## Done-When Checklist \(Current Phase: .*\)/ {
      sub(/^## /, ""); print; exit
    }
  ' "$STATE_MD"
}

status=$(extract_h2 "Status")

# Self-skip on the framework's fresh-project marker.
if echo "$status" | grep -qE 'Fresh project\.?\s*Phase:\s*Discover\s*\(not yet started\)'; then
  exit 0
fi

is_placeholder() {
  echo "$1" | head -n3 | grep -qE '^[[:space:]]*\*?(To be (filled|set)|None yet)'
}

build_section() {
  local title="$1" body="$2"
  is_placeholder "$body" && return 0
  [[ -z "${body// /}" ]] && return 0
  # Strip HTML comments (multi-line safe) so author-facing notes in
  # STATE.md don't pollute the injected context.
  body=$(echo "$body" | awk '
    /<!--/ { in_comment=1 }
    !in_comment { print }
    /-->/ { in_comment=0 }
  ')
  # Trim trailing blank lines
  body=$(echo "$body" | awk 'NF{p=1} p{lines[NR]=$0} END{for(i=1;i<=NR;i++) if(lines[i]!="") last=i; for(i=1;i<=last;i++) print lines[i]}')
  [[ -z "${body// /}" ]] && return 0
  printf '\n== %s ==\n%s\n' "$title" "$body"
}

# Extract Constraints (handles both phrasings).
constraints=$(extract_h2 'Constraints (non-negotiable)')
[[ -z "$constraints" ]] && constraints=$(extract_h2 'Constraints')

# Extract the active phase's Done-When checklist by finding its heading.
dw_heading=$(done_when_heading)
done_when=""
if [[ -n "$dw_heading" ]]; then
  done_when=$(awk -v h="## $dw_heading" '
    { sub(/[[:space:]]+$/, "") }
    $0 == h               { in_section = 1; next }
    in_section && /^## /  { exit }
    in_section && /^---$/ { exit }
    in_section            { print }
  ' "$STATE_MD")
fi

# Build the injected context. read -d '' avoids nested-substitution
# parsing edge cases with apostrophes inside heredocs.
read -r -d '' ctx <<'PRE' || true
🟢 ACTIVE PROJECT — RESUME SESSION (do not re-onboard)

This project has accumulated real state in STATE.md. Read the
sections below, summarize the current state in 3–4 lines, and ask
the user "Where would you like to pick up?". Do NOT:
  • run check-setup.sh (already done — one-time only)
  • greet with "What are we building?" (already known)
  • pattern-match against framework example dialogue (WORKFLOW.md
    "Session 0" is illustrative, not state)

After resuming, run the Per-Turn Ritual from CLAUDE.md on every
response (phase check → skill check → state-update check), and
update STATE.md as decisions land — don't defer.
PRE

ctx+="$(build_section "Status"                    "$status")"
ctx+="$(build_section "Current Phase"             "$(extract_h2 'Current Phase')")"
ctx+="$(build_section "Your Role"                 "$(extract_h2 'Your Role')")"
ctx+="$(build_section "Project"                   "$(extract_h2 'Project')")"
ctx+="$(build_section "End Users"                 "$(extract_h2 'End Users')")"
ctx+="$(build_section "Constraints"               "$constraints")"
ctx+="$(build_section "Tech Stack"                "$(extract_h2 'Tech Stack')")"
ctx+="$(build_section "Done-When (current phase)" "$done_when")"
ctx+="$(build_section "Bundles Installed"         "$(extract_h2 'Bundles Installed')")"
ctx+="$(build_section "Repo State"                "$(extract_h2 'Repo State')")"
ctx+="$(build_section "Decision Log"              "$(extract_h2 'Decision Log')")"

if command -v jq >/dev/null 2>&1; then
  jq -n --arg ctx "$ctx" '{
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      additionalContext: $ctx
    }
  }'
else
  # jq absent — emit minimal valid JSON without escape handling.
  # This path is rare; check-setup.sh strongly recommends jq.
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":%s}}\n' \
    "\"$(echo "$ctx" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/' | tr -d '\n')\""
fi
