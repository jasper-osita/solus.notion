#!/bin/bash
# Install the superpowers plugin in Claude Code cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if ! claude plugin marketplace list 2>/dev/null | grep -q claude-plugins-official; then
  claude plugin marketplace add anthropics/claude-plugins-official >/dev/null
fi

if ! claude plugin list 2>/dev/null | grep -q 'superpowers@claude-plugins-official'; then
  claude plugin install superpowers@claude-plugins-official >/dev/null
fi
