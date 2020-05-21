;;; package --- Summary
;;; Commentary:

;; My Emacs config!

;;; Code:

(defvar straight-use-package-by-default t)

(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package which-key)

(use-package better-defaults)

(use-package ivy
  :config
  (ivy-mode 1))

(use-package counsel
  :config
  (counsel-mode 1))

(use-package amx)

(use-package projectile)

(use-package company)

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package magit)

(use-package treemacs)

(use-package evil
  :init
  (defvar evil-want-C-u-scroll t)
  (defvar evil-want-integration t)
  (defvar evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package parinfer
  :init
  (progn
    (defvar parinfer-extensions '(defaults evil))
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)))

(use-package clojure-mode)

(use-package cider)

(use-package clj-refactor)

(use-package flycheck-joker)

(use-package lsp-mode)

(use-package rust-mode)

(use-package nord-theme
  :config
  (load-theme 'nord t))

;; Setting transparency
(set-frame-parameter (selected-frame) 'alpha '(90 80))
(add-to-list 'default-frame-alist '(alpha 90 80))

(set-face-attribute 'default nil :font "Fantasque Sans Mono" :height 120)

(provide 'init)
;;; init.el ends here
