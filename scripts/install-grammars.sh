#!/usr/bin/env bash
set -euo pipefail

# Install tree-sitter grammars that Doom does not provision automatically.
#
# Our Emacs links conda-forge's libtree-sitter 0.23 (pinned <0.24 in pixi.toml,
# because Emacs 30.1 still calls `ts_language_version', which libtree-sitter
# 0.25 removed). That only supports grammar ABI <=14, so grammar sources must be
# pinned to ABI-compatible revisions. See .doom.d/config.el for the matching
# `treesit-language-source-alist' override.

ROOT="${PIXI_PROJECT_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
EMACS="$CONDA_PREFIX/bin/emacs"
GRAMMAR_DIR="$ROOT/.doomemacs/.local/etc/tree-sitter"

mkdir -p "$GRAMMAR_DIR"

install_grammar() {
  local lang="$1" url="$2"
  if [ -f "$GRAMMAR_DIR/libtree-sitter-$lang.dylib" ] || \
     [ -f "$GRAMMAR_DIR/libtree-sitter-$lang.so" ]; then
    echo "tree-sitter grammar '$lang' already installed"
    return
  fi
  echo "Installing tree-sitter grammar '$lang' from $url..."
  "$EMACS" --batch \
    --eval "(require 'treesit)" \
    --eval "(add-to-list 'treesit-extra-load-path \"$GRAMMAR_DIR/\")" \
    --eval "(setq treesit-language-source-alist '(($lang \"$url\")))" \
    --eval "(treesit-install-language-grammar '$lang \"$GRAMMAR_DIR\")" \
    --eval "(unless (treesit-language-available-p '$lang) (error \"grammar '$lang' failed to load after install\"))"
  echo "tree-sitter grammar '$lang' installed (ABI-compatible)"
}

# lang -> grammar source (pinned to ABI <=14 for libtree-sitter 0.23)
install_grammar yaml "https://github.com/ikatyang/tree-sitter-yaml"

echo "tree-sitter grammars ready."
