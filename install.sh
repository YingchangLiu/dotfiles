#!/usr/bin/env bash

# Create directories if they don't exist
create_directories() {
  local dirs=(
    "$HOME/.fonts"
    "$HOME/.icons"
    "$HOME/.themes"
    "$HOME/.config"
    "$HOME/.local/share"
    "$HOME/.vscode"
  )
  for dir in "${dirs[@]}"; do
    [ ! -d "$dir" ] && mkdir -p "$dir"
  done
}

# Rename a `target` file to `target.backup` if the file exists and if it's a 'real' file, ie not a symlink
backup() {
  local target=$1
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.backup"
    echo "-----> Moved your old $target config file to $target.backup"
  fi
}

# Create a symlink if it doesn't exist
symlink() {
  local file=$1
  local link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking your new $link"
    ln -sf "$file" "$link"
  fi
}

# Remove a symlink and restore a backup if it exists
remove_symlink() {
  local link=$1
  if [ -L "$link" ]; then
    rm "$link"
    echo "-----> Removed symlink $link"
    if [ -e "$link.backup" ]; then
      mv "$link.backup" "$link"
      echo "-----> Restored backup $link"
    fi
  fi
}

# Process files in a directory
link_files() {
  local src_dir=$1
  local dest_dir=$2
  for name in "$src_dir"/*; do
    local target="$dest_dir/$(basename "$name")"
    symlink "$name" "$target"
  done
}
# Remove symlinks in a directory
unlink_files() {
  local dest_dir=$1
  for name in "$dest_dir"/*; do
    remove_symlink "$name"
  done
}

install() {
  create_directories

  # For all files in the present folder except `*.sh`, `README.md`, `settings.json`, `config`, and `LICENSE`,
  # backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
  dotfiles=$(pwd)
  exclude_files="(\.sh$|README.md|settings.json|config|LICENSE)"
  for name in "$dotfiles"/*; do
    if [ ! -d "$name" ]; then
      target="$HOME/.`basename $name`"
      if [[ ! "$name" =~ $exclude_files ]]; then
        echo "$name"
        backup "$target"
        symlink "$name" "$target"
      fi
    fi
  done

  # Symlink fonts, icons, themes, config, and local/share directories
  link_files "$dotfiles/fonts" "$HOME/.fonts"
  link_files "$dotfiles/icons" "$HOME/.icons"
  link_files "$dotfiles/themes" "$HOME/.themes"
  link_files "$dotfiles/config" "$HOME/.config"
  link_files "$dotfiles/local/share" "$HOME/.local/share"

  # Special case for vim_runtime
  if [ -d "$dotfiles/config/vim_runtime" ]; then
    symlink "$dotfiles/config/vim_runtime" "$HOME/.vim_runtime"
  fi

  # Symlink vscode/argv.json for gnome-keyring
  symlink "$dotfiles/config/vscode/argv.json" "$HOME/.vscode/argv.json"
}

uninstall() {
  dotfiles=$(pwd)
  exclude_files="(\.sh$|README.md|settings.json|config|LICENSE)"
  for name in "$dotfiles"/*; do
    if [ ! -d "$name" ]; then
      target="$HOME/.`basename $name`"
      if [[ ! "$name" =~ $exclude_files ]]; then
        remove_symlink "$target"
      fi
    fi
  done

  # Remove symlinks for fonts, icons, themes, config, and local/share directories
  unlink_files "$HOME/.fonts"
  unlink_files "$HOME/.icons"
  unlink_files "$HOME/.themes"
  unlink_files "$HOME/.config"
  unlink_files "$HOME/.local/share"

  # remove vim_runtime
  remove_symlink "$HOME/.vim_runtime"

  # Remove vscode/argv.json symlink
  remove_symlink "$HOME/.vscode/argv.json"
}

# Check if the first argument is 'install' or 'uninstall'
case "$1" in
  install|"")
    install
    ;;
  uninstall)
    uninstall
    ;;
  *)
    echo "Usage: $0 {install|uninstall}"
    ;;
esac