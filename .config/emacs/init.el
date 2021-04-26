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

(use-package which-key
  :config
  (which-key-mode 1))

(use-package better-defaults)

(use-package ivy
  :config
  (ivy-mode 1))

(use-package counsel
  :config
  (counsel-mode 1))

(use-package swiper)

(use-package amx)

(use-package ripgrep)

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'ivy
        projectile-project-search-path '("~/Code/"))
  (projectile-mode 1))

(use-package counsel-projectile
  :after counsel projectile
  :config
  (counsel-projectile-mode 1))

(use-package company
  :config
  (global-company-mode))

(use-package flycheck)

(use-package magit)

(use-package diff-hl
  :config
  (global-diff-hl-mode))

(use-package treemacs
  :config
  (define-key global-map (kbd "C-c -") #'treemacs))

(use-package markdown-mode)

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
  (setq geiser-active-implementations '(mit chicken)))

;; Haskell

(use-package haskell-mode)

(use-package dante
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode))

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
