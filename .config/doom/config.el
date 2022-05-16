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
  ;; Midje
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'flow 1)
  (put-clojure-indent 'provided 0)

  ;; Morse
  (put-clojure-indent 'command-fn 1)
  (put-clojure-indent 'message-fn 1)

  ;; Cats
  (put-clojure-indent 'mlet :defn))

(after! cider
  (set-popup-rules!
    '(("^\\*cider-repl" :ignore t))))


;; Java
(setq lsp-java-java-path (concat (getenv "SDKMAN_DIR") "/candidates/java/11.0.2-open/bin/java")
      lsp-java-autobuild-enabled nil)

(after! lsp-java
  (push (concat "-javaagent:" doom-private-dir "lombok.jar") lsp-java-vmargs))

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
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
