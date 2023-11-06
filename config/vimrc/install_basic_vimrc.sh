#!/bin/sh
set -e

cd ~/.config/vimrc
cat ~/.config/vimrc/vimrcs/basic.vim > ~/.vimrc
echo "Installed the Basic Vim configuration successfully! Enjoy :-)"
