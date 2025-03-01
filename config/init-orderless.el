;;; init-orderless.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package orderless
  :ensure t
  :after vertico
  :custom
  (completion-category-defaults nil)
  (completion-styles '(orderless partial-completion))
  (completion-category-overrides '((file (styles . (orderless flex))))))

;;; init-orderless.el ends here
