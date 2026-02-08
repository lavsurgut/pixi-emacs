#!/usr/bin/env bash
set -euo pipefail

ROOT="${PIXI_PROJECT_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

echo "Removing Emacs source (.emacs-src)..."
rm -rf "$ROOT/.emacs-src"

echo "Removing Doom Emacs (.doomemacs)..."
rm -rf "$ROOT/.doomemacs"

echo "Removing pixi environment (.pixi)..."
rm -rf "$ROOT/.pixi"

echo "Clean complete. Run 'pixi run setup' to rebuild everything."
