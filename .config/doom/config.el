;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Directories
(setq org-directory "~/Org")
(setq projectile-project-search-path '("~/Code/"))

;; Paredit

(use-package! paredit
  :hook ((emacs-lisp-mode
          clojure-mode
          scheme-mode
          lisp-mode) . paredit-mode)
  :config
  (map!
   (:leader
    ">" #'paredit-forward-slurp-sexp
    "<" #'paredit-backward-slurp-sexp
    "M->" #'paredit-forward-barf-sexp
    "M-<" #'paredit-backward-barf-sexp)))

;; Clojure

(after! projectile
  (pushnew! projectile-project-root-files "project.clj" "deps.edn"))

;; Large clojure buffers tend to be slower than large buffers of other modes, so
;; it should have a lower threshold too.
(add-to-list 'doom-large-file-size-alist '("\\.\\(?:clj[sc]?\\|edn\\)\\'" . 0.5))

(use-package! clojure-mode
  :hook (clojure-mode . rainbow-delimiters-mode)
  :config
  ;; Midje
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'flow 1)
  (put-clojure-indent 'provided 0)

  ;; Morse
  (put-clojure-indent 'command-fn 1)
  (put-clojure-indent 'message-fn 1))

(use-package! cider
  :hook (clojure-mode-local-vars . cider-mode)
  :init
  (after! clojure-mode
    (set-repl-handler! 'clojure-mode #'+clojure/open-repl :persist t)
    (set-repl-handler! 'clojurescript-mode #'+clojure/open-cljs-repl :persist t)
    (set-eval-handler! '(clojure-mode clojurescript-mode) #'cider-eval-region))
  :config
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (set-lookup-handlers! '(cider-mode cider-repl-mode)
    :definition #'+clojure-cider-lookup-definition
    :documentation #'cider-doc)
  (set-popup-rules!
    '(("^\\*cider-error*" :ignore t)
      ("^\\*cider-repl" :quit nil)
      ("^\\*cider-repl-history" :vslot 2 :ttl nil)))

  (setq nrepl-hide-special-buffers nil
        cider-font-lock-dynamically '(macro core function var deprecated)
        cider-print-options '(("length" 100))
        cider-repl-history-display-duplicates nil
        cider-repl-history-display-style 'one-line
        cider-repl-history-file (concat doom-cache-dir "cider-repl-history")
        cider-repl-history-highlight-current-entry t
        cider-repl-history-quit-action 'delete-and-restore
        cider-repl-history-highlight-inserted-item t
        cider-repl-history-size 1000
        cider-repl-result-prefix ";; => "
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-repl-display-help-banner nil
        cider-clojure-cli-aliases "dev")

  ;; When in cider-debug-mode, override evil keys to not interfere with debug keys
  (after! evil
    (add-hook! cider--debug-mode
      (defun +clojure--cider-setup-debug ()
        "Setup cider debug to override evil keys cleanly"
        (evil-make-overriding-map cider--debug-mode-map 'normal)
        (evil-normalize-keymaps))))

  (map!
   (:localleader
    (:map (clojure-mode-map clojurescript-mode-map)
     "'"  #'cider-jack-in-clj
     "t"  #'cider-test-run-ns-tests
     "n"  #'cider-repl-set-ns))

   (:map cider-repl-mode-map
    :i [S-return] #'cider-repl-newline-and-indent
    :i [M-return] #'cider-repl-return
    (:localleader
     "n" #'cider-repl-set-ns
     "q" #'cider-quit
     "r" #'cider-ns-refresh
     "R" #'cider-restart
     "c" #'cider-repl-clear-buffer)
    :map cider-repl-history-mode-map
    :i [return]  #'cider-repl-history-insert-and-quit
    :i "q"  #'cider-repl-history-quit
    :i "l"  #'cider-repl-history-occur
    :i "s"  #'cider-repl-history-search-forward
    :i "r"  #'cider-repl-history-search-backward
    :i "U"  #'cider-repl-history-undo-other-window)))

(use-package! clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (set-lookup-handlers! 'clj-refactor-mode
    :references #'cljr-find-usages)
  (map! :map clojure-mode-map
        :localleader
        :desc "refactor" "R" #'hydra-cljr-help-menu/body))

(use-package! flycheck-clj-kondo
  :after flycheck)

;; Scheme

(use-package! scheme
  :hook (scheme-mode . rainbow-delimiters-mode)
  :config (advice-add #'scheme-indent-function :override #'+scheme-scheme-indent-function-a))

(use-package! geiser
  :defer t
  :init
  (setq geiser-active-implementations '(guile chicken mit chibi chez)
        geiser-autodoc-identifier-format "%s → %s"
        geiser-repl-current-project-function 'doom-project-root)
  (after! scheme                        ; built-in
    (set-repl-handler! 'scheme-mode #'+scheme/open-repl)
    (set-eval-handler! 'scheme-mode #'geiser-eval-region)
    (set-lookup-handlers! '(scheme-mode geiser-repl-mode)
      :definition #'geiser-edit-symbol-at-point
      :documentation #'geiser-doc-symbol-at-point))
  :config
  (set-popup-rules!
    '(("^\\*geiser messages\\*$" :slot 1 :vslot -1)
      ("^\\*Geiser dbg\\*$"      :slot 1 :vslot -1)
      ("^\\*Geiser xref\\*$"     :slot 1 :vslot -1)
      ("^\\*Geiser documentation\\*$" :slot 2 :vslot 2 :select t :size 0.35)
      ("^\\* [A-Za-z0-9_-]+ REPL \\*" :size 0.3 :quit nil :ttl nil)))
  (map! :localleader
        :map scheme-mode-map
        "'"  #'geiser-mode-switch-to-repl
        "\"" #'geiser-connect
        "["  #'geiser-squarify
        "\\" #'geiser-insert-lambda
        "s"  #'geiser-set-scheme))

;; Rust

(after! rustic
  (setq rustic-lsp-server 'rls))

;; Java

(setq lsp-java-autobuild-enabled nil)
(after! lsp-java
  (push "-javaagent:/home/caio/.config/doom/lombok.jar" lsp-java-vmargs))

;; UI config

(setq doom-theme 'doom-nord
      doom-font (font-spec :family "Fantasque Sans Mono" :size 15)
      doom-themes-treemacs-enable-variable-pitch nil
      confirm-kill-processes nil)

;; Transparency

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
