;;; mod-navigation.el -- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
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

(provide 'mod-navigation)
;;; mod-navigation.el ends here
