#!/usr/bin/env bash
set -euo pipefail

export DOOMDIR="$PIXI_PROJECT_ROOT/.doom.d"
export EMACSDIR="$PIXI_PROJECT_ROOT/.doomemacs"

exec "$PIXI_PROJECT_ROOT/.doomemacs/bin/doom" sync
