_DISTRO=$(get_distro)
_autocomplete=false
case $_DISTRO in
    *Arch*|*arch*)
    [ -z "$_LOADED_ZSH_P10K" ]                      && source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null                                    && _LOADED_ZSH_P10K=1
    [ -z "$_LOADED_ZSH_AUTOSUGGESTIONS" ]           && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null                            && _LOADED_ZSH_AUTOSUGGESTIONS=1
    [ -z "$_LOADED_ZSH_AUTOCOMPLETE" ]              && source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2>/dev/null                           && _LOADED_ZSH_AUTOCOMPLETE=1
    [ -z "$_LOADED_ZSH_SYNTAX_HIGHLIGHTING" ]       && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null                    && _LOADED_ZSH_SYNTAX_HIGHLIGHTING=1
    [ -z "$_LOADED_ZSH_HISTORY_SUBSTRING_SEARCH" ]  && source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null          && _LOADED_ZSH_HISTORY_SUBSTRING_SEARCH=1
    [ -z "$_LOADED_ZSH_COMMAND_NOT_FOUND" ]         && source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null                                                  && _LOADED_ZSH_COMMAND_NOT_FOUND=1
    # You should install "pkgfile" and exec 'sudo pkgfile -u' in archlinux or "command-not-found" in debian to use the script.
    ;;
    *Debian*|*debian*)
    [ -z "$_LOADED_ZSH_P10K" ]                      && source $HOME/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null                          && _LOADED_ZSH_P10K=1
    [ -Z "$_LOADED_ZSH_AUTOSUGGESTIONS" ]           && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null                                        && _LOADED_ZSH_AUTOSUGGESTIONS=1
    [ -z "$_LOADED_ZSH_AUTOCOMPLETE" ]              && source $HOME/.local/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2>/dev/null                   && _LOADED_ZSH_AUTOCOMPLETE=1
    [ -z "$_LOADED_ZSH_SYNTAX_HIGHLIGHTING" ]       && source $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null            && _LOADED_ZSH_SYNTAX_HIGHLIGHTING=1
    [ -z "$_LOADED_ZSH_HISTORY_SUBSTRING_SEARCH" ]  && source $HOME/.local/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null  && _LOADED_ZSH_HISTORY_SUBSTRING_SEARCH=1
    [ -z "$_LOADED_ZSH_COMMAND_NOT_FOUND" ]         && . /etc/zsh_command_not_found 2>/dev/null                                                                         && _LOADED_ZSH_COMMAND_NOT_FOUND=1 # need command-not-found
    ;;
    *Gentoo*|*gentoo*)
    [ -z "$_LOADED_ZSH_P10K" ]                      && source /usr/share/zsh/site-functions/powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null                           && _LOADED_ZSH_P10K=1
    [ -z "$_LOADED_ZSH_AUTOSUGGESTIONS" ]           && source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh 2>/dev/null                                         && _LOADED_ZSH_AUTOSUGGESTIONS=1
    [ -z "$_LOADED_ZSH_AUTOCOMPLETE" ]              && source /usr/share/zsh/site-functions/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2>/dev/null                    && _LOADED_ZSH_AUTOCOMPLETE=1
    [ -z "$_LOADED_ZSH_SYNTAX_HIGHLIGHTING" ]       && source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null                                     && _LOADED_ZSH_SYNTAX_HIGHLIGHTING=1
    [ -z "$_LOADED_ZSH_HISTORY_SUBSTRING_SEARCH" ]  && source /usr/share/zsh/site-functions/zsh-history-substring-search.zsh 2>/dev/null                                && _LOADED_ZSH_HISTORY_SUBSTRING_SEARCH=1
    ;;
# else
#     echo "This is not Arch Linux / Debian or Gentoo. You need fix the plugin path for your distrobution."
esac


[ -z "$_LOADED_ZSH_AUTOJUMP" ] && source /usr/share/autojump/autojump.zsh 2>/dev/null && _LOADED_ZSH_AUTOJUMP=1

# kitty + complete setup zsh | source /dev/stdin 2>/dev/null
autoload -Uz __kitty_complete
