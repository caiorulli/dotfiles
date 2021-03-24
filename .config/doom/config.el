;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Directories

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

(use-package! treemacs
  :init
  (setq treemacs-persist-file (concat doom-cache-dir "treemacs-persist")
        treemacs-last-error-persist-file (concat doom-cache-dir "treemacs-last-error-persist"))
  :config
  (map!
   (:leader
    "-" #'treemacs)))

(use-package! treemacs-evil
  :after treemacs)

(use-package! treemacs-projectile
  :after treemacs)

(use-package! treemacs-magit
  :after treemacs magit)

(use-package! treemacs-persp
  :after treemacs
  :config (treemacs-set-scope-type 'Perspectives))

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
  :hook (scheme-mode . rainbow-delimiters-mode))

(use-package! geiser
  :after scheme
  :init
  (setq geiser-active-implementations '(mit))
  :config
  (map! :localleader
        :map scheme-mode-map
        "'"  #'run-geiser
        "["  #'geiser-squarify
        "\\" #'geiser-insert-lambda
        "s"  #'geiser-set-scheme))

;; Haskell

(use-package! haskell-mode)

(use-package! dante
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode))

;; Javascript

(use-package! tide
  :after js-mode company flycheck
  :hook ((js-mode . tide-setup)
         (js-mode . tide-hl-identifier-mode))
  :config
  (map! :localleader
        :map tide-mode-map
        "f" #'tide-format))

;; Rust

(after! rustic
  (setq rustic-lsp-server 'rls))

;; Java

(setq lsp-java-autobuild-enabled nil)
(after! lsp-java
  (push "-javaagent:/home/caio/.config/doom/lombok.jar" lsp-java-vmargs))

;; Org

(use-package! org
  :config
  (setq org-directory "~/Org"))

(use-package! evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar)))

;; UI config

(setq doom-theme 'doom-one
      doom-font (font-spec :family "Fantasque Sans Mono" :size 15)
      confirm-kill-processes nil)

;; Transparency

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
