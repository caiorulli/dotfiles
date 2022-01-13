;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Directories

(setq org-directory "~/Org")
(setq projectile-project-search-path '("~/Code/"))

;; Paredit

(use-package! paredit
  :hook ((emacs-lisp-mode
          clojure-mode
          scheme-mode
          lisp-mode) . paredit-mode))

;; Clojure

(after! clojure-mode
  ;; Midje
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'flow 1)
  (put-clojure-indent 'provided 0)

  ;; Morse
  (put-clojure-indent 'command-fn 1)
  (put-clojure-indent 'message-fn 1))

(after! cider
  (set-popup-rules!
    '(("^\\*cider-repl" :ignore t))))

;; UI config

(setq doom-theme 'doom-one
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

;; Email

(after! mu4e
  (setq mu4e-get-mail-command "mbsync -c $MBSYNC_CONFIG -a"
        +mu4e-gmail-accounts '(("caiorulli@gmail.com" . "/gmail")))

  (set-email-account! "mailbox"
    '((mu4e-sent-folder       . "/mailbox/Sent")
      (mu4e-drafts-folder     . "/mailbox/Drafts")
      (mu4e-trash-folder      . "/mailbox/Trash")
      (user-mail-address      . "caio@crthomaz.com.br")
      (smtpmail-smtp-user     . "caio@crthomaz.com.br"))
    t)

  (set-email-account! "gmail"
    '((user-mail-address      . "caiorulli@gmail.com")
      (smtpmail-smtp-user     . "caiorulli@gmail.com"))
    t))
