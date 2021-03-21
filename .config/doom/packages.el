;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; General
(package! paredit)

;; Clojure
(package! clojure-mode)
(package! cider)
(package! clj-refactor)
(package! flycheck-clj-kondo)

;; Scheme
(package! geiser)
