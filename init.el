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

(setq frame-title-format "")
(set-face-attribute 'default nil
		    :font "CommitMono Nerd Font"
		    :height 100)


(load "~/.emacs.d/config/init-ui.el")

(load "~/.emacs.d/config/init-org.el")

(load "~/.emacs.d/config/init-web.el")

(load "~/.emacs.d/config/init-lsp-mode.el")

(load "~/.emacs.d/config/init-magit.el")
(load "~/.emacs.d/config/init-corfu.el")
(load "~/.emacs.d/config/init-vertico.el")
(load "~/.emacs.d/config/init-neotree.el")
(load "~/.emacs.d/config/init-flycheck.el")
(load "~/.emacs.d/config/init-orderless.el")
(load "~/.emacs.d/config/init-yasnippet.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(confirm-kill-processes nil)
 '(electric-pair-mode t)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((eglot-booster :url "https://github.com/jdtsmith/eglot-booster.git"
		    :branch "main")))
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
