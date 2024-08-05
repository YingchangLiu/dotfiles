#!/usr/bin/env bash

# Create directories if they don't exist
create_directories() {
  local readonly dirs=(
    "$HOME/.fonts"
    "$HOME/.icons"
    "$HOME/.themes"
    "$HOME/.config"
    "$HOME/.local/share"
    "$HOME/.vscode"
  )
  for dir in "${dirs[@]}"; do
    [[ ! -d "$dir" ]] && mkdir -p "$dir"
  done
}

# Rename a target file to target.backup if the file exists and is not a symlink
backup() {
  local target=$1
  if [[ -e "$target" && ! -L "$target" ]]; then
    mv "$target" "$target.backup"
    echo "-----> Moved your old $target config file to $target.backup"
  fi
}

# Create a symlink if it doesn't exist
symlink() {
  local file=$1
  local link=$2
  if [[ ! -e "$link" ]]; then
    echo "-----> Symlinking your new $link"
    ln -sf "$file" "$link"
  fi
}

# Remove a symlink and restore a backup if it exists
remove_symlink() {
  local link=$1
  local target=$2
  if [[ -L "$link" && "$(readlink "$link")" == "$target" ]]; then
    rm "$link"
    echo "-----> Removed symlink $link"
    if [[ -e "$link.backup" ]]; then
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
  local src_dir=$1
  local dest_dir=$2
  for name in "$src_dir"/*; do
    local target="$dest_dir/$(basename "$name")"
    remove_symlink "$target" "$name"
  done
}

# Fallback to POSIX script if the current script fails
fallback_to_posix() {
  echo "-----> Operation failed, falling back to POSIX script"
  sh shellrc/install_posix.sh "$1"
}

install() {
  create_directories

  # Get the absolute path of the current script directory
  local readonly dotfiles
  if [[ -n "$BASH_SOURCE" ]]; then
    dotfiles=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
  elif [[ -n "$ZSH_VERSION" ]]; then
    dotfiles=$(cd "$(dirname "${(%):-%N}")/.." && pwd)
  else
    echo "Unsupported shell. Let's try POSIX script."
    exit 1
  fi

  local readonly exclude_files="(\.sh$|README\.md$|settings\.json$|config$|LICENSE$)"
  
  # For all files in the current folder except `*.sh`, `README.md`, `settings.json`, `config`, and `LICENSE`,
  # backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
  for name in "$dotfiles"/*; do
    if [[ ! -d "$name" ]]; then
      local target="$HOME/.`basename $name`"
      if ! echo "$(basename "$name")" | grep -E "$exclude_files" > /dev/null; then
        echo "-----> Processing $name"
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
  if [[ -d "$dotfiles/config/vim_runtime" ]]; then
    symlink "$dotfiles/config/vim_runtime" "$HOME/.vim_runtime"
  fi

  # Symlink vscode/argv.json for gnome-keyring
  symlink "$dotfiles/config/vscode/argv.json" "$HOME/.vscode/argv.json"
}

uninstall() {
  local readonly dotfiles
  if [[ -n "$BASH_SOURCE" ]]; then
    dotfiles=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
  elif [[ -n "$ZSH_VERSION" ]]; then
    dotfiles=$(cd "$(dirname "${(%):-%N}")/.." && pwd)
  else
    echo "Unsupported shell. Let's try POSIX script."
    exit 1
  fi

  local readonly exclude_files="(\.sh$|README\.md$|settings\.json$|config$|LICENSE$)"
  
  # Remove symlinks for all files in the current folder except `*.sh`, `README.md`, `settings.json`, `config`, and `LICENSE`
  for name in "$dotfiles"/*; do
    if [[ ! -d "$name" ]]; then
      local target="$HOME/.`basename $name`"
      if ! echo "$(basename "$name")" | grep -E "$exclude_files" > /dev/null; then
        remove_symlink "$target" "$name"
      fi
    fi
  done

  # Remove symlinks for fonts, icons, themes, config, and local/share directories
  unlink_files "$dotfiles/fonts" "$HOME/.fonts"
  unlink_files "$dotfiles/icons" "$HOME/.icons"
  unlink_files "$dotfiles/themes" "$HOME/.themes"
  unlink_files "$dotfiles/config" "$HOME/.config"
  unlink_files "$dotfiles/local/share" "$HOME/.local/share"

  # Remove vim_runtime symlink
  remove_symlink "$HOME/.vim_runtime" "$dotfiles/config/vim_runtime"

  # Remove vscode/argv.json symlink
  remove_symlink "$HOME/.vscode/argv.json" "$dotfiles/config/vscode/argv.json"
}

# Check command line arguments
case "$1" in
  install|"")
    install || fallback_to_posix install
    ;;
  uninstall)
    uninstall || fallback_to_posix uninstall
    ;;
  *)
    echo "Usage: $0 {install|uninstall}"
    ;;
esac