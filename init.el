;;; init.el --- Modular Emacs Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq gc-cons-threshold (* 100 1024 1024))

(setq default-frame-alist '((inhibit-double-buffering . t)))
(setq redisplay-skip-fontification-on-input t)
(setq inhibit-compacting-font-caches t)
(setq fast-but-imprecise-scrolling t)
(setq jit-lock-defer-time 0.05)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1024 1024))))



(set-face-attribute 'default nil
		    :font "CommitMono Nerd Font"
		    :height 105)

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'mod-ui)
(require 'mod-completion)
(require 'mod-navigation)

;; (require 'mod-lsp)
(require 'mod-eglot)

;; (require 'mod-web)
(require 'mod-clojure)

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
 '(package-vc-selected-packages
   '((eglot-booster :url "https://github.com/jdtsmith/eglot-booster")))
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
