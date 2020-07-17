;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Clojure
(after! clojure-mode
  (put-clojure-indent 'fact 1)
  (put-clojure-indent 'facts 1)
  (put-clojure-indent 'flow 1)
  (put-clojure-indent 'provided 0))

;; RSS
(setq elfeed-feeds
      '("https://this-week-in-rust.org/rss.xml"
        "https://www.archlinux.org/feeds/news/"
        "http://blog.cleancoder.com/atom.xml"
        "https://lukesmith.xyz/rss.xml"
        "https://dev.to/feed/teekay"
        "https://medium.com/feed/@kentbeck_7670"
        "https://medium.com/feed/quintoandar-tech-blog"
        "https://overreacted.io/rss.xml"
        "https://jvns.ca/atom.xml"
        "https://standardebooks.org/rss/new-releases"))

;; UI config
(setq doom-theme 'doom-nord)
(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 15))

;; Setting transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(setq doom-themes-treemacs-enable-variable-pitch nil)
