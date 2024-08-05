#!/usr/bin/env fish

# Create directories if they don't exist
function create_directories
  set -l dirs \
    "$HOME/.fonts" \
    "$HOME/.icons" \
    "$HOME/.themes" \
    "$HOME/.config" \
    "$HOME/.local/share" \
    "$HOME/.vscode"
  
  for dir in $dirs
    if not test -d $dir
      mkdir -p $dir
    end
  end
end

# Rename a target file to target.backup if the file exists and is not a symlink
function backup
  set -l target $argv[1]
  if test -e $target -a ! -L $target
    mv $target $target.backup
    echo "-----> Moved your old $target config file to $target.backup"
  end
end

# Create a symlink if it doesn't exist
function symlink
  set -l file $argv[1]
  set -l link $argv[2]
  if not test -e $link
    echo "-----> Symlinking your new $link"
    ln -sf $file $link
  end
end

# Remove a symlink and restore a backup if it exists
function remove_symlink
  set -l link $argv[1]
  set -l target $argv[2]
  if test -L $link -a (readlink $link) = $target
    rm $link
    echo "-----> Removed symlink $link"
    if test -e $link.backup
      mv $link.backup $link
      echo "-----> Restored backup $link"
    end
  end
end

# Process files in a directory
function link_files
  set -l src_dir $argv[1]
  set -l dest_dir $argv[2]
  for name in $src_dir/*
    set -l target "$dest_dir/(basename $name)"
    symlink $name $target
  end
end

# Remove symlinks in a directory
function unlink_files
  set -l src_dir $argv[1]
  set -l dest_dir $argv[2]
  for name in $src_dir/*
    set -l target "$dest_dir/(basename $name)"
    remove_symlink $target $name
  end
end

function install
  create_directories

  # Get the absolute path of the current script directory
  set -l dotfiles (cd (dirname (status -f))/..; pwd)

  set -l exclude_files "(\.sh$|README\.md$|settings\.json$|config$|LICENSE$)"
  
  # For all files in the current folder except `*.sh`, `README.md`, `settings.json`, `config`, and `LICENSE`,
  # backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
  for name in $dotfiles/*
    if not test -d $name
      set -l target "$HOME/.(basename $name)"
      if not echo (basename $name) | grep -E $exclude_files > /dev/null
        echo "-----> Processing $name"
        backup $target
        symlink $name $target
      end
    end
  end

  # Symlink fonts, icons, themes, config, and local/share directories
  link_files "$dotfiles/fonts" "$HOME/.fonts"
  link_files "$dotfiles/icons" "$HOME/.icons"
  link_files "$dotfiles/themes" "$HOME/.themes"
  link_files "$dotfiles/config" "$HOME/.config"
  link_files "$dotfiles/local/share" "$HOME/.local/share"

  # Special case for vim_runtime
  if test -d "$dotfiles/config/vim_runtime"
    symlink "$dotfiles/config/vim_runtime" "$HOME/.vim_runtime"
  end

  # Symlink vscode/argv.json for gnome-keyring
  symlink "$dotfiles/config/vscode/argv.json" "$HOME/.vscode/argv.json"
end

function uninstall
  set -l dotfiles (cd (dirname (status -f))/..; pwd)

  set -l exclude_files "(\.sh$|README\.md$|settings\.json$|config$|LICENSE$)"
  
  # Remove symlinks for all files in the current folder except `*.sh`, `README.md`, `settings.json`, `config`, and `LICENSE`
  for name in $dotfiles/*
    if not test -d $name
      set -l target "$HOME/.(basename $name)"
      if not echo (basename $name) | grep -E $exclude_files > /dev/null
        remove_symlink $target $name
      end
    end
  end

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
end

# Check command line arguments
switch $argv[1]
  case install ''
    install
  case uninstall
    uninstall
  case '*'
    echo "Usage: $0 {install|uninstall}"
end