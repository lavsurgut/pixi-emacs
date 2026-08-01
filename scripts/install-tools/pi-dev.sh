#!/usr/bin/env bash
set -euo pipefail

if command -v pi &>/dev/null; then
  echo "Pi.dev already installed: $(pi --version 2>&1)"
else
  echo "Installing pi.dev..."
  curl -fsSL https://pi.dev/install.sh | sh
  echo "Pi.dev installed: $(pi --version 2>&1)"
fi

