#!/bin/sh

ALIAS_FOLDER="$HOME/.aliases/"

source "$ALIAS_FOLDER/git/git.sh"
source "$ALIAS_FOLDER/screen/screen.sh"
source "$ALIAS_FOLDER/borg/borg-aliases.bash"

source "$ALIAS_FOLDER/ssh/start-agent.sh"

source "$ALIAS_FOLDER/aliases.sh"
source "$ALIAS_FOLDER/variables.sh"

source ~/.config/completion/*.completion.bash
