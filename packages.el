(require 'package)

;; Add MELPA package archive if not already added
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Install 'use-package' if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Install 'pg' and 'pgmacs' from GitHub if not already installed
(unless (package-installed-p 'pg)
  (package-vc-install "https://github.com/emarsden/pg-el" nil nil 'pg))

(unless (package-installed-p 'pgmacs)
  (package-vc-install "https://github.com/emarsden/pgmacs"))

(require 'pgmacs)

;; Vertico for enhanced completion
(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 8)
  (vertico-resize nil)
  (vertico-cycle t)
  :init
  (vertico-mode))

;; Leuven theme ()
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-light-hard t))

;; All-the-icons for file icons in Neotree and other packages
(use-package all-the-icons
  :ensure t)

;; Neotree for file tree navigation
(use-package neotree
  :ensure t
  :bind
  ([f8] . neotree-toggle)
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-position 'left
        neo-window-fixed-size nil
        neo-theme (if (display-graphic-p) 'icons 'arrow)
        neo-highlight-first-file t
        neo-window-width 20)

  ;; Keybindings for neotree actions
  (define-key neotree-mode-map (kbd "n") 'neotree-create-node)
  (define-key neotree-mode-map (kbd "d") 'neotree-delete-node)
  (define-key neotree-mode-map (kbd "r") 'neotree-rename-node)
  (define-key neotree-mode-map (kbd "c") 'neotree-copy-node))

;; Configure the mood-line package with Fira Code glyphs
(use-package mood-line
  :ensure t
  :config
  (mood-line-mode)
  :custom
  (mood-line-glyph-alist mood-line-glyphs-fira-code))

(use-package magit
  :ensure t)
