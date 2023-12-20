# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export SHELLROOT="$HOME/dotfile/shellrc"

source "$SHELLROOT/history.sh"
source "$SHELLROOT/environment.sh"
# Enable some plugins of zsh installed by kelen
source "$SHELLROOT/zshplugin.zsh"
source "$SHELLROOT/zshsetting.zsh"

[[ ! -f $SHELLROOT/commonplugin.sh ]] || source "$SHELLROOT/commonplugin.sh" 2>/dev/null

# To customize prompt, run `p10k configure` or edit ~/dotfile/shellrc/p10k.zsh.
[[ ! -f $SHELLROOT/p10k.zsh ]] || source "$SHELLROOT/p10k.zsh" 2>/dev/null

## 
[ -f "$SHELLROOT/aliasrc.sh" ] && source "$SHELLROOT/aliasrc.sh"
[ -f "$SHELLROOT/pathrc.sh" ] && source "$SHELLROOT/pathrc.sh"

# Change default editor to vim
export EDITOR='vim'



 if [ -z "$DISPLAY" ]; then
     export LANG=en_US.UTF-8
     export LANGUAGE=zh_CN.UTF-8
 fi
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

