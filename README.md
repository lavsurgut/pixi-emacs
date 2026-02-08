# pixi-emacs

Doom Emacs dev environment via [Pixi](https://pixi.sh) — no Docker, no system packages.

Works on macOS (ARM/Intel) and Linux x86_64. Emacs is built from source as a terminal-only binary, everything else comes from conda-forge.

## Prerequisites

Install Pixi:

```sh
curl -fsSL https://pixi.sh/install.sh | sh
```

## Setup

```sh
pixi run install-doom
```

This will:
1. Install all dependencies from conda-forge
2. Download and compile Emacs 30.1 (terminal-only, ~5-10 min first time)
3. Clone Doom Emacs and run `doom install`

## Usage

```sh
pixi run emacs
```

After editing `.doom.d/init.el` or `.doom.d/packages.el`:

```sh
pixi run doom-sync
```

## Configuration

Doom config lives in `.doom.d/`:
- `init.el` — enabled modules
- `config.el` — personal config
- `packages.el` — extra packages
