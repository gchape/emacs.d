;;; config.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

(use-package mood-line
  :ensure t
  :hook (after-init . mood-line-mode)
  :config
  (mood-line-mode)
  :custom
  (mood-line-glyph-alist mood-line-glyphs-fira-code)
  (mood-line-format mood-line-format-default-extended))

(use-package dashboard
  :ensure t
  :hook (after-init . dashboard-mode)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents . 10)
                          (bookmarks . 5)
                          (projects . 5))))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode)
  :init (vertico-mode)
  :custom
  (vertico-count 8)
  (vertico-cycle t)
  (vertico-resize nil)
  (vertico-scroll-margin 0))

(use-package orderless
  :ensure t
  :after vertico
  :custom
  (completion-category-defaults nil)
  (completion-styles '(orderless partial-completion))
  (completion-category-overrides '((file (styles . (partial-completion))))))

(use-package corfu
  :ensure t
  :hook ((org-mode
          js2-mode
          css-mode
          json-mode
          html-mode
          emacs-lisp-mode
          typescript-mode) . corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-info t)
  (corfu-cycle t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-preselect 'first)
  (corfu-preview-current 'insert)
  (corfu-completion-styles '(orderless))
  (text-mode-ispell-word-completion . nil)
  :config
  (keymap-unset corfu-map "RET")
  :bind
  (:map corfu-map
        ("TAB" . corfu-insert)
        ([tab] . corfu-insert)
        ("ESC" . corfu-quit)
        ([esc] . corfu-quit)))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'"))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'"))

(use-package json-mode
  :ensure t
  :mode ("\\.json\\'"))

(use-package yasnippet
  :ensure t
  :init (yas-global-mode))

(use-package prettier
  :ensure t
  :hook ((css-mode
          js2-mode
          html-mode
          json-mode
          typescript-mode) . prettier-mode))

(use-package neotree
  :ensure t
  :hook (after-init . neotree-mode)
  :config
  (setq neo-window-width 20)
  (setq neo-smart-open t)
  (setq neo-theme 'ascii)
  
  (define-key neotree-mode-map (kbd "n") 'neotree-create-node)
  (define-key neotree-mode-map (kbd "d") 'neotree-delete-node)
  (define-key neotree-mode-map (kbd "r") 'neotree-rename-node)
  (define-key neotree-mode-map (kbd "c") 'neotree-copy-node)
  
  (global-set-key (kbd "C-x n")
                  (lambda ()
                    (interactive)
                    (neotree-dir (read-directory-name "Directory: ")))))

(use-package emmet-mode
  :ensure t
  :hook ((html-mode . emmet-mode)
	 (css-mode . emmet-mode))
  :config
  (setq emmet-indentation 2
        emmet-indent-after-insert nil)
  :bind
  (:map emmet-mode-keymap
        ([tab] . emmet-expand-line)
        ("TAB" . emmet-expand-line)))

(use-package lsp-mode
  :hook ((css-mode
	  js2-mode
	  html-mode
	  json-mode
	  java-mode
	  typescript-mode) . lsp-deferred)
  :commands lsp lsp-deferred
  :custom
  (lsp-log-io nil)
  (lsp-keep-workspace-alive nil)
  (lsp-semantic-tokens-enable nil)
  (lsp-session-file "~/.emacs.d/.lsp-session-v1")
  
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
  (lsp-headerline-breadcrumb-icons-enable nil)
  (lsp-headerline-breadcrumb-enable-diagnostics nil)
  (lsp-headerline-breadcrumb-enable-symbol-numbers nil)
  
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
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

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

(use-package org
  :ensure t
  :defer t
  :config
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-agenda-files '("~/org/"))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t)
     (ts . t))))

(use-package org-modern
  :ensure t
  :hook
  ((org-mode . org-modern-mode)
   (org-agenda-finalize . org-modern-agenda)))

(use-package org-preview-html
  :ensure t
  :after org)

(use-package magit
  :ensure t
  :defer t)
;;; config.el ends here
