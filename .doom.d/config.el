;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name ""
      user-mail-address "")

;; Theme
(setq doom-theme 'doom-one)

;; Line numbers
(setq display-line-numbers-type t)

;; Don't prompt before exiting
(setq confirm-kill-emacs nil)

;; Don't prompt the first time we start vterm
(setq vterm-always-compile-module t)

;; Fix fish problems with emacs
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; Localleader on , instead of SPC-m
(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "M-,")

;; --- Evil / navigation ---

;; Swap gj with j (visual lines by default)
(define-key evil-motion-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "gj") 'evil-next-line)
(define-key evil-motion-state-map (kbd "gk") 'evil-previous-line)

;; Dired jump with -
(map!
 (:map 'override
  :n "-" #'dired-jump))

;; Avy on s
(setq avy-all-windows t)
(map! :map evil-snipe-local-mode-map :nv "s" #'evil-avy-goto-char-timer)

;; Expand region in visual mode
(map!
 (:map 'override
  :v "v" #'er/expand-region
  :v "V" #'er/contract-region))

;; Window navigation with super
(map! :map 'override "s-h" #'evil-window-left)
(map! :map 'override "s-j" #'evil-window-down)
(map! :map 'override "s-k" #'evil-window-up)
(map! :map 'override "s-l" #'evil-window-right)

;; --- Smartparens / evil-cleverparens ---

(after! smartparens
  (add-hook 'prog-mode-hook #'smartparens-strict-mode)
  (add-hook 'prog-mode-hook #'evil-cleverparens-mode)
  (setq evil-move-beyond-eol t))

(setq evil-cleverparens-use-s-and-S nil)
(defvar evil-cp-additional-movement-keys
  '(("L"   . evil-cp-forward-sexp)
    ("H"   . evil-cp-backward-sexp)
    ("M-H" . evil-cp-beginning-of-defun)
    ("M-h" . (lambda () (interactive) (evil-cp-beginning-of-defun -1)))
    ("M-l" . evil-cp-end-of-defun)
    ("M-L" . (lambda () (interactive) (evil-cp-end-of-defun -1)))
    ("["   . evil-cp-previous-opening)
    ("]"   . evil-cp-next-closing)
    ("{"   . evil-cp-next-opening)
    ("}"   . evil-cp-previous-closing)
    ("("   . evil-cp-backward-up-sexp)
    (")"   . evil-cp-up-sexp)))

;; Swap evil-cp-next-opening with evil-cp-previous-opening
(define-key (current-global-map) [remap evil-cp-next-opening] 'evil-cp-previous-opening)
(define-key (current-global-map) [remap evil-cp-previous-opening] 'evil-cp-next-opening)

;; Key translations for evil-cp
(define-key key-translation-map (kbd "M-S-[") (kbd "M-{"))
(define-key key-translation-map (kbd "M-S-]") (kbd "M-}"))
(define-key key-translation-map (kbd "M-S-9") (kbd "M-("))
(define-key key-translation-map (kbd "M-S-0") (kbd "M-)"))
(define-key key-translation-map (kbd "M-S-j") (kbd "M-J"))
(define-key key-translation-map (kbd "M-S-s") (kbd "M-S"))
(define-key key-translation-map (kbd "M-S-r") (kbd "M-R"))
(define-key key-translation-map (kbd "M-S-l") (kbd "M-L"))
(define-key key-translation-map (kbd "M-S-h") (kbd "M-H"))

(map!
 (:map 'override
  :n "M-5" #'evil-cp-wrap-next-square
  :n "M-]" #'evil-cp-wrap-previous-square))

;; --- Dired ---

(map! :map dired-mode-map
      :n "h" #'dired-up-directory
      :n "l" #'dired-find-file)

(setq dired-kill-when-opening-new-dired-buffer t)

;; --- Clojure / CIDER ---

(setq cider-save-file-on-load t)
(setq cider-ns-refresh-show-log-buffer t)
(setq cider-ns-save-files-on-refresh t)
(setq cider-inspector-pretty-print t)
(map! :map cider-inspector-mode-map
      :n "d" #'cider-inspector-def-current-val
      :n "y" #'cider-inspector-display-analytics
      :n "v" #'cider-inspector-toggle-view-mode
      :n "p" #'cider-inspector-toggle-pretty-print)

(setq clojure-toplevel-inside-comment-form t)
(setq clojure-ts-toplevel-inside-comment-form t)

;; Format on save via LSP for Clojure
(add-hook 'clojure-mode-hook #'+format-with-lsp-mode)
(add-hook 'clojure-ts-mode-hook #'+format-with-lsp-mode)

;; Safe .dir-locals.el values for Clojure projects
(setq safe-local-variable-values
      '((cider-ns-refresh-after-fn . "dev/go!")
        (cider-ns-refresh-after-fn . "dev/start!")
        (cider-ns-refresh-before-fn . "dev/stop!")
        (cider-preferred-build-tool . clojure-cli)
        (cider-clojure-cli-aliases . ":dev")
        (cider-clojure-cli-aliases . ":dev:cider")
        (cider-default-cljs-repl . shadow)
        (cider-shadow-default-options . ":app")
        (cider-ns-refresh-before-fn . "user/stop!")
        (cider-ns-refresh-after-fn . "user/start!")))

;; --- LSP ---

(setq lsp-auto-guess-root t)

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.clj-kondo\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.cpcache\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.direnv\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.lsp\\'"))

(setq lsp-disabled-clients '(copilot-ls semgrep-ls))

;; --- Corfu ---

(after! corfu
  (setq corfu-preview-current nil)
  (setq corfu-quit-at-boundary nil)
  (setq corfu-preselect 'valid)
  (custom-set-faces!
    '(corfu-current :background "#000000")))

;; --- Consult preview ---

(after! consult
  (consult-customize
   consult-recent-file
   +default/search-project
   :preview-key 'any)
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key "s-<return>")
  (when (modulep! :config default)
    (consult-customize
     +default/search-other-project
     +default/search-project-for-symbol-at-point
     +default/search-cwd +default/search-other-cwd
     +default/search-notes-for-symbol-at-point
     +default/search-emacsd
     :preview-key "s-<return>")))

;; --- Rainbow delimiters ---

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; --- Evil snipe ---

(setq evil-snipe-scope 'whole-visible)

;; --- Zellij tab renaming ---

(defvar my-update-tabname-timer (current-time))

(defun my-do-update-tabname ()
  (let* ((zellij (getenv "ZELLIJ_SESSION_NAME"))
         (home (getenv "HOME"))
         (root (or (projectile-project-root)
                   default-directory))
         (root (if (string= root "/") "root" root))
         (root (if (string= root (format "%s/" home)) "~" root))
         (root (replace-regexp-in-string (format "%s/" home) "" root))
         (xs (split-string root "/"))
         (xs (seq-filter (lambda (s) (not (string-empty-p s))) xs))
         (tab-name (string-join xs "/"))
         (cmd (format "zellij action rename-tab \"%s\"" tab-name)))
    (when zellij
      (start-process-shell-command "update-tab-name" "*update-tab-name*" cmd))))

(defun my-update-tabname ()
  (interactive)
  (let* ((t1 (current-time))
         (t2 my-update-tabname-timer)
         (delta 0.1))
    (when (> (abs (float-time (time-subtract t1 t2))) delta)
      (setq my-update-tabname-timer (current-time))
      (my-do-update-tabname))))

(add-hook 'doom-switch-buffer-hook #'my-update-tabname)
(add-hook 'doom-switch-window-hook #'my-update-tabname)

;; --- Clipetty / OSC 52 ---

;; Clipetty doesn't know about Zellij, so when SSH_TTY is set it writes
;; directly to the (potentially stale) SSH PTY device, causing
;; "Permission denied" errors on /dev/pts/X after reconnect.
;; Zellij handles OSC 52 passthrough itself, so write to the local terminal.
(after! clipetty
  (defadvice! +tty--clipetty-tty-zellij-a (orig-fn ssh-tty tmux)
    :around #'clipetty--tty
    (if (getenv "ZELLIJ_SESSION_NAME")
        (terminal-name)
      (funcall orig-fn ssh-tty tmux))))

;; --- Vterm ---

(after! vterm
  (setq vterm-clear-scrollback-when-clearing t)
  (setq vterm-buffer-name-string "vterm %s"))

;; --- Magit ---

(setq magit-ediff-dwim-show-on-hunks t)
(setq magit-published-branches nil)
