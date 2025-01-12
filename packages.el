(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package magit
  :ensure t
  :defer t)

(use-package super-save
  :ensure t
  :config
  (super-save-mode +1)
  (setq auto-save-default nil
        super-save-auto-save-when-idle t))

(use-package centaur-tabs
  :ensure t
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (setq centaur-tabs-icon-type 'all-the-icons
	centaur-tabs-gray-out-icons 'buffer
	centaur-tabs-set-modified-marker t
	centaur-tabs-modifier-mark "*"
	centaur-tabs-set-bar 'left
        centaur-tabs-set-icons t
	centaur-tabs-style "bar"
	centaur-tabs-height 28)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t))

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 8)
  (vertico-resize nil)
  (vertico-cycle t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless partial-completion))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (orderless)))))
  )

(use-package org
  :ensure t
  :defer t
  :config
  (setq org-startup-indented t
	org-hide-emphasis-markers t
	org-agenda-files '("~/org/")
	org-latex-listings 'engraved
        org-latex-engraved-theme 'gruvbox-dark-hard)
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t)))
  )

(use-package org-preview-html
  :ensure t
  :defer t)

(use-package org-modern
  :ensure t
  :hook
  ((org-mode . org-modern-mode)
   (org-agenda-finalize . org-modern-agenda)))
