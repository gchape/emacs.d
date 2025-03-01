;;; packages.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package yasnippet
  :ensure t
  :init (yas-global-mode)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'"))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'"))

(use-package json-mode
  :ensure t
  :mode ("\\.json\\'"))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package magit
  :ensure t
  :defer t)

(use-package neotree
  :ensure t
  :config
  (setq neo-theme 'icons
	neo-smart-open t
	neo-autorefresh t
	neo-window-width 20
        neo-show-hidden-files t)
  :bind
  ("<f8>" . neotree-toggle))

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 8)
  (vertico-resize nil)
  (vertico-cycle t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless partial-completion))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (orderless))))))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-info t)
  (corfu-cycle t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-preselect 'first)
  (corfu-preview-current 'insert)
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

(use-package lsp-eslint
  :demand t
  :after lsp-mode)

(use-package lsp-mode
  :ensure t
  :hook ((html-mode css-mode js2-mode typescript-mode json-mode) . lsp-deferred)
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

  (lsp-eldoc-render- nil)
  (lsp-signature-doc-lines 1)
  (lsp-ui-doc-use-childframe t)
  
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-icons-enable t)
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
  :hook ((lsp-mode . (lambda () (local-set-key (kbd "M-?") 'lsp-ui-peek-find-references)))))

(use-package prettier
  :ensure t
  :hook ((html-mode css-mode js2-mode typescript-mode json-mode) . prettier-mode))

(use-package emmet-mode
  :ensure t
  :hook ((html-mode . emmet-mode))
  :config
  (setq emmet-indent-after-insert nil
        emmet-indentation 2)
  :bind
  (:map emmet-mode-keymap
        ([tab] . emmet-expand-line)
        ("TAB" . emmet-expand-line)))

(use-package org
  :ensure t
  :defer t
  :config
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-agenda-files '("~/org/"))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t))))

(use-package org-preview-html
  :ensure t
  :defer t)

(use-package org-modern
  :ensure t
  :hook
  ((org-mode . org-modern-mode)
   (org-agenda-finalize . org-modern-agenda)))

;;; packages.el ends here
