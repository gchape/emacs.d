;;; config.el --- Optimized Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Optimized for faster startup and better performance
;;; Code:

(load-theme 'modus-vivendi-tinted)

(setq inhibit-compacting-font-caches t)
(setq gc-cons-threshold (* 100 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1024 1024))))

(use-package all-the-icons
  :ensure t
  :defer t)

(use-package dashboard
  :ensure t
  :demand t
  :custom
  (dashboard-startup-banner 3)
  (dashboard-center-content t)
  (dashboard-set-file-icons t)
  (dashboard-navigation-cycle t)
  (dashboard-icon-type 'all-the-icons)
  (dashboard-items '((recents   . 5)
                     (bookmarks . 5)
                     (projects  . 5)))
  :config
  (dashboard-setup-startup-hook))

(use-package vim-tab-bar
  :ensure t
  :commands vim-tab-bar-mode
  :hook
  (after-init . vim-tab-bar-mode))

(use-package vertico
  :ensure t
  :demand t
  :custom
  (vertico-scroll-margin 0)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :defer t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package corfu
  :ensure t
  :hook (prog-mode . corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-preselect 'first)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode)
  (corfu-indexed-mode)
  (corfu-popupinfo-mode)
  :bind
  (:map corfu-map
        ("TAB"     . corfu-insert)
        ([tab]     . corfu-insert)
        ("C-g"     . corfu-quit)
        ("M-<f12>" . corfu-popupinfo-toggle)
        ("C-S-p"   . corfu-popupinfo-scroll-down)
        ("C-S-n"   . corfu-popupinfo-scroll-up)))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package super-save
  :ensure t
  :hook (after-init . super-save-mode)
  :custom
  (super-save-auto-save-when-idle t)
  (super-save-idle-duration 5))

(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode)
  :custom
  (yas-verbosity 1)
  :config
  (yas-reload-all))

(use-package neotree
  :ensure t
  :defer t
  :custom
  (neo-window-width 25)
  (neo-smart-open t)
  (neo-theme 'ascii)
  (neo-show-hidden-files nil)
  (neo-auto-indent-point t)
  :bind
  (("C-x n" . neotree-dir-prompt)
   :map neotree-mode-map
   ("n" . neotree-create-node)
   ("d" . neotree-delete-node)
   ("r" . neotree-rename-node)
   ("c" . neotree-copy-node))
  :config
  (defun neotree-dir-prompt ()
    "Open neotree in a directory chosen by the user."
    (interactive)
    (neotree-dir (read-directory-name "Directory: "))))

(use-package clojure-mode
  :ensure t
  :defer t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.cljc\\'" . clojurec-mode))
  :custom
  (clojure-indent-style 'always-indent)
  (clojure-align-forms-automatically t)
  (clojure-toplevel-inside-comment-form t))

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

(use-package cider
  :ensure t
  :defer t
  :hook (cider-mode . (lambda ()
                       (add-hook 'before-save-hook 'cider-format-buffer nil t)
                       (remove-hook 'eldoc-documentation-functions #'cider-eldoc t)
                       (setq-local eldoc-documentation-functions
                                   (cons #'flymake-eldoc-function
                                         (remove #'flymake-eldoc-function eldoc-documentation-functions)))
                       (advice-add 'cider-eldoc :override #'ignore)
                       (fset 'cider-class-choice-completing-read (lambda () nil))))
  :custom
  (cider-repl-display-help-banner nil)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-show-error-buffer 'only-in-repl)
  (cider-font-lock-dynamically '(macro core function var))
  (cider-eldoc-display-context nil)
  (cider-use-xref t)
  (cider-use-tooltips nil)
  (cider-save-file-on-load t)
  (nrepl-hide-special-buffers t)
  (nrepl-log-messages nil))

;;; config.el ends here
