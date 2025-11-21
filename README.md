# dot emacs

This is my personal Emacs configuration, tailored specifically for **Clojure** development. It includes optimized settings and packages for a streamlined Clojure programming experience.

## Prerequisites

Before using this configuration, ensure you have the following installed:

* **[Commit Nerd Font](https://www.programmingfonts.org/#commit-mono)** – My default font face
* **[lsp-booster](https://github.com/blahgeek/emacs-lsp-booster)** – Performance booster for `lsp-mode` (optional, for better LSP performance)

![Screenshot\_20250319\_204422](https://github.com/user-attachments/assets/ee82acda-4afe-4d9a-88c9-dea6e89287ea)

![Screenshot\_20250319\_204459](https://github.com/user-attachments/assets/560ae00a-bfaa-4cdd-9fab-0903ed9ddc24)

## Included Packages

### UI Enhancements

* **[solarized-theme](https://github.com/bbatsov/solarized-emacs)** – A popular Solarized color theme
* **[all-the-icons](https://github.com/domtronn/all-the-icons.el)** – Icons for various UI elements
* **[dashboard](https://github.com/emacs-dashboard/emacs-dashboard)** – A startup dashboard with recent files, bookmarks, and projects
* **[centaur-tabs](https://github.com/ema2159/centaur-tabs)** – Tab-based buffer navigation
* **[mood-line](https://github.com/jordanbaird/mood-line)** – A minimal and modern mode line

### Completion & Navigation

* **[vertico](https://github.com/minad/vertico)** – Vertical completion UI
* **[orderless](https://github.com/oantolin/orderless)** – Flexible completion style
* **[corfu](https://github.com/minad/corfu)** – Popup completion UI
* **[kind-icon](https://github.com/jdtsmith/kind-icon)** – Icons for completion candidates

### Clojure Development

* **[eglot](https://github.com/joaotavora/eglot)** – LSP client for Clojure (Clojure-specific LSP support)
* **[cider](https://github.com/clojure-emacs/cider)** – REPL and interactive Clojure development tools
* **[clojure-mode](https://github.com/emacs-mirror/clojure-mode)** – Major mode for editing Clojure code
* **[flycheck](https://www.flycheck.org/)** – On-the-fly syntax checking for Clojure

### Code Snippets & Formatting

* **[yasnippet](https://github.com/joaotavora/yasnippet)** – Snippet expansion

### File Management

* **[neotree](https://github.com/jaypei/emacs-neotree)** – A tree-style file explorer

### Removed Packages

* **[js2-mode](https://github.com/mooz/js2-mode)** – JavaScript editing mode (removed)
* **[typescript-mode](https://github.com/emacs-typescript/typescript.el)** – TypeScript editing mode (removed)
* **[json-mode](https://github.com/joshwnj/json-mode)** – JSON file editing (removed)
* **[prettier](https://github.com/jscheid/prettier.el)** – Code formatter for JavaScript, TypeScript, CSS, JSON (removed)
* **[emmet-mode](https://github.com/smihica/emmet-mode)** – Abbreviations for HTML and CSS (removed)
* **[lsp-mode](https://github.com/emacs-lsp/lsp-mode)** – Language Server Protocol support (removed in favor of `eglot`)

---

### Summary of Changes:

* **Removed Web Development Packages**: All packages related to web development (like `js2-mode`, `typescript-mode`, `json-mode`, `prettier`, `emmet-mode`) have been removed.
* **Removed Version Control and Database Tools**: Removed **Magit** for Git integration and **pgmacs** for PostgreSQL tools.
* **Focused on Clojure**: The configuration is now optimized specifically for Clojure development, with **eglot**, **cider**, and **clojure-mode** as the core tools for Clojure programming.
