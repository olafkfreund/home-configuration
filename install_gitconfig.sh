#!/bin/sh

set -e

SELF=$(basename "$0")

usage() {
  echo "$SELF: "
  echo "\tDeploy the gitconfig file to the home directly"
  echo
  echo "Parameters:"
  echo "\tp: Pull from origin before deploying"
  echo "\tr: Replace the gitconfig file if it already exists"
  echo "\th: Show this usage"
  exit 0
}

pull() {
  echo "Pulling changes..."
  git pull
  echo "Pull done."
  echo
}

deploy() {
  echo "Deploying configuration files to home directory.."
  cp gitconfig ~/.gitconfig
  mkdir -p ~/.config/git/
  cp gitignore ~/.config/git/gitignore
  echo "Installed the git configuration successfully! Have fun"
}


# ================================== Main ==================================

# Init variables
PULL="NO"
REPLACE="NO"

while getopts ":pr" opt; do
  case $opt in
    p) PULL="YES";;
    r) REPLACE="YES";;
    \?) usage;;
  esac
done

if [ "$PULL" == "YES" ]; then
  pull
fi

if [[ -f ~/.gitconfig && "$REPLACE" == "NO" ]]; then
  echo "ERROR : The configuration file already exists. Use -r to replace it."
else
  if [ -f ~/.gitconfig ]; then
    echo "WARN : A gitconfig file already exists. It will be replaced."
  fi
  deploy
fi
