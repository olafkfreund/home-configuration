#!/bin/sh

set -e

SELF=$(basename "$0")

usage() {
  echo "$SELF: "
  echo "\tDeploy the alias files to the home directly"
  exit 0
}

# ================================== Main ==================================

echo "Deploy aliases..."
rm -rf ~/.aliases
mkdir -p ~/.aliases
cp -R aliases-configuration/* ~/.aliases/
echo "Aliases deployed."

echo "Deploy gitconfig..."
mkdir -p ~/.config/git/
cp git-configuration/gitignore ~/.config/git/gitignore
cp git-configuration/gitconfig ~/.gitconfig
echo "Gitconfig deployed."

echo "Deploy mc config..."
mkdir -p ~/.config/mc
cp mc-configuration/ini ~/.config/mc/ini
echo "Mc config deployed."

echo "Deploy vimrc..."
mkdir -p ~/.vim_runtime
cp -R vim-configuration/* ~/.vim_runtime/
sh ~/.vim_runtime/install_awesome_vimrc.sh
echo "Vim configuration deployed."

echo "Have fun !"
