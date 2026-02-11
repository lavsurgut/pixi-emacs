if status is-interactive
    set -gx DIRENV_LOG_FORMAT ""
    set -gx DOOMDIR $PIXI_PROJECT_ROOT/.doom.d
    set -gx EMACSDIR $PIXI_PROJECT_ROOT/.doomemacs
    set -gx TERMINFO_DIRS $CONDA_PREFIX/share/terminfo:/usr/share/terminfo:/usr/lib/terminfo
    set -gx LD_LIBRARY_PATH $CONDA_PREFIX/lib $LD_LIBRARY_PATH

    # Fix SSH agent forwarding for persistent sessions (zellij).
    # Update stable symlink so existing sessions pick up a reconnected agent.
    if set -q SSH_AUTH_SOCK; and test "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock"
        mkdir -p $HOME/.ssh
        ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
    end
    set -gx SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock

    alias emacs "TERM=xterm-256color command emacs -nw --init-directory=$PIXI_PROJECT_ROOT/.doomemacs"

    starship init fish | source
    atuin init fish | source
    zoxide init fish | source
    direnv hook fish | source

    alias zi "z -i"

    fish_vi_key_bindings
    set fish_vi_force_cursor
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block

    set -g fish_greeting
    set -gx COLORTERM truecolor
end
