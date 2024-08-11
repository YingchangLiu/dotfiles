[ -z "$_LOADED_BASH_AUTOJUMP"] && source /usr/share/autojump/autojump.bash 2>/dev/null && _LOADED_BASH_AUTOJUMP=1

_DISTRO=$(get_distro)
case $_DISTRO in
    *Arch*|*arch*)
    [ -z "$_LOADED_BASH_COMMAND_NOT_FOUND" ] && source /usr/share/doc/pkgfile/command-not-found.bash 2>/dev/null && _LOADED_BASH_COMMAND_NOT_FOUND=1
    ;;
esac

