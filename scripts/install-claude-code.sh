#!/usr/bin/env bash
set -euo pipefail

if command -v claude &>/dev/null; then
  echo "Claude Code already installed: $(claude --version 2>&1)"
else
  echo "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
  echo "Claude Code installed: $(claude --version 2>&1)"
fi
