#!/usr/bin/env bash
# TaskCompleted hook — runs when a task is about to be marked complete.
# Exit with code 2 to block completion and send feedback to the teammate.
# Exit with code 0 to allow the task to be marked complete.
#
# Environment variables available (set by Claude Code):
#   CLAUDE_TASK_NAME       - name/title of the task being completed
#   CLAUDE_TEAMMATE_NAME   - name of the teammate marking it complete
#   CLAUDE_TEAM_NAME       - name of the current team

set -euo pipefail

TASK="${CLAUDE_TASK_NAME:-unknown}"
TEAMMATE="${CLAUDE_TEAMMATE_NAME:-unknown}"
TEAM="${CLAUDE_TEAM_NAME:-unknown}"

# ── Helper: check that a required file pattern exists ───────────────────────

file_exists_matching() {
  local pattern="$1"
  # Use find to check for any matching file
  if find . -maxdepth 4 -name "${pattern}" -not -path '*/.git/*' | grep -q .; then
    return 0
  fi
  return 1
}

# ── Per-teammate task completion gates ──────────────────────────────────────

case "${TEAMMATE}" in

  hypothesis-generation)
    if ! file_exists_matching "hypotheses*.md" && ! file_exists_matching "hypothesis-*.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The hypothesis-generation teammate must produce a 'hypotheses.md' (or similar) file with ranked hypotheses before completing." >&2
      exit 2
    fi
    ;;

  literature-synthesis)
    if ! file_exists_matching "synthesis*.md" && ! file_exists_matching "literature-*.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The literature-synthesis teammate must produce a synthesis document (e.g. 'synthesis.md') before completing." >&2
      exit 2
    fi
    ;;

  experiment-design)
    if ! file_exists_matching "experiment-plan*.md" && ! file_exists_matching "experiment*.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The experiment-design teammate must produce an experiment plan document before completing." >&2
      exit 2
    fi
    ;;

  prd-writer)
    if ! file_exists_matching "*.prd.md" && ! file_exists_matching "prd-*.md" && ! file_exists_matching "PRD*.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The prd-writer teammate must produce a PRD document before completing." >&2
      exit 2
    fi
    ;;

  roadmap-planner)
    if ! file_exists_matching "roadmap*.md" && ! file_exists_matching "ROADMAP*.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The roadmap-planner teammate must produce a roadmap document before completing." >&2
      exit 2
    fi
    ;;

  proposal-writer|proposal-automation)
    if ! file_exists_matching "proposal*.md" && ! file_exists_matching "PROPOSAL*.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The proposal teammate must produce a proposal document before completing." >&2
      exit 2
    fi
    ;;

  whitepaper-engine)
    if ! file_exists_matching "whitepaper*.md" && ! file_exists_matching "*.whitepaper.md"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The whitepaper-engine teammate must produce a whitepaper document before completing." >&2
      exit 2
    fi
    ;;

  research-writing|ieee-paper-generator)
    if ! file_exists_matching "paper*.md" && ! file_exists_matching "manuscript*.md" && ! file_exists_matching "*.pdf"; then
      echo "FEEDBACK: Task '${TASK}' cannot be marked complete. The research writing teammate must produce a paper or manuscript file before completing." >&2
      exit 2
    fi
    ;;

  # All other teammates — no file-based gate, allow completion
  *)
    exit 0
    ;;

esac

exit 0
