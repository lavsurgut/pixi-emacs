#!/usr/bin/env bash
set -euo pipefail

export TERMINFO_DIRS="$CONDA_PREFIX/share/terminfo:/usr/share/terminfo:/usr/lib/terminfo"
export XDG_CONFIG_HOME="$PIXI_PROJECT_ROOT/config"
export DOOMDIR="$PIXI_PROJECT_ROOT/.doom.d"
export EMACSDIR="$PIXI_PROJECT_ROOT/.doomemacs"

exec emacs -nw --init-directory="$PIXI_PROJECT_ROOT/.doomemacs"
