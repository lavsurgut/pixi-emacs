#!/usr/bin/env bash
set -euo pipefail

export DOOMDIR="$PIXI_PROJECT_ROOT/.doom.d"
export EMACSDIR="$PIXI_PROJECT_ROOT/.doomemacs"

"$PIXI_PROJECT_ROOT/.doomemacs/bin/doom" sync

# Provision tree-sitter grammars Doom doesn't install automatically.
bash "$(dirname "$0")/install-grammars.sh"
