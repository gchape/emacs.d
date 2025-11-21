;;; config.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(remove-hook 'prog-mode-hook 'flymake-mode)

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

(use-package all-the-icons
  :ensure t)

(use-package mood-line
  :ensure t
  :hook (after-init . mood-line-mode)
  :custom
  (mood-line-format mood-line-format-default)
  (mood-line-glyph-alist mood-line-glyphs-unicode))

(use-package dashboard
  :ensure t
  :custom
  (dashboard-startup-banner 3)
  (dashboard-center-content t)
  (dashboard-set-file-icons t)
  (dashboard-navigation-cycle t)
  (dashboard-icon-type 'all-the-icons)
  (dashboard-items '((recents . 5)
                     (bookmarks . 5)
                     (projects . 5)))
  :config
  (dashboard-setup-startup-hook))

(use-package centaur-tabs
  :ensure t
  :custom
  (centaur-tabs-style "bar")
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'left)
  (centaur-tabs-set-close-button nil)
  (centaur-tabs-gray-out-icons 'buffer)
  (centaur-tabs-icon-type 'all-the-icons)
  :bind
  ("C-<next>" . centaur-tabs-forward)
  ("C-<prior>" . centaur-tabs-backward)
  :config
  (centaur-tabs-mode t))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode)
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
  :hook (prog-mode . corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-preselect 'prompt)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  :bind
  (:map corfu-map
        ("TAB" . corfu-insert)
        ([tab] . corfu-insert)
        ("C-g" . corfu-quit)
        ("M-<f12>" . corfu-popupinfo-toggle)
        ("C-S-p" . corfu-popupinfo-scroll-down)
        ("C-S-n" . corfu-popupinfo-scroll-up))
  :config
  (keymap-unset corfu-map "RET")
  (keymap-unset corfu-map "ESC")
  (corfu-popupinfo-mode 1))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))

(use-package yasnippet
  :ensure t
  :init (yas-global-mode))

(use-package neotree
  :ensure t
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

(use-package clojure-mode
  :ensure t
  :custom
  (clojure-indent-style 'always-indent)
  (clojure-indent-keyword-style 'always-indent)
  (clojure-enable-indent-specs nil))

(use-package eglot
  :hook (((clojure-mode clojurec-mode clojurescript-mode) . eglot-ensure))
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0)
  (eglot-extend-to-xref nil)
  (eglot-ignored-server-capabilities
   '(:hoverProvider
     :documentHighlightProvider
     :documentFormattingProvider
     :documentRangeFormattingProvider
     :documentOnTypeFormattingProvider
     :colorProvider
     :foldingRangeProvider))
  (eglot-stay-out-of '(yasnippet eldoc)))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            (setq eldoc-documentation-strategy #'eldoc-documentation-enthusiast)))

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode)
  :custom
  (flycheck-check-syntax-automatically '(mode-enabled save))
  (flycheck-display-errors-delay 0.0)
  (flycheck-display-errors-function nil)
  (flycheck-help-echo nil)
  :bind
  (:map flycheck-mode-map
        ("M-g n" . flycheck-next-error)
        ("M-g p" . flycheck-previous-error)
        ("M-g d" . flycheck-list-errors)))

(use-package cider
  :ensure t
  :after clojure-mode
  :hook (cider-repl-mode . corfu-mode)
  :custom
  (cider-use-tooltips nil)
  (cider-docstring-max-lines 0)
  (cider-eldoc-display-for-symbol-at-point nil))
;;; config.el ends here
