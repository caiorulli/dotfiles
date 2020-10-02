;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       ivy

       :checkers
       syntax

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       modeline
       nav-flash
       ophints
       (popup +all +defaults)
       treemacs
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       multiple-cursors
       parinfer
       rotate-text
       snippets

       :emacs
       (dired +ranger)
       electric
       ibuffer
       vc

       :app
       calendar
       (rss +org)

       :email
       mu4e

       :tools
       direnv
       (eval +overlay)
       (lookup +docsets)
       magit
       lsp
       (debugger +lsp)
       pdf

       :lang
       clojure
       scheme
       common-lisp
       emacs-lisp
       (rust +lsp)
       (haskell +dante)
       sh
       data
       markdown
       yaml
       (org +hugo +roam)

       :config
       (default +bindings +smartparens))
