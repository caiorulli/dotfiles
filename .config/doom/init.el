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
       (rss +org)

       :tools
       direnv
       (eval +overlay)
       (lookup +docsets)
       magit
       lsp
       (debugger +lsp)
       pdf
       docker

       :lang
       clojure
       emacs-lisp
       (haskell +dante)
       (elixir +lsp)
       (cc +lsp)
       (rust +lsp)
       (go +lsp)
       sh
       data
       markdown
       yaml
       (org +hugo)

       :config
       (default +bindings +smartparens))
