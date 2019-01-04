#!/usr/bin/env bash

set -e

usage() {
  echo "./install_home_configuration.sh: "
  echo "\tDeploy the configuration files to the home directly."
  echo "Parameters: "
  echo "\t-A|--all : Deploy everything (default mode)"
  echo "\t-a|--alias : Deploy aliases configuration files"
  echo "\t-g|--git : Deploy git configuration files"
  echo "\t-v|--vim : Deploy vim configuration files"
  echo "\t-m|--mc : Deploy MC configuration"
  echo "\t-s|--screen : Deploy screen configuration"
  echo "\t-l|--less : Deploy less configuration"
  echo "\t-i|--idea : Deploy idea configuration"
  echo "\t-r|--reload : Reload the aliases after the deployment (if sourced)"
  echo "\t-h|--help : Show this usage"
}

# ================================== Main ==================================

INSTALL_ALL="YES"
INSTALL_GIT="NO"
INSTALL_ALIASES="NO"
INSTALL_MC="NO"
INSTALL_VIM="NO"
INSTALL_SCREEN="NO"
INSTALL_LESS="NO"
INSTALL_IDEA="NO"
RELOAD="NO"

POSITIONAL=();
while [[ $# -gt 0 ]]; do
    case ${1} in
        -A|--all) INSTALL_ALL="YES";;
        -a|--alias) INSTALL_ALL="NO"; INSTALL_ALIASES="YES";;
        -m|--mc) INSTALL_ALL="NO"; INSTALL_MC="YES";;
        -v|--vim) INSTALL_ALL="NO"; INSTALL_VIM="YES";;
        -g|--git) INSTALL_ALL="NO"; INSTALL_GIT="YES";;
        -s|--screen) INSTALL_ALL="NO"; INSTALL_SCREEN="YES";;
        -l|--less) INSTALL_ALL="NO"; INSTALL_LESS="YES";;
        -i|--idea) INSTALL_ALL="NO"; INSTALL_IDEA="YES";;
        -r|--reload) RELOAD="YES";;
        -h|--help) usage; exit 0;;
        *) usage; exit 1;;
    esac
    shift
done
set -- "${POSITIONAL[@]}"

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_ALIASES} == "YES" ]]; then
  echo "Deploy aliases..."
  rm -rf ~/.aliases
  mkdir -p ~/.aliases
  cp -R aliases-configuration/* ~/.aliases/

  if [[ ${RELOAD} == "YES" ]]; then
    echo "Reloading..."
    source ~/.aliases/load.sh
  fi

  echo "Aliases deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_GIT} == "YES" ]]; then
  echo "Deploy gitconfig..."
  rm -rf ~/.config/git/
  mkdir -p ~/.config/git/hooks
  cp git-configuration/gitignore ~/.config/git/gitignore
  cp -R git-configuration/hooks/* ~/.config/git/hooks/
  cp git-configuration/gitconfig ~/.gitconfig
  echo "Gitconfig deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_MC} == "YES" ]]; then
  echo "Deploy mc config..."
  mkdir -p ~/.config/mc
  cp mc-configuration/ini ~/.config/mc/ini
  echo "Mc config deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_VIM} == "YES" ]]; then
  echo "Deploy vimrc..."
  mkdir -p ~/.vim_runtime
  cp -R vim-configuration/* ~/.vim_runtime/
  sh ~/.vim_runtime/install_awesome_vimrc.sh
  echo "Vim configuration deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_SCREEN} == "YES" ]]; then
  echo "Deploy screenrc..."
  cp screen-configuration/screenrc ~/.screenrc
  echo "screenrc deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_LESS} == "YES" ]]; then
  echo "Deploy less config..."
  cp less-configuration/lesskey ~/.lesskey
  echo "less config deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_IDEA} == "YES" ]]; then
  echo "Deploy idea config..."
  mkdir -p ~/.config/idea
  cp -R idea-configuration/* ~/.config/idea/
  echo "idea config deployed."
fi

echo "Have fun !"

set +e
