# dot emacs

Single-branch modular design. No more separate branches for different setups—just toggle modules in `init.el`.

<img width="2742" height="1721" alt="image" src="https://github.com/user-attachments/assets/9ad15fb8-c332-45e9-a8f2-190314c3d80d" />

Post-install:
1. Launch Emacs (packages auto-install)
2. `M-x all-the-icons-install-fonts`
3. Restart

## Structure

```
~/.emacs.d/
├── init.el              # Toggle modules here
└── modules/
    ├── mod-ui.el        # Theme, dashboard, modeline
    ├── mod-completion.el # Vertico, Corfu, snippets
    ├── mod-navigation.el # Neotree, auto-save
    ├── mod-lsp.el       # Full LSP with flycheck
    ├── mod-eglot.el     # Lightweight LSP alternative
    ├── mod-web.el       # JS/TS/HTML/CSS/JSON
    └── mod-clojure.el   # Clojure + CIDER
```

## Modules

### Core (always loaded)
- **mod-ui**: Solarized theme, dashboard, mood-line, vim-tab-bar
- **mod-completion**: Vertico (minibuffer), Corfu (in-buffer), yasnippet
- **mod-navigation**: Neotree file tree (`C-x n`), super-save

### LSP Backend (pick one in init.el)
- **mod-lsp**: Full-featured, best for large projects, includes lsp-booster
- **mod-eglot**: Lightweight, fast startup, uses built-in Emacs features

### Languages (optional)
- **mod-web**: JS/TS/HTML/CSS + Prettier + Emmet (`TAB` for expansion)
- **mod-clojure**: Clojure/ClojureScript + CIDER REPL + paredit + clj-refactor

## Usage

### Toggle Modules
Edit `init.el`:
```elisp
;; Choose LSP backend
(require 'mod-lsp)        ; or
;; (require 'mod-eglot)

;; Enable languages you need
(require 'mod-web)
(require 'mod-clojure)
```

### Switch LSP Backend
If using eglot, update hooks in `mod-web.el`:
```elisp
;; Change from:
:hook (js2-mode . lsp-deferred)
;; To:
:hook (js2-mode . eglot-ensure)
```

### Key Bindings

**Navigation:**
- `C-x n` - Open neotree

**LSP (with mod-lsp):**
- `M-.` - Peek definition
- `M-?` - Peek references

**Clojure CIDER:**
- `C-c C-k` - Load buffer
- `C-c C-e` - Eval expression
- `C-c C-d` - Documentation
- `C-c M-n M-r` - Refresh namespace

**Emmet (web-mode):**
- `TAB` - Expand abbreviation (e.g., `div.class` → `<div class="class"></div>`)

## Customization

**Change theme:**
```elisp
;; In mod-ui.el
(load-theme 'modus-vivendi-deuteranopia t)
```

**Disable modules:**
Comment out in `init.el`:
```elisp
;; (require 'mod-clojure)  ; Clojure disabled
```

**Add your own module:**
```elisp
;; ~/.emacs.d/modules/mod-custom.el
(provide 'mod-custom)

;; In init.el
(require 'mod-custom)
```

## Migration from Branches

Old workflow:
```bash
git checkout lsp-branch     # For LSP
git checkout clojure-branch # For Clojure
```

New workflow:
```elisp
;; Edit init.el once
(require 'mod-lsp)     ; Enable LSP
(require 'mod-clojure) ; Enable Clojure
```

All features available in one branch. No more branch management.

## Troubleshooting

**Package install errors:**
- `M-x package-refresh-contents`
- Restart Emacs

**LSP not starting:**
- Check if language server installed (e.g., `typescript-language-server` for TS)
- `M-x lsp-install-server` or `M-x eglot-ensure`

**Icons not showing:**
- `M-x all-the-icons-install-fonts`
- Restart Emacs

## Dependencies

**Optional external tools:**
- `emacs-lsp-booster` - LSP performance boost
- Language servers (auto-prompted on first use):
  - `typescript-language-server` (JS/TS)
  - `vscode-css-language-server` (CSS)
  - `vscode-html-language-server` (HTML)
  - `clojure-lsp` (Clojure)

## License

GNU General Public License v3.0
