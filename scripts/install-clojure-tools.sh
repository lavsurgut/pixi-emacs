#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$CONDA_PREFIX/bin"

OS="$(uname -s)"
ARCH="$(uname -m)"

# Normalize arch
case "$ARCH" in
  x86_64)  ARCH_NORM="amd64" ;;
  aarch64|arm64) ARCH_NORM="aarch64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# --- clojure-lsp ---
if command -v clojure-lsp &>/dev/null; then
  echo "clojure-lsp already installed: $(clojure-lsp --version 2>&1 | head -1)"
else
  echo "Installing clojure-lsp..."
  CLJ_LSP_VERSION="2025.01.22-23.28.01"
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

# --- babashka ---
if command -v bb &>/dev/null; then
  echo "babashka already installed: $(bb --version)"
else
  echo "Installing babashka..."
  BB_VERSION="1.12.196"
  case "$OS" in
    Linux)  BB_PLATFORM="linux"; BB_EXT="tar.gz" ;;
    Darwin) BB_PLATFORM="macos"; BB_EXT="tar.gz" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
  esac
  case "$ARCH" in
    x86_64)       BB_ARCH="amd64" ;;
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

# --- clojure (macOS only — linux gets it from conda-forge) ---
if [ "$OS" = "Darwin" ]; then
  if command -v clojure &>/dev/null; then
    echo "clojure already installed: $(clojure --version 2>&1)"
  else
    echo "Installing clojure (macOS)..."
    CLJ_VERSION="1.12.0.1530"
    CLJ_URL="https://download.clojure.org/install/clojure-tools-${CLJ_VERSION}.tar.gz"
    TMP_DIR="$(mktemp -d)"
    curl -fsSL "$CLJ_URL" -o "$TMP_DIR/clojure-tools.tar.gz"
    tar xzf "$TMP_DIR/clojure-tools.tar.gz" -C "$TMP_DIR"
    cd "$TMP_DIR/clojure-tools"
    # Install into conda prefix instead of system dirs
    PREFIX="$CONDA_PREFIX"
    mkdir -p "$PREFIX/lib/clojure"
    install -m 644 deps.edn "$PREFIX/lib/clojure/deps.edn"
    install -m 644 exec.jar "$PREFIX/lib/clojure/exec.jar"
    install -m 644 tools.edn "$PREFIX/lib/clojure/tools.edn"
    install -m 644 clojure-tools-${CLJ_VERSION}.jar "$PREFIX/lib/clojure/libexec/clojure-tools-${CLJ_VERSION}.jar" 2>/dev/null || {
      mkdir -p "$PREFIX/lib/clojure/libexec"
      install -m 644 clojure-tools-${CLJ_VERSION}.jar "$PREFIX/lib/clojure/libexec/clojure-tools-${CLJ_VERSION}.jar"
    }
    sed -i.bak -e "s@PREFIX@$PREFIX/lib/clojure@g" -e "s@BINDIR@$PREFIX/bin@g" clojure
    sed -i.bak -e "s@PREFIX@$PREFIX/lib/clojure@g" -e "s@BINDIR@$PREFIX/bin@g" clj
    install -m 755 clojure "$PREFIX/bin/clojure"
    install -m 755 clj "$PREFIX/bin/clj"
    rm -rf "$TMP_DIR"
    echo "clojure installed: $(clojure --version 2>&1)"
  fi
fi

echo "All Clojure tools installed successfully."
