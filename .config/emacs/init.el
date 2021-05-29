;;; package --- Summary
;;; Commentary:

;; My Emacs config!

;;; Code:

;; Straight

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

;; General packages

(use-package general
  :config
  (general-evil-setup)
  (general-create-definer leader-def
    :keymaps 'override
    :states 'normal
    :prefix "SPC")

  (general-create-definer local-leader-def
    :states 'normal
    :prefix "SPC m")

  (leader-def
    "f s" 'save-buffer
    "q q" 'save-buffers-kill-emacs
    "w" 'evil-window-map
    "h" 'help-command))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package better-defaults)

(use-package ivy
  :general
  (leader-def
    "b b" 'ivy-switch-buffer
    "b k" 'kill-buffer)
  :config
  (ivy-mode 1))

(use-package counsel
  :general
  (leader-def
    "." 'counsel-find-file)
  :config
  (counsel-mode 1))

(use-package swiper
  :general
  (leader-def
    "s b" 'swiper))

(use-package amx)

(use-package ripgrep)

(use-package projectile
  :general
  (leader-def
    "p" 'projectile-command-map)
  
  :config
  (setq projectile-completion-system 'ivy
        projectile-project-search-path '("~/Code/"))
  (projectile-mode 1))

(use-package counsel-projectile
  :after counsel projectile
  :general
  (leader-def
    "SPC" 'counsel-projectile-find-file
    "s p" 'counsel-projectile-rg)

  :config
  (counsel-projectile-mode 1))

(use-package company
  :config
  (global-company-mode))

(use-package flycheck)

(use-package magit
  :general
  (leader-def
    "g" 'magit-status))

(use-package diff-hl
  :config
  (global-diff-hl-mode))

(use-package treemacs
  :general
  (leader-def 
    "-" 'treemacs))

(use-package markdown-mode)

;; LSP

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :commands lsp)

(use-package lsp-ui
  :after lsp
  :commands lsp-ui-mode)

(use-package lsp-ivy
  :after lsp ivy
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :after lsp treemacs
  :commands lsp-treemacs-errors-list)

;; Evil

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

(use-package treemacs-evil
  :after treemacs evil)

;; Haskell

(use-package haskell-mode)

(use-package lsp-haskell
  :init
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode #'lsp))

;; Lisp

(use-package paredit
  :hook ((emacs-lisp-mode
          clojure-mode
          scheme-mode
          lisp-mode) . paredit-mode))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Clojure

(use-package clojure-mode)

(use-package cider)

(use-package clj-refactor)

(use-package flycheck-clj-kondo)

;; Scheme

(use-package scheme
  :hook (scheme-mode . rainbow-delimiters-mode))

(use-package geiser
  :after scheme
  :init
  (setq geiser-active-implementations '(chicken))
  :general
  (local-leader-def
    :keymaps 'scheme-mode-map
    "'" 'run-geiser))

(use-package geiser-mit
  :after geiser)

(use-package geiser-chicken
  :after geiser
  :config
  (setq geiser-chicken-binary "chicken-csi"))

;; Javascript

(use-package tide
  :after js-mode company flycheck
  :hook ((js-mode . tide-setup)
         (js-mode . tide-hl-identifier-mode)))

;; UI

(use-package nord-theme
  :config
  (load-theme 'nord t))

;; Setting transparency
(set-frame-parameter (selected-frame) 'alpha '(85 75))
(add-to-list 'default-frame-alist '(alpha 85 75))

(set-face-attribute 'default nil :font "Fantasque Sans Mono" :height 120)

(global-linum-mode t)
(setq inhibit-splash-screen t
      visible-bell nil)

(provide 'init)
;;; init.el ends here
