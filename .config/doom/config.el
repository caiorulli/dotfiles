;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq org-directory "~/Documents/org")

;; Clojure
(after! clojure-mode
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'flow 1)
  (put-clojure-indent 'provided 0))

;; UI config
(setq doom-theme 'doom-nord)
(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 15))

;; Setting transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(setq doom-themes-treemacs-enable-variable-pitch nil)

(setq confirm-kill-processes nil)

(after! emms
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Music/"))

(map! :leader
      :desc "elfeed" "a f" #'elfeed
      :desc "emms" "a m" #'emms)
