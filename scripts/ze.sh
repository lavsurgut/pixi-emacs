#!/usr/bin/env bash
set -euo pipefail

SESSION="${1:-pixi-emacs}"

export TERMINFO_DIRS="$CONDA_PREFIX/share/terminfo:/usr/share/terminfo:/usr/lib/terminfo"
export XDG_CONFIG_HOME="$PIXI_PROJECT_ROOT/config"
export SHELL="$(which fish)"

exec zellij --config "$PIXI_PROJECT_ROOT/config/zellij/config.kdl" attach --create "$SESSION"
