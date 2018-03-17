#!/bin/sh

FOLDER=$(dirname "$BASH_SOURCE")

source "$FOLDER/git/git.sh"

source "$FOLDER/ssh/ssh.sh"
source "$FOLDER/ssh/start-agent.sh"

source "$FOLDER/aliases.sh"
source "$FOLDER/variables.sh"
