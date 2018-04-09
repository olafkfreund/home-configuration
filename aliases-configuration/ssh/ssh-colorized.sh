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

HOSTNAME=$(echo $@ | sed s/.*@//)
CONFIG_FILE="$HOME/.config/alias/ssh-colorized.csv"

if [ -f "$CONFIG_FILE" ]; then
  # Format : regexp_pattern,red,green,blue
  for line in $(cat $CONFIG_FILE | grep -v "^#"); do
    PATTERN=$(echo $line | cut -d',' -f 1)

    if [[ $HOSTNAME =~ $PATTERN ]]; then
      RED=$(echo $line | cut -d',' -f 2 | sed 's/ \t//g')
      GREEN=$(echo $line | cut -d',' -f 3 | sed 's/ \t//g')
      BLUE=$(echo $line | cut -d',' -f 4 | sed 's/ \t//g')

      set_background_color_macos "$RED" "$GREEN" "$BLUE"
      break;
    fi
  done
fi

ssh $@

reset_background_color_macos
