# Enable nnn plugins
[ -z "$_LOADED_NNN_PLUGIN" ] && source $HOME/.config/nnn/plugin.sh 2>/dev/null && _LOADED_NNN_PLUGIN=1
[ -z "$_LOADED_NNN_QUITCD" ] && source /usr/share/nnn/quitcd/quitcd.bash_sh_zsh 2>/dev/null && _LOADED_NNN_QUITCD=1
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
# Restart gnome-remote-desktop.service
# source ${DOTROOT}/script/grdp.sh 2>/dev/null

# Enable command-not-found, only for gentoo
_DISTRO=$(get_distro)
case $_DISTRO in
    *Gentoo*|*gentoo*)
    [ -z "$_LOADED_GENTOO_COMMAND_NOT_FOUND" ] && source /etc/bash/bashrc.d/command-not-found.sh 2>/dev/null && _LOADED_GENTOO_COMMAND_NOT_FOUND=1
    ;;
esac

# Enable X-cmd plugin
[ -z "$LOADED_XCMD_PLUGIN"] &&  [ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" 2>/dev/null  && _LOADED_XCMD_PLUGIN=1    # boot up x-cmd.
