#!/usr/bin/env bash

set -e

usage() {
  echo "./install_home_configuration.sh: "
  echo -e "\tDeploy the configuration files to the home directly."
  echo "Parameters: "
  echo -e "\t-A|--all : Deploy everything (default mode)"
  echo -e "\t-a|--alias : Deploy aliases configuration files"
  echo -e "\t-g|--git : Deploy git configuration files"
  echo -e "\t-v|--vim : Deploy vim configuration files"
  echo -e "\t-m|--mc : Deploy MC configuration"
  echo -e "\t-s|--screen : Deploy screen configuration"
  echo -e "\t-l|--less : Deploy less configuration"
  echo -e "\t-i|--idea : Deploy idea configuration"
  echo -e "\t-c|--completion : Deploy the completion scripts"
  echo -e "\t-G|--glances : Deploy glances configuration"
  echo -e "\t-t|--tmux : Deploy tmux configuration"
  echo -e "\t-B|--bat : Deploy bat configuration"
  echo -e "\t-b|--bashrc : Source the load.sh file in the bashrc if not already done yet"
  echo -e "\t-r|--reload : Reload the aliases after the deployment (if sourced)"
  echo -e "\t-h|--help : Show this usage"
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
INSTALL_GLANCES="NO"
INSTALL_COMPLETION="NO"
INSTALL_TMUX="NO"
INSTALL_BAT="NO"
ADD_BASHRC="NO"
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
        -c|--completion) INSTALL_ALL="NO"; INSTALL_COMPLETION="YES";;
        -G|--glances) INSTALL_ALL="NO"; INSTALL_GLANCES="YES";;
        -t|--tmux) INSTALL_ALL="NO"; INSTALL_TMUX="YES";;
        -B|--bat) INSTALL_ALL="NO"; INSTALL_BAT="YES";;
        -b|--bashrc) ADD_BASHRC="YES";;
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

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_GLANCES} == "YES" ]]; then
  echo "Deploy glances config..."
  mkdir -p ~/.config/glances/
  cp glances-configuration/glances.conf ~/.config/glances/
  echo "glances config deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_COMPLETION} == "YES" ]]; then
  echo "Deploy completion config..."
  rm -rf ~/.config/completion/
  mkdir -p ~/.config/completion/
  cp completion/* ~/.config/completion/
  echo "completion config deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_TMUX} == "YES" ]]; then
  echo "Deploy tmux config..."
  rm -f ~/.tmux.conf
  cp tmux-configuration/tmux.conf ~/.tmux.conf
  echo "tmux config deployed."
fi

if [[ ${INSTALL_ALL} == "YES" ]] || [[ ${INSTALL_BAT} == "YES" ]]; then
  echo "Deploy bat config..."
  mkdir -p ~/.config/bat/
  rm -f ~/.config/bat/config
  cp bat-configuration/config ~/.config/bat/config
  echo "bat config deployed."
fi

if [[ ${ADD_BASHRC} == "YES" ]]; then
    echo "Source the load file in the bashrc file..."
    grep 'source ~/.aliases/load.sh' ~/.bashrc || echo -e "source ~/.aliases/load.sh\n" >> ~/.bashrc
    echo "done."
fi

if [[ ${RELOAD} == "YES" ]]; then
    echo "Reloading..."
    source ~/.aliases/load.sh
    echo "reload."
fi

echo "Have fun !"

set +e
