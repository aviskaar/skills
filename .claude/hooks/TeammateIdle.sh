#!/usr/bin/env bash
# TeammateIdle hook — runs when a teammate is about to go idle.
# Exit with code 2 to send feedback and keep the teammate working.
# Exit with code 0 to allow the teammate to go idle normally.
#
# Environment variables available (set by Claude Code):
#   CLAUDE_TEAMMATE_NAME   - name of the teammate about to go idle
#   CLAUDE_TASK_NAME       - name of the task the teammate was working on
#   CLAUDE_TEAM_NAME       - name of the current team

set -euo pipefail

TEAMMATE="${CLAUDE_TEAMMATE_NAME:-unknown}"
TASK="${CLAUDE_TASK_NAME:-unknown}"
TEAM="${CLAUDE_TEAM_NAME:-unknown}"

# ── Skill-layer output requirements ─────────────────────────────────────────
# Each layer must produce a named deliverable before going idle.

check_task_layer() {
  # Task-layer teammates must produce at least one output file.
  # Common output locations checked relative to the repo root.
  local output_dirs=("output" "research" "reports" "deliverables" "docs")
  for dir in "${output_dirs[@]}"; do
    if [ -d "$dir" ] && [ "$(ls -A "$dir" 2>/dev/null)" ]; then
      return 0
    fi
  done
  echo "FEEDBACK: Teammate '${TEAMMATE}' completed task '${TASK}' but no output file was found in expected directories (output/, research/, reports/, deliverables/, docs/). Please produce a named deliverable file before going idle." >&2
  exit 2
}

check_orchestrator_layer() {
  # Orchestrator teammates must leave a coordination note or status update.
  local status_files=("STATUS.md" "COORDINATION.md" "team-status.md" ".team-status")
  for f in "${status_files[@]}"; do
    if [ -f "$f" ]; then
      return 0
    fi
  done
  # Soft warning only for orchestrators — they may legitimately idle between delegation cycles.
  return 0
}

# ── Main validation ──────────────────────────────────────────────────────────

case "${TEAMMATE}" in
  # Task-layer specialists — must produce a file output
  hypothesis-generation|literature-synthesis|experiment-design|code-replication|\
  research-writing|ieee-paper-generator|auto-website-builder|\
  seo-automation|whitepaper-engine|paid-ads-manager|lead-routing|customer-intel|\
  community-builder|stakeholder-intel|competitive-research|idea-generation|\
  prd-writer|roadmap-planner|proposal-writer|proposal-automation|calendar-pipeline)
    check_task_layer
    ;;

  # Orchestrator / portfolio layer — lighter gate
  lead-researcher|ai-engineer|auto-benchmark|\
  principal-scientist|content-marketing|demand-gen|\
  product-marketing|community-growth|events-webinars|retention-marketing|\
  pm-lead)
    check_orchestrator_layer
    ;;

  # Strategic leads — no automated gate; human reviews findings
  computer-scientist|cmo-marketing|pm-ai-research)
    exit 0
    ;;

  *)
    # Unknown teammate — allow idle, log a warning
    echo "WARNING: Unknown teammate '${TEAMMATE}' in team '${TEAM}'. No quality gate applied." >&2
    exit 0
    ;;
esac

exit 0
