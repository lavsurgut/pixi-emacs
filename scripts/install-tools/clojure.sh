#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$CONDA_PREFIX/bin"

if command -v clojure &>/dev/null; then
  echo "clojure already installed: $(clojure --version 2>&1)"
else
  echo "Installing clojure..."
  CLJ_VERSION="1.12.0.1530"
  CLJ_URL="https://download.clojure.org/install/clojure-tools-${CLJ_VERSION}.tar.gz"
  TMP_DIR="$(mktemp -d)"
  curl -fsSL "$CLJ_URL" -o "$TMP_DIR/clojure-tools.tar.gz"
  tar xzf "$TMP_DIR/clojure-tools.tar.gz" -C "$TMP_DIR"
  cd "$TMP_DIR/clojure-tools"
  # Install into conda prefix instead of system dirs
  PREFIX="$CONDA_PREFIX"
  mkdir -p "$PREFIX/lib/clojure/libexec"
  install -m 644 deps.edn "$PREFIX/lib/clojure/deps.edn"
  install -m 644 exec.jar "$PREFIX/lib/clojure/exec.jar"
  install -m 644 tools.edn "$PREFIX/lib/clojure/tools.edn"
  install -m 644 clojure-tools-${CLJ_VERSION}.jar "$PREFIX/lib/clojure/libexec/clojure-tools-${CLJ_VERSION}.jar"
  sed -i.bak -e "s@PREFIX@$PREFIX/lib/clojure@g" -e "s@BINDIR@$PREFIX/bin@g" clojure
  sed -i.bak -e "s@PREFIX@$PREFIX/lib/clojure@g" -e "s@BINDIR@$PREFIX/bin@g" clj
  install -m 755 clojure "$PREFIX/bin/clojure"
  install -m 755 clj "$PREFIX/bin/clj"
  rm -rf "$TMP_DIR"
  echo "clojure installed: $(clojure --version 2>&1)"
fi
