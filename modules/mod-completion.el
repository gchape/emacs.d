;;; mod-completion.el --- Completion Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package vertico
  :ensure t
  :demand t
  :custom
  (vertico-count 8)
  (vertico-cycle t)
  (vertico-resize t)
  (vertico-scroll-margin 0)
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
  :init
  (global-corfu-mode)
  (corfu-indexed-mode)
  :hook (cider-mode . corfu-popupinfo-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-preselect 'first)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-quit-no-match 'separator)
  :bind
  (:map corfu-map
        ("TAB" . corfu-insert)
        ([tab] . corfu-insert)
        ("C-g" . corfu-quit)
        ("M-<f12>" . corfu-popupinfo-toggle)))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode)
  :custom
  (yas-verbosity 1)
  :init
  (yas-global-mode)
  :config
  (yas-reload-all))

(provide 'mod-completion)
;;; mod-completion.el ends here
