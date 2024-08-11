# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export DOTROOT="/home/kelen/dotfile"
export SHELLROOT="${DOTROOT}/shellrc"
# 开始时间
start_time=$(date +%s%N)

# 记录时间函数
log_time() {
  local end_time=$(date +%s%N)
  local elapsed=$(( (end_time - start_time) / 1000000 )) # 转换为毫秒
  echo "Time elapsed: ${elapsed} ms - $1"
  start_time=$end_time
}
# environment
log_time "Start environment variables"

[[ ! -f $SHELLROOT/history.sh ]] || source "$SHELLROOT/history.sh" #2>/dev/null
[[ ! -f $SHELLROOT/environment.sh ]] || source "$SHELLROOT/environment.sh" #2>/dev/null
log_time "Start environment variables"

# Load functions
[[ ! -f $SHELLROOT/functions.sh ]] || source "$SHELLROOT/functions.sh" #2>/dev/null
log_time "functions"

# Load common plugin
[[ ! -f $SHELLROOT/commonplugin.sh ]] || source "$SHELLROOT/commonplugin.sh" #2>/dev/null
log_time "commonplugin"
# To customize prompt, run `p10k configure` or edit ~/dotfile/shellrc/p10k.zsh.
[[ ! -f $SHELLROOT/p10k.zsh ]] || source "$SHELLROOT/p10k.zsh" #2>/dev/null
log_time "p10k"
# Enable some plugins of zsh installed by kelen
[[ ! -f $SHELLROOT/zshplugin.zsh ]] || source "$SHELLROOT/zshplugin.zsh" #2>/dev/null
log_time "zshplugin"
[[ ! -f $SHELLROOT/zshsetting.zsh ]] || source "$SHELLROOT/zshsetting.zsh" #2>/dev/null
log_time "zshsetting"
# Load other shellrc
[ -f "$SHELLROOT/alias.sh" ] && source "$SHELLROOT/alias.sh" #2>/dev/null
log_time "alias"
[ -f "$SHELLROOT/path.sh" ] && source "$SHELLROOT/path.sh" #2>/dev/null
log_time "path"
[ -f "$SHELLROOT/language.sh" ] && source "$SHELLROOT/language.sh"  #2>/dev/null
log_time "language"
[ -f "$SHELLROOT/custom.sh" ] && source "$SHELLROOT/custom.sh"  #2>/dev/null


# Change default editor to vim
export EDITOR='vim'

