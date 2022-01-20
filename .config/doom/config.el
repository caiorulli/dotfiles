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

(when IS-MAC
  (add-to-list 'load-path "/usr/local/Cellar/mu/1.6.10/share/emacs/site-lisp/mu/mu4e"))

(after! mu4e
  (setq mu4e-get-mail-command "mbsync -c $MBSYNC_CONFIG -a")

  (when IS-LINUX
    (setq +mu4e-gmail-accounts '(("caiorulli@gmail.com" . "/gmail")))

    (set-email-account! "mailbox"
                        '((mu4e-sent-folder       . "/mailbox/Sent")
                          (mu4e-drafts-folder     . "/mailbox/Drafts")
                          (mu4e-trash-folder      . "/mailbox/Trash")
                          (user-mail-address      . "caio@crthomaz.com.br")
                          (smtpmail-smtp-user     . "caio@crthomaz.com.br"))
                        t)

    (set-email-account! "gmail"
                        '((mu4e-sent-folder       . "/gmail/[Gmail]/Sent Mail")
                          (mu4e-drafts-folder     . "/gmail/[Gmail]/Drafts")
                          (mu4e-trash-folder      . "/gmail/[Gmail]/Trash")
                          (user-mail-address      . "caiorulli@gmail.com")
                          (smtpmail-smtp-user     . "caiorulli@gmail.com"))
                        t))

  (when IS-MAC
    (setq +mu4e-gmail-accounts '(("caio.rulli@quintoandar.com.br" . "/gmail")))

    (set-email-account! "gmail"
                        '((mu4e-sent-folder       . "/gmail/[Gmail]/Sent Mail")
                          (mu4e-drafts-folder     . "/gmail/[Gmail]/Drafts")
                          (mu4e-trash-folder      . "/gmail/[Gmail]/Trash")
                          (user-mail-address      . "caio.rulli@quintoandar.com.br")
                          (smtpmail-smtp-user     . "caio.rulli@quintoandar.com.br"))
                        t)))

;; Spotify

(map! :leader :prefix "t" :desc "Spotify" "s" #'global-smudge-remote-mode)

(use-package! smudge
  :init
  (setq smudge-oauth2-client-id "4d23f6619825421f85533eebe615fffd"
        smudge-oauth2-client-secret (shell-command "pass spotify/smudge")
        smudge-transport 'connect)

  :config
  ;; A hydra for controlling spotify.
  (defhydra hydra-spotify (:hint nil)
    "
^Search^                  ^Control^               ^Manage^
^^^^^^^^-----------------------------------------------------------------
_t_: Track               _SPC_: Play/Pause        _+_: Volume up
_m_: My Playlists        _n_  : Next Track        _-_: Volume down
_f_: Featured Playlists  _p_  : Previous Track    _x_: Mute
_u_: User Playlists      _r_  : Repeat            _d_: Device
^^                       _s_  : Shuffle           _q_: Quit
"
    ("t" smudge-track-search :exit t)
    ("m" smudge-my-playlists :exit t)
    ("f" smudge-featured-playlists :exit t)
    ("u" smudge-user-playlists :exit t)
    ("SPC" smudge-controller-toggle-play :exit nil)
    ("n" smudge-controller-next-track :exit nil)
    ("p" smudge-controller-previous-track :exit nil)
    ("r" smudge-controller-toggle-repeat :exit nil)
    ("s" smudge-controller-toggle-shuffle :exit nil)
    ("+" smudge-controller-volume-up :exit nil)
    ("-" smudge-controller-volume-down :exit nil)
    ("x" smudge-controller-volume-mute-unmute :exit nil)
    ("d" smudge-select-device :exit nil)
    ("q" quit-window "quit" :color blue))

  (map! :leader :prefix "o" :desc "Spotify" "s" #'hydra-spotify/body))
