#!/bin/sh

# Color
color_reset='\033[0m'
color_black='\033[0;30m'
color_red='\033[0;31m'
color_green='\033[0;32m'
color_yellow='\033[0;33m'
color_blue='\033[0;34m'
color_purple='\033[0;35m'
color_cyan='\033[0;36m'
color_white='\033[0;37m'

# Define PS1
export PS1="\\[$color_green\\][\\[$color_yellow\\]\u\\[$color_green\\]@\\[$color_purple\\]\h\\[$color_green\\]:\\[$color_blue\\]\w\\[$color_green\\]]\\[$color_reset\\] \\[$color_green\\]\$(get_git_current_branch)\\[$color_reset\\]\n $ "

# Auto correct cd command line
shopt -s cdspell

# Auto check if the window size changes
shopt -s checkwinsize

# Editor
export EDITOR="/usr/bin/vim"

# Pager
export PAGER=most

# History
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups
# Append to the history file instead of overwrite
shopt -s histappend

# Add the current folder in the PATH.
export PATH="${PATH}:.";

# Emulate Linux ls colors on macos
if [[ $(uname -s) == Darwin* ]]; then
  export CLICOLOR=1
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
fi
