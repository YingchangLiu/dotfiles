#!/bin/bash
# List of functions:
# ex - archive extractor
#    usage: ex <file> [directory]
# cx - archive creator
#    usage: cx <file_or_dir> [file]
# cd - fancy cd that can cd into parent directory, if trying to cd into file
# confirm - confirm before running a command
#    usage: confirm <command>
# confirm_wrapper - confirm before running a command, with optional root privileges
#    usage: confirm_wrapper [--root] <command>
# poweroff - power off the system, with confirmation
# reboot - reboot the system, with confirmation
# hibernate - hibernate the system, with confirmation
# reload - reload the shell
# over_ssh - check if the shell is running over SSH
# get_distro - get the name of the distribution
# v2control - control V2Ray service
#    usage: v2control <start|stop|restart>
# v2toggle - toggle V2Ray service
# git_branch - color-code the current branch in the prompt
# delete_branches_except - delete all branches except the ones specified
# split_args - split the input arguments into an array using multiple delimiters
#   usage: split_args <string>
# set_path - add directories to PATH
#   usage: set_path <dir1> <dir2> ...
# set_ld_library_path - add directories to LD_LIBRARY_PATH
#   usage: set_ld_library_path <dir1> <dir2> ...
# set_library_path - add directories to LIBRARY_PATH
#   usage: set_library_path <dir1> <dir2> ...
# set_cpath - find include files
#   usage: set_cpath <dir1> <dir2> ...
# mkcd - make directory and change to it
# back - go back to the previous directory
# f - find a file in the current directory
#   usage: f <filename>
# ff - find a file whose name contains the given string
#   usage: ff <string>
# duh - check disk usage
# netstat - check network status
# psg - check process status
#   usage: psg <process_name>
# load - check system status
# mem - check memory status
# 


# Colors.
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'

# ex - archive extractor
# usage: ex <file> [directory]
ex ()
{
    local FILENAME DIR
    if [ -f "$1" ] ; then
        FILENAME=$(basename "$1")
        DIR=${2:-${FILENAME%%.*}}
        mkdir -p "$DIR"
        case "$1" in
            *.tar.bz2)  tar xjf "$1" -C "$DIR"      ;;
            *.tar.gz)   tar xzf "$1" -C "$DIR"      ;;
            *.tar.xz)   tar xJf "$1" -C "$DIR"      ;;
            *.tar.zst)  tar xf  "$1" -C "$DIR"      ;;
            *.bz2)      bunzip2 "$1" -C "$DIR"      ;;
            *.rar)      unrar x "$1" "$DIR"      ;;
            *.gz)       gunzip "$1" -C "$DIR"       ;;
            *.tar)      tar xf "$1" -C "$DIR"       ;;
            *.tbz2)     tar xjf "$1" -C "$DIR"      ;;
            *.tgz)      tar xzf "$1" -C "$DIR"      ;;
            *.zip)      unzip "$1" -d "$DIR"        ;;
            *.Z)        uncompress "$1" -C "$DIR"   ;;
            *.7z)       7z x "$1" -o"$DIR"         ;;
            *.xz)       unxz "$1" -C "$DIR"         ;;
            *.exe)      cabextract "$1" -d "$DIR"   ;;
            *.deb)      ar x "$1" "$DIR"         ;;
            *.lzma)     unlzma "$1" -C "$DIR"       ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# cx - archive creator
# usage: cx <file_or_dir> [file]
cx ()
{
    local FILE
    if [ -e "$1" ] ; then
        FILE=${2:-$(basename "$1").tar.gz}
        case "$FILE" in
            *.tar.bz2)  tar cjf "$FILE" -C "$(dirname "$1")" "$(basename "$1")"      ;;
            *.tar.gz)   tar czf "$FILE" -C "$(dirname "$1")" "$(basename "$1")"      ;;
            *.tar.xz)   tar cJf "$FILE" -C "$(dirname "$1")" "$(basename "$1")"      ;;
            *.tar.zst)  tar cf  "$FILE" -C "$(dirname "$1")" "$(basename "$1")"      ;;
            *.bz2)      bzip2 -c "$1" > "$FILE" ;;
            *.rar)      rar a "$FILE" "$1"        ;;
            *.gz)       gzip -c "$1" > "$FILE" ;;
            *.tar)      tar cf "$FILE" -C "$(dirname "$1")" "$(basename "$1")"       ;;
            *.tbz2)     tar cjf "$FILE" -C "$(dirname "$1")" "$(basename "$1")"      ;;
            *.tgz)      tar czf "$FILE" -C "$(dirname "$1")" "$(basename "$1")"      ;;
            *.zip)      zip -r "$FILE" "$1"       ;;
            *.Z)        compress -c "$1" > "$FILE" ;;
            *.7z)       7z a "$FILE" "$1"         ;;
            *.xz)       xz -c "$1" > "$FILE" ;;
            *.exe)      echo "'$1' cannot be compressed to '$FILE' via cx()" ;;
            *.deb)      echo "'$1' cannot be compressed to '$FILE' via cx()" ;;
            *.lzma)     lzma -c "$1" > "$FILE" ;;
            *)          echo "'$1' cannot be compressed to '$FILE' via cx()" ;;
        esac
    else
        echo "'$1' is not a valid file or directory"
    fi
}
# https://github.com/slashbeast/conf-mgmt/blob/master/roles/home_files/files/DOTzshrc
# Fancy cd that can cd into parent directory, if trying to cd into file.
unalias cd 2>/dev/null
cd() 
{
    if [ $# -gt 1 ]; then
        builtin cd "$@"
        return 0
    fi

    if [ -f "$1" ]; then
        echo -e "${yellow}cd $(dirname "$1")${NC}" >&2
        builtin cd "$(dirname "$1")"
    else
        builtin cd "$@"
    fi
}

confirm() {
    local answer
    echo -ne "Sure you want to run '${YELLOW}$*${NC}' [yN]? "
    read -r answer
    echo
    if [[ -z "$answer" || "$answer" =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
        "$@"
    else
        return 1
    fi
}

confirm_wrapper() {
    if [ "$1" = '--root' ]; then
        local as_root='true'
        shift
    fi

    local prefix=''

    if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
        prefix="sudo"
    fi
    confirm "${prefix}" "$@"
}

unalias poweroff 2>/dev/null
unalias reboot 2>/dev/null
unalias hibernate 2>/dev/null
poweroff() { confirm_wrapper --root "$0" "$@"; }
reboot() { confirm_wrapper --root "$0" "$@"; }
hibernate() { confirm_wrapper --root "$0" "$@"; }

reload () {
    exec "${SHELL}" "$@"
}

over_ssh() {
    if [ -n "${SSH_CLIENT}" ]; then
        return 0
    else
        return 1
    fi
}

# get_distro - get the name of the distribution
get_distro() {
    local DISTRO
    if command -v lsb_release > /dev/null; then
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed 's/^\t//')
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        DISTRO="unknown"
    fi
    echo "$DISTRO"
}

# V2Ray control，rc-service or systemctl is optional
v2control() {
    if [ "$1" = "start" ] || [ "$1" = "stop" ]|| [ "$1" = "restart" ]; then
        if [[ $(ps --no-headers -o comm 1) == "systemd" ]]; then
            sudo systemctl start v2ray
            sudo systemctl "$1"  v2raya
        elif [[ $(command -v openrc) ]]; then
            sudo rc-service v2ray start
            sudo rc-service v2raya "$1"
        else
            echo "Neither systemd nor openrc is being used"
        fi
    else
        echo "Invalid argument. Use 'start' or 'stop'."
    fi
}

# V2Ray control with auto detection. If v2raya is running, stop it. If not, start it.
v2toggle() {
    # Check if v2raya is running
    if pgrep -x "v2raya" > /dev/null
    then
        # If running, stop it
        echo "v2raya is running, stopping it"
        v2control stop
    else
        # If not running, start it
        echo "v2raya is not running, starting it"
        v2control start
    fi
}

# Reset the terminal when it's broken
function reset_broken_terminal () {
	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

# PS1 definition that color-codes the current branch as red for uncommitted changes, green for a clean directory, and yellow for stashed changes.
git_branch() {
  local branch color
  branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
  if [ ! -z "$branch" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      color="31"  # Red for changes
    elif [ "$(git stash list)" ]; then
      color="33"  # Yellow for stashed changes
    else
      color="32"  # Green for a clean state
    fi
    echo -e "\\e[0;${color}m${branch}\\e[0m"  
  fi
}

setup_git_prompt() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        unset git_prompt
        return 0
    fi
    local git_status_dirty git_status_stash git_branch

    if [ "$(git --no-optional-locks status --untracked-files='no' --porcelain)" ]; then
        # git_status_dirty='%F{green}*'  ## for zsh
        git_status_dirty='\[\e[32m\]*\[\e[0m\]'
    else
        unset git_status_dirty
    fi

    if [ "$(git stash list)" ]; then
        # git_status_stash="%F{yellow}▲"
        git_status_stash='\[\e[33m\]▲\[\e[0m\]'
    else
        unset git_status_stash
    fi

    git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
    git_branch="${git_branch#refs/heads/}"

    if [ "${#git_branch}" -ge 24 ]; then
        git_branch="${git_branch:0:21}..."
    fi

    git_branch="${git_branch:-no branch}"

    # git_prompt=" %F{blue}[%F{253}${git_branch}${git_status_dirty}${git_status_stash}%F{blue}]"
    git_prompt=" \[\e[34m\][\[\e[97m\]${git_branch}${git_status_dirty}${git_status_stash}\[\e[34m\]]\[\e[0m\]"
}

# Fancy prompt.
setup_ssh_prompt() {
    local over_ssh
    over_ssh=$(echo "$SSH_CLIENT" | awk '{print $1}')

    if [ -n "$over_ssh" ] && [ -z "${TMUX}" ]; then
        prompt_is_ssh='%F{blue}[%F{red}SSH%F{blue}] '
    elif [ -n "$over_ssh" ]; then
        prompt_is_ssh='%F{blue}[%F{253}SSH%F{blue}] '
    else
        unset prompt_is_ssh
    fi
}


# Update the prompt for bash. Need 'PROMPT_COMMAND=update_prompt' in .bashrc
update_prompt() {
    # local git_prompt ssh_prompt
    setup_git_prompt
    setup_ssh_prompt
    case $USER in
    root)
        # PS1="%B%F{cyan}%m%k %(?..%F{blue}[%F{253}%?%F{blue}] )${prompt_is_ssh}%B%F{blue}%1~${git_prompt}%F{blue} %# %b%f%k"
        PS1="\[\e[1m\]\[\e[36m\]\h\[\e[0m\] \[\e[34m\][\[\e[97m\]$?\[\e[34m\]] ${prompt_is_ssh}\[\e[1m\]\[\e[34m\]\w\[\e[0m\] ${git_prompt}\[\e[34m\] # \[\e[0m\]"
    ;;
    *)  
        # PS1="%B%F{blue}%n@%m%k %(?..%F{blue}[%F{253}%?%F{blue}] )${prompt_is_ssh}%B%F{cyan}%1~${git_prompt}%F{cyan} %# %b%f%k"
        PS1="\[\e[1m\]\[\e[34m\]\u@\h\[\e[0m\] \[\e[34m\][\[\e[97m\]$?\[\e[34m\]] ${prompt_is_ssh}\[\e[1m\]\[\e[36m\]\w\[\e[0m\] ${git_prompt}\[\e[36m\] # \[\e[0m\]"
    ;;
esac
}

delete_branches_except() {
    local cmd
    cmd='git branch'
     for i in "$@"; do
       cmd=$cmd' | grep -v "'$i'"'
     done
     cmd=$cmd' | xargs git branch -D'
     eval "$cmd"
}

# Split the input arguments into an array using multiple delimiters
split_args() {
    # Temporarily set IFS to the desired delimiters
    local IFS=': ,;|'
    # Enable sh_word_split in zsh if necessary
    [ -n "$ZSH_VERSION" ] && setopt localoptions sh_word_split
    
    # Split the input string into an array
    local args_array
    args_array=($*)
    echo "${args_array[@]}"
}
# #!/usr/bin/env zsh
# # Split the input arguments into an array using multiple delimiters
# function split_args() {
#     local IFS=': ,;|'
#     read -r -A args_array <<< "$@"
# }
# #!/usr/bin/env bash
# function split_args() {
#     local IFS=': ,;|'
#     read -r -a args_array <<< "$@"
# }


# set_path function is used to add directories to PATH.
set_path(){
    # Check if user id is 0 (root) or 1000 or higher
    [[ "$(id -u)" -eq 0 ]] || [[ "$(id -u)" -ge 1000 ]] || return

    # Split the input into an array using ' ' and ':' as the delimiters
    local args_array    
    args_array=($(split_args "$@"))
    # echo "args_array: ${args_array[@]}"
    local i
    for i in "${args_array[@]}";
    do
        # Expand ~ and environment variables in $i
        i=$(eval echo "$i")

        # Check if the directory exists and is not empty
        [[ -d "$i" && -n "$i" ]] || continue

        # Convert to absolute path
        i=$(realpath "$i")
        
        # Check if it is not already in your $PATH.
        [[ ":$PATH:" == *":$i:"* ]] && continue

        # Then append it to $PATH and export it
        export PATH="$i:${PATH}"
    done
}

# set_ld_library_path function is used to add directories to LD_LIBRARY_PATH.
set_ld_library_path(){
    # Check if user id is 0 (root) or 1000或更高
    [[ "$(id -u)" -eq 0 ]] || [[ "$(id -u)" -ge 1000 ]] || return

    # Split the input into an array using ' ' and ':' as the delimiters
    local args_array
    args_array=($(split_args "$@"))
    # echo "args_array: ${args_array[@]}"
    local i
    for i in "${args_array[@]}";
    do
        # Expand ~ and environment variables in $i
        i=$(eval echo "$i")

        # Check if the directory exists and is not empty
        [[ -d "$i" && -n "$i" ]] || continue

        # Convert to absolute path
        i=$(realpath "$i")

        # Check if it is not already in your $LD_LIBRARY_PATH.
        [[ ":$LD_LIBRARY_PATH:" == *":$i:"* ]] && continue

        # Then append it to $LD_LIBRARY_PATH and export it
        export LD_LIBRARY_PATH="$i:${LD_LIBRARY_PATH}"
    done
}

# set_library_path function is used to add directories to LIBRARY_PATH.
set_library_path(){
    # Check if user id is 0 (root) or 1000或更高
    [[ "$(id -u)" -eq 0 ]] || [[ "$(id -u)" -ge 1000 ]] || return

    # Split the input into an array using ' ' and ':' as the delimiters
    local args_array
    args_array=($(split_args "$@"))
    # echo "args_array: ${args_array[@]}"
    local i
    for i in "${args_array[@]}";
    do
        # Expand ~ and environment variables in $i
        i=$(eval echo "$i")

        # Check if the directory exists and is not empty
        [[ -d "$i" && -n "$i" ]] || continue

        # Convert to absolute path
        i=$(realpath "$i")

        # Check if it is not already in your $LIBRARY_PATH.
        [[ ":$LIBRARY_PATH:" == *":$i:"* ]] && continue

        # Then append it to $LIBRARY_PATH and export it
        export LIBRARY_PATH="$i:${LIBRARY_PATH}"
    done
}

# set_cpath function is used to find include files.
set_cpath(){
    # Check if user id is 0 (root) or 1000或更高
    [[ "$(id -u)" -eq 0 ]] || [[ "$(id -u)" -ge 1000 ]] || return

    # Split the input into an array using ' ' and ':' as the delimiters
    local args_array
    args_array=($(split_args "$@"))
    # echo "args_array: ${args_array[@]}"
    for i in "${args_array[@]}";
    do
        # Expand ~ and environment variables in $i
        local i
        i=$(eval echo "$i")

        # Check if the directory exists and is not empty
        [[ -d "$i" && -n "$i" ]] || continue

        # Convert to absolute path
        i=$(realpath "$i")

        # Check if it is not already in your $CPATH.
        [[ ":$CPATH:" == *":$i:"* ]] && continue

        # Then append it to $CPATH and export it
        export CPATH="$i:${CPATH}"
    done
}

# mkcd - make directory and change to it
mkcd () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# back - go back to the previous directory
back() {
    cd "$OLDPWD"
}

# Find a file in the current directory
f() {
    find . -name "$1" 2>/dev/null
}

# Find a file whose name contains the given string
ff() {
    grep -r "$1" 2>/dev/null
}

# check disk usage
duh() {
    du -sh * 2>/dev/null
}

# check network status
netstat() {
    sudo netstat -tuln
}

# check process status
psg() {
    ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# check system status
load() {
    echo "uptime:"
    uptime
    echo "-------------------------------------"
    echo "cpu info:"
    mpstat 1 3
}

# check memory status
mem() {
    echo "mem info:"
    free -h
}

# update micromamba
update_micromamba() {
    micromamba self-update
}