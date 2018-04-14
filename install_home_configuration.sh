#!/bin/sh

set -e

SELF=$(basename "$0")

usage() {
  echo "$SELF: "
  echo "\tDeploy the configuration files to the home directly."
  echo "Parameters: "
  echo "\t-A : Deploy everything (default mode)"
  echo "\t-a : Deploy aliases configuration files"
  echo "\t-g : Deploy git configuration files"
  echo "\t-v : Deploy vim configuration files"
  echo "\t-m : Deploy MC configuration"
  echo "\t-r : Reload the aliases after the deployment"
  echo "\t-h : Show this usage"
}

# ================================== Main ==================================

INSTALL_ALL="YES"
INSTALL_GIT="NO"
INSTALL_ALIASES="NO"
INSTALL_MC="NO"
INSTALL_VIM="NO"
RELOAD="NO"

while getopts "Agvamhr" option; do
  case $option in
    A) INSTALL_ALL="YES";;
    a) INSTALL_ALL="NO"; INSTALL_ALIASES="YES";;
    m) INSTALL_ALL="NO"; INSTALL_MC="YES";;
    v) INSTALL_ALL="NO"; INSTALL_VIM="YES";;
    g) INSTALL_ALL="NO"; INSTALL_GIT="YES";;
    r) RELOAD="YES";;
    h) usage; exit 0;;
    *) usage; exit 1;;
  esac
done

if [ $INSTALL_ALL == "YES" ] || [ $INSTALL_ALIASES == "YES" ]; then
  echo "Deploy aliases..."
  rm -rf ~/.aliases
  mkdir -p ~/.aliases
  cp -R aliases-configuration/* ~/.aliases/

  if [ $RELOAD == "YES" ]; then
    echo "Reloading..."
    source ~/.aliases/load.sh
  fi

  echo "Aliases deployed."
fi

if [ $INSTALL_ALL == "YES" ] || [ $INSTALL_GIT == "YES" ]; then
  echo "Deploy gitconfig..."
  mkdir -p ~/.config/git/
  cp git-configuration/gitignore ~/.config/git/gitignore
  cp git-configuration/gitconfig ~/.gitconfig
  echo "Gitconfig deployed."
fi

if [ $INSTALL_ALL == "YES" ] || [ $INSTALL_MC == "YES" ]; then
  echo "Deploy mc config..."
  mkdir -p ~/.config/mc
  cp mc-configuration/ini ~/.config/mc/ini
  echo "Mc config deployed."
fi

if [ $INSTALL_ALL == "YES" ] || [ $INSTALL_VIM == "YES" ]; then
  echo "Deploy vimrc..."
  mkdir -p ~/.vim_runtime
  cp -R vim-configuration/* ~/.vim_runtime/
  sh ~/.vim_runtime/install_awesome_vimrc.sh
  echo "Vim configuration deployed."
fi

echo "Have fun !"
