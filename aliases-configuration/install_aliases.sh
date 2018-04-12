#!/bin/sh

set -e

SELF=$(basename "$0")

usage() {
  echo "$SELF: "
  echo "\tDeploy the alias files to the home directly"
  echo
  echo "Parameters:"
  echo "\tr: Replace the gitconfig file if it already exists"
  echo "\th: Show this usage"
  exit 0
}

deploy() {
  echo "Deploying configuration files to ~/.aliases..."
  rm -rf ~/.aliases
  mkdir -p ~/.aliases
  cp -R * ~/.aliases
  echo "Installed the aliases successfully! Have fun"
}

# ================================== Main ==================================

deploy
