#!/usr/bin/env bash
# ollama-runner.sh — Run a prompt through a local Ollama model
#
# Usage:
#   ./ollama-runner.sh <model> <prompt>
#
# Examples:
#   ./ollama-runner.sh deepseek-r1:7b "Analyze this research idea: ..."
#   ./ollama-runner.sh phi4-reasoning "Write an abstract for: ..."
#   ./ollama-runner.sh glm4:9b-chat-q4_K_M "Synthesize these sections: ..."

set -euo pipefail

MODEL="${1:?Error: model name required. Usage: ollama-runner.sh <model> <prompt>}"
PROMPT="${2:?Error: prompt required. Usage: ollama-runner.sh <model> <prompt>}"

# Verify ollama is in PATH
if ! command -v ollama &>/dev/null; then
  echo "Error: ollama is not installed or not in PATH." >&2
  echo "Install from: https://ollama.com/download" >&2
  exit 1
fi

# Verify the model is available locally
if ! ollama list 2>/dev/null | awk 'NR>1 {print $1}' | grep -qx "${MODEL}"; then
  echo "Error: Model '${MODEL}' is not pulled locally." >&2
  echo "Pull it with: ollama pull ${MODEL}" >&2
  echo "" >&2
  echo "Available models:" >&2
  ollama list 2>/dev/null || echo "(could not list models)" >&2
  exit 1
fi

# Run the model and stream output
ollama run "${MODEL}" "${PROMPT}"
