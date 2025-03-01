;;; init-org.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package org
  :ensure t
  :defer t
  :config
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-agenda-files '("~/org/"))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t)
     (ts . t))))

(use-package org-preview-html
  :ensure t
  :after org)

(use-package org-modern
  :ensure t
  :hook
  ((org-mode . org-modern-mode)
   (org-agenda-finalize . org-modern-agenda)))

;;; init-org.el ends here
