#!/bin/bash
# Install Claude Code plugins in cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if ! claude plugin marketplace list 2>/dev/null | grep -q claude-plugins-official; then
  claude plugin marketplace add anthropics/claude-plugins-official >/dev/null
fi

PLUGINS=(
  superpowers@claude-plugins-official
  frontend-design@claude-plugins-official
)

installed="$(claude plugin list 2>/dev/null || true)"
for plugin in "${PLUGINS[@]}"; do
  if ! grep -q "$plugin" <<<"$installed"; then
    claude plugin install "$plugin" >/dev/null
  fi
done
