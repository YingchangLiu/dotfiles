# P10k only for zsh. Starship for bash and zsh.
# You can add your own themes here.
# https://github.com/ohmybash/oh-my-bash/blob/master/themes/THEMES.md
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes


#_ZSH_THEME="p10k"
_ZSH_THEME="starship"
_BASH_THEME="starship"


_SHELL_THEMES=("p10k" "starship")

if [[ ! "${_SHELL_THEMES[@]}" =~ "$_SHELL_THEME" ]]; then
    _SHELL_THEME="none"
fi



_DISTRO=$(get_distro)
# 检测当前 shell
_CURRENT_SHELL=$(ps -p $$ -o comm=)


export STARSHIP_CONFIG=~/.config/starship/starship.toml


# 如果是 bash，禁用 powerlevel10k，启用 starship
if [[ "$_CURRENT_SHELL" == "bash" ]]; then
    if [[ "$_BASH_THEME" == "starship" ]]; then
    eval "$(starship init bash)"
    else
        # update_prompt will be called every time a command is executed.
        PROMPT_COMMAND="reset_broken_terminal; update_prompt"
        # PS1="\e[0;32m\]\u@\h \w \$(git_branch)\$ "
    fi
fi


if [[ "$_CURRENT_SHELL" == "zsh" ]]; then
    if [[ "$_ZSH_THEME" == "starship" ]]; then
        eval "$(starship init zsh)"
    elif [[ "$_ZSH_THEME" == "p10k" ]]; then
        case $_DISTRO in
            *Arch*|*arch*)
            [ -z "$_LOADED_ZSH_P10K" ]     && source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null                  && _LOADED_ZSH_P10K=1
            ;;
            *Debian*|*debian*)
            [ -z "$_LOADED_ZSH_P10K" ]     && source $HOME/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null        && _LOADED_ZSH_P10K=1
            ## Debian has neither powerlevel10k, zsh-autocomplete, zsh-history-substring-search in the official repository.
            ;;
            *Gentoo*|*gentoo*)
            [ -z "$_LOADED_ZSH_P10K" ]     && source /usr/share/zsh/site-functions/powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null         && _LOADED_ZSH_P10K=1
            ;;
            *)
            # For other distributions, we use the plugins in the user's home directory. And we assume that the user has run the install script.
            # But you can change it to the system directory.
            [ -z "$_LOADED_ZSH_P10K" ]     && source $HOME/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null        && _LOADED_ZSH_P10K=1
            ;;
        esac

        # To customize prompt, run `p10k configure` or edit ~/dotfiles/shellrc/p10k.zsh.
        [[ ! -f $SHELLROOT/p10k.zsh ]] || source "$SHELLROOT/p10k.zsh" #2>/dev/null
    fi
fi
