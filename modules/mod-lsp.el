;;; mod-lsp.el --- LSP Mode Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :custom
  (lsp-log-io nil)
  (lsp-keep-workspace-alive nil)
  (lsp-semantic-tokens-enable nil)
  (lsp-enable-xref t)
  (lsp-enable-links t)
  (lsp-enable-imenu nil)
  (lsp-enable-indentation nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-enable-file-watchers nil)
  (lsp-enable-symbol-highlighting t)
  (lsp-enable-on-type-formatting nil)
  (lsp-enable-text-document-color nil)
  (lsp-enable-suggest-server-download t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-sideline-delay 0)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-diagnostic-max-lines 20)
  (lsp-signature-auto-activate nil)
  (lsp-signature-render-documentation nil)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-workspace-status-enable nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-completion-show-kind t)
  (lsp-completion-provider :none)
  (lsp-diagnostics-provider :flycheck)
  :init
  (setq lsp-use-plists t))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :config
  (setq lsp-ui-peek-enable t)
  (define-key lsp-ui-mode-map (kbd "M-.") #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map (kbd "M-?") #'lsp-ui-peek-find-references))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode (OLD-FN ARGS) instead of JSON."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))

(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command (OLD-FN TEST?) to LSP CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)
             (not (file-remote-p default-directory))
             lsp-use-plists
             (not (functionp 'json-rpc-connection))
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))

(advice-add 'lsp-resolve-final-command
            :around
            #'lsp-booster--advice-final-command)

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode)
  :custom
  (flycheck-help-echo-function nil)
  (flycheck-display-errors-delay 0.0)
  (flycheck-auto-display-errors-after-checking t))

(provide 'mod-lsp)
;;; mod-lsp.el ends here
