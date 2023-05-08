

# Lines configured by zsh-newuser-install
bindkey -e

# Enable the history-substring-search with Up and Down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Eliminate duplicate entries in history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Sovle 'no matches found' in zsh
setopt no_nomatch
# Rehash for automatically find new executables in the $PATH for example the files I installed in /usr/bin/
zstyle ':completion:*' rehash true
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

# Enable help in zsh
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
