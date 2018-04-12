#!/bin/sh

set -e

SELF=$(basename "$0")

usage() {
  echo "$SELF: "
  echo "\tDeploy the mc file to the home directly"
  echo
  echo "\tr: Replace the config file if it already exists"
  echo "\th: Show this usage"
  exit 0
}

deploy() {
  echo "Deploying configuration files to home directory.."
  mkdir -p ~/.config/mc
  cp ini ~/.config/mc/ini
  echo "Installed the mc configuration successfully! Have fun"
}

# ================================== Main ==================================

# Init variables
REPLACE="NO"

while getopts ":r" opt; do
  case $opt in
    r) REPLACE="YES";;
    \?) usage;;
  esac
done

if [[ ( -f ~/.config/mc/ini) && "$REPLACE" == "NO" ]]; then
  echo "ERROR : The configuration file already exists. Use -r to replace it."
else
  if [ -f ~/.config/mc/ini ]; then
    echo "WARN : A gitconfig file already exists. It will be replaced."
  fi
  deploy
fi
