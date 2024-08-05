#!/bin/sh

# Get the current shell
current_shell=$(ps -p $$ -ocomm=)

# Check if the first argument is passed, otherwise set it to 'install'
action=${1:-install}

# Run the appropriate script based on the current shell
case $current_shell in
  *bash)
    echo "Detected bash shell. Running install_bash.sh with argument $action..."
    sh install_bash.sh "$action"
    ;;
  *zsh)
    echo "Detected zsh shell. Running install_bash.sh with argument $action..."
    sh install_bash.sh "$action"
    ;;
  *fish)
    echo "Detected fish shell. Running install_fish.fish with argument $action..."
    fish install_fish.fish "$action"
    ;;
  *)
    echo "Detected unknown shell. Running install_posix.sh with argument $action..."
    sh install_posix.sh "$action"
    ;;
esac