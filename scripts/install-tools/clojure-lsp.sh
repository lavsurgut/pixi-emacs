#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$CONDA_PREFIX/bin"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$ARCH" in
  x86_64)        ARCH_NORM="amd64" ;;
  aarch64|arm64) ARCH_NORM="aarch64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

if command -v clojure-lsp &>/dev/null; then
  echo "clojure-lsp already installed: $(clojure-lsp --version 2>&1 | head -1)"
else
  echo "Installing clojure-lsp..."
  CLJ_LSP_VERSION="2025.11.28-12.47.43"
  case "$OS" in
    Linux)  CLJ_LSP_PLATFORM="linux-${ARCH_NORM}" ;;
    Darwin) CLJ_LSP_PLATFORM="macos-${ARCH_NORM}" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
  esac
  CLJ_LSP_URL="https://github.com/clojure-lsp/clojure-lsp/releases/download/${CLJ_LSP_VERSION}/clojure-lsp-native-${CLJ_LSP_PLATFORM}.zip"
  TMP_DIR="$(mktemp -d)"
  curl -fsSL "$CLJ_LSP_URL" -o "$TMP_DIR/clojure-lsp.zip"
  unzip -o "$TMP_DIR/clojure-lsp.zip" -d "$TMP_DIR"
  install -m 755 "$TMP_DIR/clojure-lsp" "$BIN_DIR/clojure-lsp"
  rm -rf "$TMP_DIR"
  echo "clojure-lsp installed: $(clojure-lsp --version 2>&1 | head -1)"
fi
