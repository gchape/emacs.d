;;; init-flycheck.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode)
  :custom
  (flycheck-help-echo-function nil)
  (flycheck-display-errors-delay 0.0)
  (flycheck-auto-display-errors-after-checking t))

;;; init-flycheck.el ends here
