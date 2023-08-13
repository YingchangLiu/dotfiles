#!/bin/zsh

# Define a function which rename a `target` file to `target.backup` if the file
# exists and if it's a 'real' file, ie not a symlink
backup() {
  target=$1
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking your new $link"
    ln -sf $file $link
  fi
}

# For all files `$name` in the present folder except `*.sh`, `README.md`, `settings.json`,
# and `config`, backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
dotfiles=$(pwd)
for name in ${dotfiles}/*; do
  if [ ! -d "$name" ]; then
      target="$HOME/.`basename $name`"
    if [[ ! "$name" =~ '\.sh$' ]] && [[ ! "$name" =~ 'README.md' ]] && [[ ! "$name" =~ 'settings.json' ]] && [[ ! "$name" =~ 'config' ]] && [[ ! "$name" =~ 'LICENSE' ]]; then
        echo "$name"
        backup $target
        symlink $name $target
    fi
  fi
done




for name in ${dotfiles}/config/*; do

    target="$HOME/.config/"
    #backup $target
    ln -sf $name $target

done
for name in ${dotfiles}/x11/*; do

    target="$HOME/.config/"
    #backup $target
    ln -sf $name $target

done


#ln -sf /run/media/code/linuxcache/.conda $HOME/ 2>/dev/null

