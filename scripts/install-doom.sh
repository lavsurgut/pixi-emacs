#!/usr/bin/env bash
set -euo pipefail

if [ ! -d "$PIXI_PROJECT_ROOT/.doomemacs" ]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs "$PIXI_PROJECT_ROOT/.doomemacs"
fi

DOOMDIR="$PIXI_PROJECT_ROOT/.doom.d" \
EMACSDIR="$PIXI_PROJECT_ROOT/.doomemacs" \
  "$PIXI_PROJECT_ROOT/.doomemacs/bin/doom" install --no-config --env
