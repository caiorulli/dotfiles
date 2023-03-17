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
       (treemacs +lsp)
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       multiple-cursors
       rotate-text
       snippets
       format

       :emacs
       (dired +ranger)
       electric
       ibuffer
       vc

       :tools
       direnv
       (eval +overlay)
       (lookup +docsets)
       magit
       (lsp +peek)
       (debugger +lsp)
       pdf
       docker
       make
       tree-sitter

       :lang
       (go +lsp +tree-sitter)
       (java +lsp +tree-sitter)
       (python +lsp +tree-sitter)
       (clojure +tree-sitter)
       emacs-lisp
       org
       markdown
       web
       yaml
       data

       :config
       (default +bindings +smartparens))
