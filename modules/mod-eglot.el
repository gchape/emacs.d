;;; mod-eglot.el --- Eglot Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package eglot
  :ensure t
  :hook ((clojure-mode clojurec-mode clojurescript-mode) . eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0)
  (eglot-extend-to-xref nil)
  (eglot-sync-connect nil)
  (eglot-connect-timeout 10)
  (eglot-ignored-server-capabilities
   '(:hoverProvider
     :documentHighlightProvider
     :documentFormattingProvider
     :documentRangeFormattingProvider
     :documentOnTypeFormattingProvider
     :colorProvider
     :foldingRangeProvider))
  :config
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq-local eldoc-documentation-functions
                          (cons #'flymake-eldoc-function
                                (remove #'flymake-eldoc-function
                                        eldoc-documentation-functions)))
              (setq-local eldoc-documentation-strategy
                          #'eldoc-documentation-compose-eagerly)))
  (fset #'jsonrpc--log-event #'ignore))

(use-package eglot-booster
  :vc (:url "https://github.com/jdtsmith/eglot-booster")
  :after eglot
  :custom
  (eglot-booster-io-only t)
  :config
  (eglot-booster-mode))

(use-package flymake
  :hook (prog-mode . flymake-mode)
  :custom
  (flymake-no-changes-timeout 0.5)
  (flymake-start-on-flymake-mode t)
  (flymake-start-on-save-buffer t))

(provide 'mod-eglot)
;;; mod-eglot.el ends here
