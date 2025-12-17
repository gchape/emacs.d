;;; init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(defvar last-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216
                  gc-cons-percentage 0.1
                  file-name-handler-alist last-file-name-handler-alist)))

(setq create-lockfiles nil)
(setq frame-title-format "")

(set-face-attribute 'default nil
		    :font "CommitMono Nerd Font"
		    :height 105)

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

(load "~/.emacs.d/config.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(confirm-kill-processes nil)
 '(electric-pair-mode t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages nil)
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(warning-minimum-level :emergency))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; init.el ends here
