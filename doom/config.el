;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Directories

(setq org-directory "~/Org")

(setq projectile-project-search-path '("~/Code/"))

(after! projectile
  (setq projectile-project-root-files-bottom-up '(".projectile" ".git")))

;; Paredit

(use-package! paredit
  :hook ((emacs-lisp-mode
          clojure-mode
          scheme-mode
          lisp-mode) . paredit-mode))

;; Treemacs

(after! treemacs
  (setq treemacs-collapse-dirs 10))

;; Clojure

(set-formatter! 'cljstyle "cljstyle pipe" :modes '(clojure-mode))

(after! clojure-mode
  ;; test.check
  (put-clojure-indent 'for-all 1))

(after! cider
  (set-popup-rules!
    '(("^\\*cider-repl" :ignore t)
      ("^\\*cider-test-report" :ignore t)))
  (setq cider-clojure-cli-aliases ":dev"
        cider-shadow-cljs-command "yarn shadow-dev"))

;; Java
(setq lsp-java-autobuild-enabled nil)

;; UI config

(setq doom-theme 'doom-one
      doom-font (font-spec :family "Fantasque Sans Mono" :size 15)
      doom-themes-treemacs-enable-variable-pitch nil
      confirm-kill-processes nil)

;; Transparency

(when IS-LINUX
  (progn
    (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
    (add-to-list 'default-frame-alist '(alpha . (90 . 90)))))

(defun transparency (value)
  "Set VALUE as the transparency of the frame window. 0=transparent/100=opaque."
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
