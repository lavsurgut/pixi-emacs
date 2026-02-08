;;; init.el -*- lexical-binding: t; -*-
;; Doom modules — uncomment what you need.
;; Run `pixi run doom-sync` after changes.

(doom! :input

       :completion
       (corfu +icons +orderless)
       (vertico +icons)

       :ui
       doom
       doom-dashboard
       hl-todo
       modeline
       ophints
       (vc-gutter +pretty)
       vi-tilde-fringe

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       snippets

       :emacs
       (dired +dirvish +icons)
       electric
       undo
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       direnv
       (eval +overlay)
       lookup
       lsp
       magit
       tree-sitter

       :os
       (tty +osc)

       :lang
       (clojure +lsp +tree-sitter)
       emacs-lisp
       (go +lsp +tree-sitter)
       json
       markdown
       (org +pretty)
       (python +lsp +tree-sitter)
       rest
       (rust +lsp +tree-sitter)
       sh
       (yaml +lsp +tree-sitter)

       :config
       (default +bindings +smartparens))
