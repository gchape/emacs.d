;;; mod-web.el --- Web Development Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" "\\.mjs\\'")
  :hook (js2-mode . lsp-deferred)  ; Change to eglot-ensure if using mod-eglot
  :custom
  (js2-basic-offset 2)
  (js2-bounce-indent-p nil)
  (js2-mode-show-parse-errors nil)
  (js2-mode-show-strict-warnings nil))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :hook (typescript-mode . lsp-deferred)  ; Change to eglot-ensure if using mod-eglot
  :custom
  (typescript-indent-level 2))

(use-package json-mode
  :ensure t
  :mode ("\\.json\\'" "\\.jsonc\\'")
  :hook (json-mode . lsp-deferred)  ; Change to eglot-ensure if using mod-eglot
  :custom
  (js-indent-level 2))

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.htm\\'" "\\.jsx\\'" "\\.tsx\\'")
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-enable-auto-pairing t)
  (web-mode-enable-auto-closing t))

(use-package css-mode
  :mode "\\.css\\'"
  :hook (css-mode . lsp-deferred)  ; Change to eglot-ensure if using mod-eglot
  :custom
  (css-indent-offset 2))

(use-package prettier
  :ensure t
  :hook ((css-mode
          js2-mode
          json-mode
          typescript-mode
          web-mode) . prettier-mode)
  :custom
  (prettier-enabled-parsers '(babel
                              babel-flow
                              babel-ts
                              typescript
                              css
                              html
                              json)))

(use-package emmet-mode
  :ensure t
  :hook ((web-mode . emmet-mode)
         (css-mode . emmet-mode)
         (html-mode . emmet-mode))
  :custom
  (emmet-indentation 2)
  (emmet-indent-after-insert nil)
  :bind
  (:map emmet-mode-keymap
        ([tab] . emmet-expand-line)
        ("TAB" . emmet-expand-line)))

(use-package restclient
  :ensure t
  :mode ("\\.http\\'" . restclient-mode))

(provide 'mod-web)
;;; mod-web.el ends here
