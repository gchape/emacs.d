;;; init-neotree.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package neotree
  :ensure t
  :hook (after-init . neotree-mode)
  :config
  (setq neo-window-width 20)
  (setq neo-smart-open t)
  (setq neo-theme 'ascii)

  (defun neotree-move-node ()
    (interactive)
    (when (fboundp 'neo-buffer--get-filename-current-line)
      (let ((current-node (neo-buffer--get-filename-current-line)))
        (when current-node
          (let ((destination-dir (read-directory-name (format "Move [%s] to: " (file-name-nondirectory current-node)))))
            (rename-file current-node (concat (file-name-as-directory destination-dir) (file-name-nondirectory current-node))))
          (when (fboundp 'neotree-refresh)
            (neotree-refresh))))))

  (with-eval-after-load 'neotree
    (define-key neotree-mode-map (kbd "n") 'neotree-create-node)
    (define-key neotree-mode-map (kbd "d") 'neotree-delete-node)
    (define-key neotree-mode-map (kbd "r") 'neotree-rename-node)
    (define-key neotree-mode-map (kbd "c") 'neotree-copy-node)
    (define-key neotree-mode-map (kbd "m") 'neotree-move-node))

  (global-set-key (kbd "C-x n")
                  (lambda ()
                    (interactive)
                    (neotree-dir (read-directory-name "Directory: ")))))

;;; init-neotree.el ends here

