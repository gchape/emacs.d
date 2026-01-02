;;; mod-clojure.el -- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.cljc\\'" . clojurec-mode)
         ("\\.edn\\'" . clojure-mode))
  :custom
  (clojure-indent-style 'always-align)
  (clojure-align-forms-automatically t)
  (clojure-toplevel-inside-comment-form t)
  (clojure-thread-all-but-last t))

(use-package cider
  :ensure t
  :defer t
  :hook ((cider-mode . cider-setup-completion)
         (cider-repl-mode . cider-setup-completion))
  :preface
  (defun cider-setup-completion ()
    (add-hook 'before-save-hook #'cider-format-buffer nil t)
    (setq-local completion-category-overrides
                '((cider (styles basic))))
    (setq-local eldoc-documentation-functions
                '(flymake-eldoc-function cider-eldoc))
    (setq-local eldoc-documentation-strategy
                #'eldoc-documentation-compose-eagerly))
  :custom
  (cider-repl-display-help-banner nil)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-repl-result-prefix ";; => ")
  (cider-repl-use-pretty-printing t)
  (cider-repl-display-in-current-window t)
  (cider-repl-use-clojure-font-lock t)
  (cider-show-error-buffer 'only-in-repl)
  (cider-auto-select-error-buffer nil)
  (cider-stacktrace-default-filters '(tooling dup))
  (cider-font-lock-dynamically '(macro core function var))
  (cider-save-file-on-load t)
  (cider-auto-jump-to-error t)
  (cider-annotate-completion-candidates t)
  (cider-completion-annotations-include-ns t)
  (cider-eldoc-display-context-dependent-info t)
  (cider-eldoc-display-for-symbol-at-point t)
  (cider-use-tooltips nil)
  (cider-use-xref t)
  (cider-auto-track-ns-form-changes t)
  (cider-repl-history-size 1000)
  (cider-repl-wrap-history t)
  (nrepl-hide-special-buffers t)
  (nrepl-log-messages nil)
  (nrepl-use-ssh-fallback-for-remote-hosts t))

(use-package clj-refactor
  :ensure t
  :defer t
  :hook (clojure-mode . clj-refactor-mode)
  :custom
  (cljr-warn-on-eval nil)
  (cljr-eagerly-build-asts-on-startup nil)
  (cljr-add-ns-to-blank-clj-files nil)
  :config
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package rainbow-delimiters
  :ensure t
  :hook ((clojure-mode . rainbow-delimiters-mode)
         (clojurescript-mode . rainbow-delimiters-mode)
         (cider-repl-mode . rainbow-delimiters-mode)
         (emacs-lisp-mode . rainbow-delimiters-mode)))

(provide 'mod-clojure)
;;; mod-clojure.el ends here
