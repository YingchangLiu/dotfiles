#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


export EDITOR='vim'


export SHELLROOT="$HOME/dotfile/shellrc"
[[ ! -f $SHELLROOT/commonplugin.sh ]] || source $SHELLROOT/commonplugin.sh 2>/dev/null
##
source "$SHELLROOT/history.sh"

[ -f "$SHELLROOT/aliasrc.sh" ] && source "$SHELLROOT/aliasrc.sh"
[ -f "$SHELLROOT/pathrc.sh" ] && source "$SHELLROOT/pathrc.sh"

if [ -z "$DISPLAY" ]; then
    export LANG=en_US.UTF-8
    unset LANGUAGE
fi
~
