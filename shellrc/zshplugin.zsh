# Enable some plugins of zsh installed by kelen
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null
# For Debian
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null
. /etc/zsh_command_not_found 2>/dev/null  # need command-not-found


# You should install "pkgfile" and exec 'sudo pkgfile -u' to use the cnf.zsh.
source /usr/share/autojump/autojump.zsh 2>/dev/null
autoload -Uz compinit
compinit -u
# kitty + complete setup zsh | source /dev/stdin 2>/dev/null
if command -v kitty >/dev/null 2>&1; then
    kitty + complete setup zsh | source /dev/stdin 2>/dev/null
fi

