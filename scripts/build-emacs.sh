#!/usr/bin/env bash
set -euo pipefail

EMACS_VERSION=30.1
SRC_DIR="$PIXI_PROJECT_ROOT/.emacs-src"

if "$CONDA_PREFIX/bin/emacs" --version &>/dev/null; then
  echo "Emacs already built at $CONDA_PREFIX/bin/emacs"
  "$CONDA_PREFIX/bin/emacs" --version | head -1
  exit 0
fi

if [ ! -d "$SRC_DIR/emacs-$EMACS_VERSION" ]; then
  mkdir -p "$SRC_DIR"
  echo "Downloading Emacs $EMACS_VERSION..."
  curl -L "https://ftp.gnu.org/gnu/emacs/emacs-$EMACS_VERSION.tar.xz" | tar xJ -C "$SRC_DIR"
fi

cd "$SRC_DIR/emacs-$EMACS_VERSION"

# Clean previous failed build if any
make clean 2>/dev/null || true

# Point compiler/linker at conda-forge libs and embed rpath
export CPPFLAGS="-I$CONDA_PREFIX/include"
export LDFLAGS="-L$CONDA_PREFIX/lib -Wl,-rpath,$CONDA_PREFIX/lib"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$CONDA_PREFIX/share/pkgconfig"

echo "Configuring Emacs (terminal-only)..."
./configure \
  --prefix="$CONDA_PREFIX" \
  --without-ns \
  --without-x \
  --without-dbus \
  --with-gnutls \
  --with-xml2 \
  --with-tree-sitter \
  --with-modules \
  --with-json

echo "Building Emacs..."
make -j"$(nproc 2>/dev/null || sysctl -n hw.ncpu)"

echo "Installing Emacs into pixi environment..."
make install

echo "Done!"
"$CONDA_PREFIX/bin/emacs" --version | head -1
