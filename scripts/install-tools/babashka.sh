#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$CONDA_PREFIX/bin"

OS="$(uname -s)"
ARCH="$(uname -m)"

if command -v bb &>/dev/null; then
  echo "babashka already installed: $(bb --version)"
else
  echo "Installing babashka..."
  BB_VERSION="1.12.214"
  case "$OS" in
    Linux)  BB_PLATFORM="linux"; BB_EXT="tar.gz" ;;
    Darwin) BB_PLATFORM="macos"; BB_EXT="tar.gz" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
  esac
  case "$ARCH" in
    x86_64)        BB_ARCH="amd64" ;;
    aarch64|arm64) BB_ARCH="aarch64" ;;
  esac
  BB_URL="https://github.com/babashka/babashka/releases/download/v${BB_VERSION}/babashka-${BB_VERSION}-${BB_PLATFORM}-${BB_ARCH}.${BB_EXT}"
  TMP_DIR="$(mktemp -d)"
  curl -fsSL "$BB_URL" -o "$TMP_DIR/bb.tar.gz"
  tar xzf "$TMP_DIR/bb.tar.gz" -C "$TMP_DIR"
  install -m 755 "$TMP_DIR/bb" "$BIN_DIR/bb"
  rm -rf "$TMP_DIR"
  echo "babashka installed: $(bb --version)"
fi
