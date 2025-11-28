# dot emacs

This is my personal Emacs configuration, tailored specifically for **Clojure** development. It includes optimized settings and packages for a streamlined Clojure programming experience.

## Prerequisites

Before using this configuration, ensure you have the following installed:

* **[Commit Nerd Font](https://www.programmingfonts.org/#commit-mono)** – My default font face
* **[lsp-booster](https://github.com/blahgeek/emacs-lsp-booster)** – Performance booster for `lsp-mode` (optional, for better LSP performance)

<img width="1007" height="891" alt="image" src="https://github.com/user-attachments/assets/670ae5ea-6cf6-4c0d-8767-3543ff6f2dad" />

<img width="1007" height="891" alt="image" src="https://github.com/user-attachments/assets/f46b5f7f-2e80-44eb-9897-b285dd1b0420" />

---

## Included Packages

### UI Enhancements

* **Custom Mode Line** – Replaced `mood-line` and `centaur-tabs` with a personalized mode line configuration, including:

  * simplified display of modified buffers (`×`) and read-only buffers (`R`)
  * remote file indicator (`☎`)
  * customized position format (`Lline:column`)
  * project and VC info integrated
* **[all-the-icons](https://github.com/domtronn/all-the-icons.el)** – Icons for various UI elements
* **[dashboard](https://github.com/emacs-dashboard/emacs-dashboard)** – Startup dashboard with recent files, bookmarks, and projects

### Completion & Navigation

* **[vertico](https://github.com/minad/vertico)** – Vertical completion UI
* **[orderless](https://github.com/oantolin/orderless)** – Flexible completion style
* **[corfu](https://github.com/minad/corfu)** – Popup completion UI
* **[kind-icon](https://github.com/jdtsmith/kind-icon)** – Icons for completion candidates

### Clojure Development

* **[eglot](https://github.com/joaotavora/eglot)** – LSP client for Clojure
* **[eglot-booster](https://github.com/jdtsmith/eglot-booster)** – Rust-based booster for faster LSP communication, configured with IO-only mode (`eglot-booster-io-only = t`)
* **[cider](https://github.com/clojure-emacs/cider)** – REPL and interactive Clojure development tools
* **[clojure-mode](https://github.com/emacs-mirror/clojure-mode)** – Major mode for editing Clojure code
* **[flycheck](https://www.flycheck.org/)** – On-the-fly syntax checking

### Code Snippets & Formatting

* **[yasnippet](https://github.com/joaotavora/yasnippet)** – Snippet expansion

### File Management

* **[neotree](https://github.com/jaypei/emacs-neotree)** – Tree-style file explorer

---

### Removed Packages

* **[mood-line](https://github.com/jordanbaird/mood-line)** – Removed in favor of custom mode line
* **[centaur-tabs](https://github.com/ema2159/centaur-tabs)** – Removed tab-based buffer navigation
* **Web Development Packages**: `js2-mode`, `typescript-mode`, `json-mode`, `prettier`, `emmet-mode`
* **Other Tools**: `lsp-mode`, `magit`, `pgmacs`

---

### Summary of Changes

* **Custom Mode Line**: Simplified, readable, and optimized for Clojure workflow; replaced `mood-line` and `centaur-tabs`.
* **Boosted LSP Performance**: Enabled `eglot-booster` with IO-only mode for faster JSON parsing in Emacs 30+.
* **Focused on Clojure**: Removed web development and other unrelated packages to streamline the configuration.
