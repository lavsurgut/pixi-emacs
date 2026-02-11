#!/usr/bin/env bash
set -euo pipefail

SESSION="${1:-pixi-emacs}"

export TERMINFO_DIRS="$CONDA_PREFIX/share/terminfo:/usr/share/terminfo:/usr/lib/terminfo"
export XDG_CONFIG_HOME="$PIXI_PROJECT_ROOT/config"
export SHELL="$(which fish)"

# Fix SSH agent forwarding for persistent sessions.
# Creates a stable symlink so existing zellij sessions pick up a reconnected agent.
if [ -n "${SSH_AUTH_SOCK:-}" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]; then
    mkdir -p "$HOME/.ssh"
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
fi
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

exec zellij --config "$PIXI_PROJECT_ROOT/config/zellij/config.kdl" attach --create "$SESSION"
