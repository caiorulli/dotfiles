;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Directories
(setq org-directory "~/Documents/org")
(setq projectile-project-search-path '("~/Code/"
                                       "~/Code/oss/"
                                       "~/Code/suckless"))

;; Clojure
(after! clojure-mode
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'flow 1)
  (put-clojure-indent 'provided 0))

;; Rust
(after! rustic
  (setq rustic-lsp-server 'rls))

;; Java
(setq lsp-java-autobuild-enabled nil)
(after! lsp-java
  (push "-javaagent:/home/caio/.config/doom/lombok.jar" lsp-java-vmargs))

;; UI config
(setq doom-theme 'doom-nord)
(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 15))
(setq doom-themes-treemacs-enable-variable-pitch nil)

(setq confirm-kill-processes nil)

(after! emms
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Music/"))

;; Email
(setq +mu4e-mu4e-maildir "~/Mail")
(set-email-account! "mailbox"
  '((mu4e-sent-folder       . "/Sent")
    (mu4e-drafts-folder     . "/Drafts")
    (mu4e-trash-folder      . "/Trash")
    (mu4e-compose-signature . "Caio Thomaz")
    (mu4e-get-mail-command  . "mbsync -c ~/.config/isync/mbsyncrc -a")
    (user-mail-address      . "caio@crthomaz.com.br")
    (smtpmail-smtp-user     . "caio@crthomaz.com.br")
    (smtpmail-smtp-server   . "smtp.mailbox.org")
    (smtpmail-smtp-service  . 587)))

(map! :leader
      :desc "elfeed" "a f" #'elfeed
      :desc "emms" "a m" #'emms)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
