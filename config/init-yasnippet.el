;;; init-yasnippet.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package yasnippet
  :ensure t
  :init (yas-global-mode)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

;;; init-yasnippet.el ends here
