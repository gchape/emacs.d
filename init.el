;; Disable unnecessary UI elements in GUI mode
(if window-system
    (progn
      (tool-bar-mode -1)        ;; Disable tool bar
      (menu-bar-mode -1)        ;; Disable menu bar
      (scroll-bar-mode -1)))    ;; Disable scroll bar

;; Ignore the bell ring (no annoying sound)
(setq ring-bell-function 'ignore)

;; Load external package configuration
(load "~/.emacs.d/packages.el")

;; Display time in the mode line in HH:MM format
(setq display-time-format "%H:%M")
(display-time-mode 1)

;; Disable confirmation when killing processes
(setq confirm-kill-processes nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(treemacs-nerd-icons nerd-icons treemacs gruvbox-theme vertico pgmacs pg))
 '(package-vc-selected-packages
   '((pgmacs :vc-backend Git :url "https://github.com/emarsden/pgmacs")
     (pg :vc-backend Git :url "https://github.com/emarsden/pg-el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shadow ((t (:foreground "dim gray")))))
