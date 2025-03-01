;;; init-vertico.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-count 8)
  (vertico-cycle t)
  (vertico-resize nil)
  (vertico-scroll-margin 0))

;;; init-vertico.el ends here
