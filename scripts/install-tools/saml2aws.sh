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

if command -v saml2aws &>/dev/null; then
  echo "saml2aws already installed: $(saml2aws --version 2>&1)"
else
  echo "Installing saml2aws..."
  SAML2AWS_VERSION="2.36.19"
  case "$OS" in
    Linux)  SAML2AWS_OS="linux" ;;
    Darwin) SAML2AWS_OS="darwin" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
  esac
  SAML2AWS_URL="https://github.com/Versent/saml2aws/releases/download/v${SAML2AWS_VERSION}/saml2aws_${SAML2AWS_VERSION}_${SAML2AWS_OS}_${ARCH_NORM}.tar.gz"
  TMP_DIR="$(mktemp -d)"
  curl -fsSL "$SAML2AWS_URL" -o "$TMP_DIR/saml2aws.tar.gz"
  tar xzf "$TMP_DIR/saml2aws.tar.gz" -C "$TMP_DIR"
  install -m 755 "$TMP_DIR/saml2aws" "$BIN_DIR/saml2aws"
  rm -rf "$TMP_DIR"
  echo "saml2aws installed: $(saml2aws --version 2>&1)"
fi
