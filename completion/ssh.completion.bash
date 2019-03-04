#!/usr/bin/env bash

## SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

## SSH auto-completion based on entries in config.
if [[ -e ~/.ssh/config ]]; then
  complete -W "$(grep -E ^Host ~/.ssh/config | grep -v '*' | grep -v '?' | sed 's/^Host \(.*\)/\1/' | tr ' ' '\n')" ssh
fi