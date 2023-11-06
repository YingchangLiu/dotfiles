#alias matlab='/home/kelen/bin/matlab/bin/matlab'
alias xfce4='env LANG=zh_CN.UTF-8 startxfce4'
# check kernel
alias checkkernel='sh ~/dotfile/script/checkbootkernel.sh'
alias checkclass='sh ~/dotfile/script/checkclass.sh'
alias reinstall='pacman -Qqn | pacman -S -'
alias fetch='fastfetch -c ~/.config/fastfetch/kelen.jsonc'
alias nekoray='nekoray -many'
alias vnc='vncviewer -passwd ~/.vnc/passwd 127.0.0.1:1'
# view image using mpv
alias mvi='mpv --config-dir=$HOME/.config/mvi'

# start sway without nvidia
alias sway='sway --unsupported-gpu'

# start some desktop from xinitrc
alias awesome='startx ~/dotfile/xinitrc/xinitrc.awesome'
alias gnome='startx ~/dotfile/xinitrc/xinitrc.gnome'
alias bspwm='startx ~/dotfile/xinitrc/xinitrc.bspwm'
alias dwm='startx ~/dotfile/xinitrc/xinitrc.dwm'

# OBS from xwayland
# alias obs='QT_QPA_PLATFORM=xcb obs'

# alacritty with wayland
# alias alacritty='Exec=env WAYLAND_DISPLAY= alacritty'

# alias matlab='env LD_PERLOAD=/usr/lib/libstdc++.so LD_LIBRARY_PATH=/usr/lib/xorg/modules/dri/ MESA_LOADER_DRIVER_OVERRIDE=i1965 LANG=zh_CN.UTF-8 matlab'

# change hosts for connect some adress
alias hosts='sudo wget https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts -O /etc/hosts'
alias hosts2='sudo wget https://scaffrey.coding.net/p/hosts/d/hosts/git/raw/master/hosts-files/hosts -O /etc/hosts'
alias hosts3='sudo wget https://git.qvq.network/googlehosts/hosts/raw/master/hosts-files/hosts -O /etc/hosts'

# ex - archive extractor
# usage: ex <file>
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.tar.xz)   tar xJf $1      ;;
            *.tar.zst)  tar xf  $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      unrar x $1      ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *.7z)       7z x $1         ;;
            *.xz)       unxz $1         ;;
            *.exe)      cabextract $1   ;;
            *.deb)      ar x $1         ;;
            *.lzma)     unlzma $1       ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# unalias run-help
alias help=run-help



## Modified commands
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias ip='ip --color=auto'

# New commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history 1 | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep'           # requires an argument
alias cd='cd'
alias CD='cd'
alias cd..='cd ..'
alias ..=' cd ..'
alias ...=' cd ../..'
alias ....=' cd ../../..'
alias bd='cd -'
alias aurupgrade='paru -Syu --aur'
alias wttr='curl wttr.in'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias pkgbak='pacman -Qeqn > ~/dotfile/script/pacman_application.txt && pacman -Qeqm > ~/dotfile/script/aur_application.txt'
alias maintenance='source ~/dotfile/script/maintenance.sh'

# ls
alias ls=' ls -hF --color=auto --group-directories-first'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
alias l.='ls -d .* --color=auto'
alias LS='ls'



# Privileged access
if (( UID != 0 )); then
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -i'
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
    alias dmesg='sudo dmesg -HL'
    alias install-grub='sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB'
    alias update-grub='sudo env LANG=en_US.UTF-8 grub-mkconfig -o /boot/grub/grub.cfg'
    alias pacman='sudo pacman'
    alias apt='sudo apt'
    alias apt-get='sudo apt-get'
    alias zypper='sudo zypper'
    alias dnf='sudo dnf'
    alias yum='sudo yum'

    alias mount='sudo mount'
    alias umount='sudo umount'

fi

DISTRO=`lsb_release -d | awk -F"\t" '{print $2}'`
case $DISTRO in
    *Arch*)
        alias update='sudo pacman -Syy'
        alias upgrade='sudo pacman -Syyu'
        ;;
    *Debian*|*Ubuntu*)
        alias update='sudo apt-get update'
        alias upgrade='sudo apt-get upgrade'
        ;;
    *Fedora*|*CentOS*)
        alias update='sudo dnf update'
        alias upgrade='sudo dnf upgrade'
        ;;
    *SUSE*)
        alias update='sudo zypper refresh'
        alias upgrade='sudo zypper update'
        ;;
esac
## Safety features
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
# alias rm=' timeout 5 rm -Iv --one-file-system --preserve-root'   # 'rm -i' prompts for every file
alias rm='rm -Iv --one-file-system --preserve-root'   # 'rm -i' prompts for every file
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

## Make Bash/Zsh error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'

