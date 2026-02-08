;;; init.el -*- lexical-binding: t; -*-
;; Doom modules — uncomment what you need.
;; Run `pixi run doom-sync` after changes.

(doom! :input

       :completion
       (company +childframe)
       (vertico +icons)

       :ui
       doom
       doom-dashboard
       hl-todo
       modeline
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       vi-tilde-fringe
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       snippets
       word-wrap

       :emacs
       (dired +icons)
       electric
       (undo +tree)
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       (eval +overlay)
       lookup
       magit
       tree-sitter

       :lang
       emacs-lisp
       json
       markdown
       (org +pretty)
       (python +lsp +tree-sitter)
       rest
       (rust +lsp +tree-sitter)
       sh
       yaml

       :config
       (default +bindings +smartparens))
