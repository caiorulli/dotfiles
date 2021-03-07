;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Directories
(setq org-directory "~/Documents/org")
(setq projectile-project-search-path '("~/Code/"))

;; Parinfer

(use-package! parinfer
  :hook ((emacs-lisp-mode
          clojure-mode
          lisp-mode) . parinfer-mode)
  :init
  (setq parinfer-extensions
        '(defaults
           pretty-parens
           smart-tab
           smart-yank))
  (push 'evil parinfer-extensions)
  :config
  (map! :map parinfer-mode-map
        "\"" nil  ; smartparens handles this
        :i "<tab>"     #'parinfer-smart-tab:dwim-right-or-complete
        :i "<backtab>" #'parinfer-smart-tab:dwim-left
        :localleader
        :desc "Toggle parinfer-mode" "m" #'parinfer-toggle-mode))

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
      ("^\\*cider-repl" :ignore nil)
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

  ;; Error messages emitted from CIDER is silently funneled into *nrepl-server*
  ;; rather than the *cider-repl* buffer. How silly. We might want to see that
  ;; stuff and who's going to check *nrepl-server* on every startup? I've got a
  ;; better idea: we copy these errors into the *cider-repl* buffer.
  ;; (add-hook! 'cider-connected-hook
  ;;   (defun +clojure--cider-dump-nrepl-server-log-h ()
  ;;     "Copy contents of *nrepl-server* to beginning of *cider-repl*."
  ;;     (when (buffer-live-p nrepl-server-buffer)
  ;;       (save-excursion
  ;;         (goto-char (point-min))
  ;;         (insert
  ;;          (with-current-buffer nrepl-server-buffer
  ;;            (buffer-string)))))))


  ;; When in cider-debug-mode, override evil keys to not interfere with debug keys
  (after! evil
    (add-hook! cider--debug-mode
      (defun +clojure--cider-setup-debug ()
        "Setup cider debug to override evil keys cleanly"
        (evil-make-overriding-map cider--debug-mode-map 'normal)
        (evil-normalize-keymaps))))

  (map! (:localleader
         (:map (clojure-mode-map clojurescript-mode-map)
          "'"  #'cider-jack-in-clj
          "\"" #'cider-jack-in-cljs
          "c"  #'cider-connect-clj
          "C"  #'cider-connect-cljs
          "m"  #'cider-macroexpand-1
          "M"  #'cider-macroexpand-all
          (:prefix ("d" . "debug")
           "d" #'cider-debug-defun-at-point)
          (:prefix ("e" . "eval")
           "b" #'cider-eval-buffer
           "d" #'cider-eval-defun-at-point
           "D" #'cider-insert-defun-in-repl
           "e" #'cider-eval-last-sexp
           "E" #'cider-insert-last-sexp-in-repl
           "r" #'cider-eval-region
           "R" #'cider-insert-region-in-repl
           "u" #'cider-undef)
          (:prefix ("g" . "goto")
           "b" #'cider-pop-back
           "g" #'cider-find-var
           "n" #'cider-find-ns)
          (:prefix ("h" . "help")
           "n" #'cider-find-ns
           "a" #'cider-apropos
           "c" #'cider-clojuredocs
           "d" #'cider-doc
           "j" #'cider-javadoc
           "w" #'cider-clojuredocs-web)
          (:prefix ("i" . "inspect")
           "e" #'cider-enlighten-mode
           "i" #'cider-inspect
           "r" #'cider-inspect-last-result)
          (:prefix ("n" . "namespace")
           "n" #'cider-browse-ns
           "N" #'cider-browse-ns-all
           "r" #'cider-ns-refresh)
          (:prefix ("p" . "print")
           "p" #'cider-pprint-eval-last-sexp
           "P" #'cider-pprint-eval-last-sexp-to-comment
           "d" #'cider-pprint-eval-defun-at-point
           "D" #'cider-pprint-eval-defun-to-comment
           "r" #'cider-pprint-eval-last-sexp-to-repl)
          (:prefix ("r" . "repl")
           "n" #'cider-repl-set-ns
           "q" #'cider-quit
           "r" #'cider-ns-refresh
           "R" #'cider-restart
           "b" #'cider-switch-to-repl-buffer
           "B" #'+clojure/cider-switch-to-repl-buffer-and-switch-ns
           "c" #'cider-find-and-clear-repl-output
           "l" #'cider-load-buffer
           "L" #'cider-load-buffer-and-switch-to-repl-buffer)
          (:prefix ("t" . "test")
           "a" #'cider-test-rerun-test
           "l" #'cider-test-run-loaded-tests
           "n" #'cider-test-run-ns-tests
           "p" #'cider-test-run-project-tests
           "r" #'cider-test-rerun-failed-tests
           "s" #'cider-test-run-ns-tests-with-filters
           "t" #'cider-test-run-test)))

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

(map! :leader
      (:prefix ("a" . "applications")
       :desc "elfeed" "f" #'elfeed
       :desc "emms" "m" #'emms))

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
