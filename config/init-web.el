;;; init-web.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'"))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'"))

(use-package json-mode
  :ensure t
  :mode ("\\.json\\'"))

(use-package prettier
  :ensure t
  :hook ((css-mode
	  js2-mode
	  html-mode
	  json-mode
	  typescript-mode) . prettier-mode))

(use-package emmet-mode
  :ensure t
  :hook ((html-mode . emmet-mode))
  :config
  (setq emmet-indentation 2
	emmet-indent-after-insert nil)
  :bind
  (:map emmet-mode-keymap
        ([tab] . emmet-expand-line)
        ("TAB" . emmet-expand-line)))

;;; init-web.el ends here
