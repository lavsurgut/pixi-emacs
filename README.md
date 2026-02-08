# pixi-emacs

Doom Emacs dev environment via [Pixi](https://pixi.sh) — no Docker, no system packages.

Supports **Python**, **Rust**, **Go**, and **Clojure** out of the box — with LSP, tree-sitter, and format-on-save for each.

Works on macOS (ARM/Intel) and Linux (x86_64/aarch64). Emacs is built from source as a terminal-only binary, everything else comes from conda-forge. Includes Claude Code for AI-assisted development.

## Prerequisites

Install Pixi:

```sh
curl -fsSL https://pixi.sh/install.sh | sh
```

## Setup

```sh
pixi run setup
```

This will:
1. Install all dependencies from conda-forge (including zellij, atuin, direnv, fish, nodejs)
2. Download and compile Emacs 30.1 (terminal-only, ~5-10 min first time)
3. Download Clojure tools (clojure-lsp, babashka, clojure)
4. Install Claude Code (AI coding assistant)
5. Clone Doom Emacs and run `doom install` + `doom sync`

## Usage

### Zellij (recommended entrypoint)

```sh
pixi run ze
```

This opens a zellij session called `pixi-emacs` with fish shell, atuin history search (ctrl+r), and direnv hooks — all pre-configured.

- **Detach**: `Ctrl+Super+d`
- **Reattach**: `pixi run ze` (auto-reattaches to existing session)
- **New tab**: `Ctrl+Super+t`
- **Navigate tabs**: `Ctrl+Super+i` / `Ctrl+Super+o`
- **Navigate panes**: `Ctrl+Super+h/j/k/l`

### Emacs

From inside zellij (or standalone):

```sh
pixi run emacs
```

### Doom sync

After editing `.doom.d/init.el` or `.doom.d/packages.el`:

```sh
pixi run doom-sync
```

## Atuin

Shell history with fuzzy search via `ctrl+r`. Optionally log in for cross-machine sync:

```sh
pixi run -- atuin login -u <username>
```

## Direnv

Automatic environment variable loading. Create an `.envrc` file in any project directory:

```sh
echo 'export MY_VAR=hello' > .envrc
direnv allow
```

Variables are loaded/unloaded automatically when you `cd` in/out.

## Language support

All languages have LSP, tree-sitter, and format-on-save enabled.

### Python
- LSP via pyright — install it in your project venv or globally
- Open a `.py` file and LSP connects automatically

### Rust
- LSP via rust-analyzer — install via `rustup component add rust-analyzer`
- Open a `.rs` file and LSP connects automatically

### Go
- Go toolchain is installed via conda-forge
- LSP via gopls — install with `go install golang.org/x/tools/gopls@latest`
- Open a `.go` file and LSP connects automatically

### Clojure
- Setup installs clojure-lsp, babashka (`bb`), and clojure (macOS via brew-install tarball, Linux via conda-forge)
- Open a `.clj` file — LSP connects automatically via clojure-lsp
- `SPC m '` (or `, '`) — CIDER jack-in
- `, e f` — eval form, `, e b` — eval buffer
- Structural editing via evil-cleverparens: `H`/`L` for sexp navigation, `(`/`)` for up-sexp

## AI tools

### Claude Code

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) is installed automatically during setup via npm. Run it from inside a zellij session:

```sh
claude
```

Set your API key (once per machine):

```sh
export ANTHROPIC_API_KEY=sk-ant-...
```

Or add it to an `.envrc` file in your project directory — direnv will load it automatically.

## Configuration

Doom config lives in `.doom.d/`:
- `init.el` — enabled modules
- `config.el` — personal config
- `packages.el` — extra packages

Tool configs live in `config/`:
- `config/zellij/config.kdl` — zellij keybindings and settings
- `config/atuin/config.toml` — atuin search settings
- `config/direnv/direnv.toml` — direnv settings
- `config/fish/config.fish` — fish shell init (atuin + direnv hooks)
