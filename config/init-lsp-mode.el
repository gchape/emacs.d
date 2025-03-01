;;; init-lsp-mode.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package lsp-mode
  :ensure t
  :hook ((css-mode
	  js2-mode
	  html-mode
	  json-mode
	  typescript-mode) . lsp-deferred)
  :commands lsp lsp-deferred
  :custom
  (lsp-log-io nil)
  (lsp-enable-imenu nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-keep-workspace-alive nil)
  (lsp-enable-file-watchers nil)
  (lsp-signature-auto-activate nil)
  (lsp-enable-symbol-highlighting t)
  (lsp-enable-on-type-formatting nil)
  (lsp-enable-suggest-server-download t)

  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-diagnostic-max-lines 20)

  (lsp-modeline-diagnostics-enable nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-workspace-status-enable nil)

  (lsp-eldoc-render-all nil)
  (lsp-signature-doc-lines 1)
  (lsp-ui-doc-use-childframe t)
  (lsp-semantic-tokens-enable nil)
  
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-icons-enable nil)
  (lsp-headerline-breadcrumb-enable-diagnostics nil)
  (lsp-headerline-breadcrumb-enable-symbol-numbers nil)
  
  (lsp-completion-provider :none)
  (lsp-diagnostics-provider :flycheck)
  :init
  (setq lsp-use-plists t))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.2
        lsp-ui-peek-enable t
        lsp-ui-sideline-enable t)
  :hook ((lsp-mode . (lambda ()	(local-set-key (kbd "M-?") 'lsp-ui-peek-find-references)))))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode (OLD-FN ARGS) instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command (OLD-FN TEST?) to lsp CMD."
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

(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

;;; init-lsp-mode.el ends here
