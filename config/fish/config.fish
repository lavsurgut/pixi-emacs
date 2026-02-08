if status is-interactive
    set -gx DIRENV_LOG_FORMAT ""
    set -gx DOOMDIR $PIXI_PROJECT_ROOT/.doom.d
    set -gx EMACSDIR $PIXI_PROJECT_ROOT/.doomemacs
    set -gx TERMINFO_DIRS $CONDA_PREFIX/share/terminfo:/usr/share/terminfo:/usr/lib/terminfo

    alias emacs "TERM=xterm-256color command emacs -nw --init-directory=$PIXI_PROJECT_ROOT/.doomemacs"

    atuin init fish | source
    direnv hook fish | source

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
