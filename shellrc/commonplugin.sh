# Enable nnn plugins
source ~/.config/nnn/plugin.sh 2>/dev/null
source /usr/share/nnn/quitcd/quitcd.bash_sh_zsh 2>/dev/null
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
# Restart gnome-remote-desktop.service
source ~/dotfile/script/grdp.sh 2>/dev/null
