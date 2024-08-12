autoload -Uz add-zsh-hook

## Enable help in zsh
(( ${+aliases[run-help]} )) && unalias run-help
autoload -Uz run-help
alias help='run-help '
## HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"
# autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn



autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line


# REMEMBERING RECENT DIRECTORIES
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
## Eliminate duplicate entries in history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
## Sovle 'no matches found' in zsh
setopt no_nomatch
## enable auto-correction
setopt correctall
## Auto cd
setopt autocd
## Enable extended globbing
setopt extendedglob
# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv
# zargs, as an alternative to find -exec and xargs.
autoload -U zargs
# Turn on command substitution in the prompt (and parameter expansion and arithmetic expansion).
setopt promptsubst

# Keep history of `cd` as in with `pushd` and make `cd -<TAB>` work.
DIRSTACKSIZE=16
setopt auto_pushd pushd_silent pushd_to_home
## Remove duplicate entries
setopt pushd_ignore_dups
## This reverts the +/- operators.
setopt pushd_minus
# Ignore lines prefixed with '#'.
setopt interactivecomments


autoload -Uz compinit promptinit
compinit -u
promptinit

# Lines configured by zsh-newuser-install
bindkey -e

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
bindkey '^x^e' edit-command-line  # Ctrl+x Ctrl+e to open current line in $EDITOR

# Enable the history-substring-search with Up and Down
bindkey '^[[A' history-substring-search-up    # Up Arrow to search history
bindkey '^[[B' history-substring-search-down  # Down Arrow to search history

## Only if the zsh-autocomplete plugin is enabled in zshplugin.zsh, you can use the following key bindings.
if [ -n "$_LOADED_ZSH_AUTOCOMPLETE" ]; then
  bindkey '^I' menu-select  # Tab to select completion
  bindkey "$terminfo[kcbt]" menu-select # Shift+Tab to select completion
fi

# bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
# bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char
bindkey '^R' .history-incremental-search-backward # Ctrl+r to search history
bindkey '^S' .history-incremental-search-forward  # Ctrl+s to search history


# bindkey "^[[H" beginning-of-line #Home key to go to beginning of line
# bindkey "^[[4~" end-of-line #End key to go to end of line
# bindkey "^[[P" delete-char #Del key to delete character
# bindkey "^[[A" history-beginning-search-backward #Up Arrow to search history
# bindkey "^[[B" history-beginning-search-forward #Down Arrow to search history
# bindkey "^[[1;5C" forward-word # control + right arrow to move forward word
# bindkey "^[[1;5D" backward-word # control + left arrow to move backward word
# bindkey "^H" backward-kill-word # control + backspace to delete word
# bindkey "^[[M" kill-word # control + delete to delete word

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-beginning-search
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-beginning-search
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         history-beginning-search-backward
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       history-beginning-search-forward
# [[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
# [[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
# [[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-word
# [[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-word
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
# [[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete



# Rehash for automatically find new executables in the $PATH for example the files I installed in /usr/bin/
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate

# Enable autocompletion of privileged environment in privileged environment
zstyle ':completion::complete:*' gain-privileges 1
# Enable autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

## First insert the common substring
# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

# When inserting a completion, a space is added after certain types of completions.
zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands

# Note: -e lets you specify a dynamically generated value.
# Override default for all listings
# $LINES is the number of lines that fit on screen.
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

# Override for recent path search only
zstyle ':autocomplete:recent-paths:*' list-lines 10

# Override for history search only
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8

# Override for history menu only
zstyle ':autocomplete:history-search-backward:*' list-lines 2000
