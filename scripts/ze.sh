#!/usr/bin/env bash
set -euo pipefail

SESSION="${1:-pixi-emacs}"

export TERMINFO_DIRS="$CONDA_PREFIX/share/terminfo:/usr/share/terminfo:/usr/lib/terminfo"
export XDG_CONFIG_HOME="$PIXI_PROJECT_ROOT/config"
export SHELL="$(which fish)"

# Fix SSH agent forwarding for persistent sessions.
# Per-session stable symlink so multiple users don't clobber each other's agent.
_ssh_sock="$HOME/.ssh/ssh_auth_sock_${SESSION}"
if [ -n "${SSH_AUTH_SOCK:-}" ] && [ "$SSH_AUTH_SOCK" != "$_ssh_sock" ]; then
    mkdir -p "$HOME/.ssh"
    ln -sf "$SSH_AUTH_SOCK" "$_ssh_sock"
fi
export SSH_AUTH_SOCK="$_ssh_sock"

exec zellij --config "$PIXI_PROJECT_ROOT/config/zellij/config.kdl" attach --create "$SESSION"
