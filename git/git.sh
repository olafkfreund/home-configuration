#!/bin/sh

get_git_current_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' | sed -e 's/* \(.*\)/ (\1) /'
}
