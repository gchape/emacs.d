;;; init-corfu.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

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
  :custom
  (kind-icon-use-icons nil)
  :after corfu
  :config
  (add-to-list
   'corfu-margin-formatters #'kind-icon-margin-formatter))

;;; init-corfu.el ends here
