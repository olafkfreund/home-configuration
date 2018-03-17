#! /bin/sh

# Set the background color to black
reset_background_color_macos () {
    set_background_color_macos 0 0 0
}

# Define a specific background color. Usage : set_background_color_macos RED GREEN BLUE ALPHA
set_background_color_macos () {
  RED=$((${1:-255} * 256 + ${1:-255}))
  GREEN=$((${2:-255} * 256 + ${2:-255}))
  BLUE=$((${3:-255} * 256 + ${3:-255}))
  ALPHA=$((${4:-255} * 256 + ${4:-255}))

  osascript -e "tell application \"Terminal\" to set background color of selected tab of window 1 to {$RED, $GREEN, $BLUE, $ALPHA}"
}

# A custom ssh use to update the background color when on another server.
ssh-colorized() {
  HOSTNAME=`echo $@ | sed s/.*@//`

  case $HOSTNAME in
    *) set_background_color_macos 0 20 0
  esac

  ssh $HOSTNAME

  reset_background_color_macos
}

start_agent() {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

SSH_ENV="$HOME/.ssh/ssh_agent_data"

# Source SSH settings, if needed
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

## Fetch hostname from sshconfig and create an alias to connect to them
if [ -f ~/.ssh/config ]; then
  for name in $(grep -E ^Host ~/.ssh/config | grep -v '*' | grep -v '?' | sed 's/^Host \(.*\)/\1/' | tr ' ' '\n'); do
  	eval alias "$name=\"ssh-colorized $name\""
  done
fi
