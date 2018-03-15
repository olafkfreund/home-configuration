# MIT License

# Copyright (c) 2018 Florent Clarret

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
