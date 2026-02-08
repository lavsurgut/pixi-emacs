#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/install-tools" && pwd)"

for script in "$SCRIPT_DIR"/*.sh; do
  echo "==> Running $(basename "$script")..."
  bash "$script"
done

echo "All tools installed successfully."
