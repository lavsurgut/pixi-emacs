;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name ""
      user-mail-address "")

;; Theme — pick one you like
(setq doom-theme 'doom-one)

;; Terminal-friendly settings
(unless (display-graphic-p)
  (setq doom-theme 'doom-one)) ; doom-one works well in 256-color terminals
