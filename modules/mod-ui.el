;;; mod-ui.el -- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(load-theme 'modus-operandi-deuteranopia t)

(use-package all-the-icons
  :ensure t
  :defer t)

(use-package spacious-padding
  :ensure t
  :config
  (spacious-padding-mode 1))

(use-package dashboard
  :ensure t
  :demand t
  :custom
  (dashboard-startup-banner 3)
  (dashboard-center-content t)
  (dashboard-set-file-icons t)
  (dashboard-navigation-cycle t)
  (dashboard-icon-type 'all-the-icons)
  (dashboard-items '((recents   . 5)
                     (bookmarks . 5)
                     (projects  . 5)))
  :config
  (dashboard-setup-startup-hook))

(setopt mode-line-format
        '("%e"
          mode-line-front-space
          mode-line-client
          mode-line-modified
          mode-line-remote
          mode-line-window-dedicated
          mode-line-frame-identification
          mode-line-buffer-identification
          "   "
          mode-line-position
          mode-line-format-right-align
          (project-mode-line project-mode-line-format)
          (vc-mode vc-mode)
          "  "
          mode-line-modes
          mode-line-misc-info
          "  "
          mode-line-end-spaces))
(setopt mode-line-modified
        '((:eval (if buffer-read-only "R" ""))
          (:propertize
           (:eval (if (buffer-modified-p) "×" "")) face error)))
(setopt mode-line-modes (remove "(" (remove ")" mode-line-modes)))
(setopt mode-line-position-column-line-format '("%l:%c"))
(setopt mode-line-position-line-format '("L%l"))
(setopt mode-line-remote
        '(:eval (if (file-remote-p default-directory) "☎" "")))
(setopt mode-line-right-align-edge 'window)

(provide 'mod-ui)
;;; mod-ui.el ends here
