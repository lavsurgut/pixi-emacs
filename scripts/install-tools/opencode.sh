#!/usr/bin/env bash
set -euo pipefail

if command -v opencode &>/dev/null; then
  echo "OpenCode already installed: $(opencode --version 2>&1)"
else
  echo "Installing OpenCode..."
  npm install -g opencode-ai@latest
  echo "OpenCode installed: $(opencode --version 2>&1)"
fi
