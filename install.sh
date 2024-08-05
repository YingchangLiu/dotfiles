#!/bin/sh

# Get the current shell
current_shell=$(ps -p $$ -ocomm=)

# Check if the first argument is passed, otherwise set it to 'install'
action=${1:-install}

# 获取当前脚本所在的目录
script_dir=$(dirname "$0")

# Run the appropriate script based on the current shell
case $current_shell in
  *bash|*zsh)
    echo "Detected $current_shell shell. Running install_bash.sh with argument $action..."
    $current_shell "$script_dir/shellrc/install_bash.sh" "$action"
    ;;
  *)
    echo "Detected $current_shell shell. Running install_posix.sh with argument $action..."
    $current_shell "$script_dir/shellrc/install_posix.sh" "$action"
    ;;
esac