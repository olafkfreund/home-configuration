#!/bin/sh

# ls
alias ll="ls -alh";
alias lm="ls -altrh";

# df
alias df="df -h"

# du
alias du="du -h"

# history
alias hi="history | tail -20"

# cd
alias ..='cd ../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# time
alias now='date +"%T"'
alias today='date +"%d-%m-%Y"'

# path
alias path='echo -e ${PATH//:/\\n}'

# source
alias src='source'

# tail
alias tf="tail -f"
