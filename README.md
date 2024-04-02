# kelen's dotfiles

***Warning***: I'm working with **Arch Linux** and **Debian.** Don’t blindly use my settings unless you know what that entails. Use at your own risk!

---
## Styles  
**"Keep it simple stupid."**
![image](./assets/desktop.png)
![image](./assets/windows.png)
![image](./assets/plasma.png)

> ri • cing 
> /ry-sing/
>
> 1. Making visual improvements and customization to your desktop and/or phone that can simplify your desktop environment but (generally) are completely pointless.
> 2. Wasting time because aesthetic.

## Installing

```console
$ sh ./install.sh
```
This will create symlinks from this repo to your home folder.

## Contents

### Alias
Please check in [dotfile/shellrc/alias.sh](./shellrc/alias.sh).

### Arch installation guide
- base-uefi

If you are looking for an Arch installation guide, the following sites are recommended：

Arch Wiki https://wiki.archlinux.org/title/Installation_guide

A concise guide to archlinux in Chinese https://arch.icekylin.online/

### Configs
- bash
- btop
- conky
- dust
- fastfetch
- fcitx5 with rime-ice
- gBar
- kitty
- mpd
- nnn
- paru
- picom
- pip
- powerlevel10k
- rofi
- swaylock-effects
- thefuck
- vim
- wallpaper engine on linux
- waybar
- wofi
- zsh, working with autojump, autosuggestions, command-not-found, completions, history-substring-search and syntax-highlighting

### PKGBUILDs
Research packages that are maintained by me or archived for geophysics.
- cuda-multiversion
- intel-oneapi-hpckit (with oneapi-basekit) and its 2023.2.0 version
- madagascar
- mathematica
- matlab
- miniconda3
- openmpi4
- plplot
- seismic-unix

You can find a list of the geophysical codes that I am currently utilizing for my research [here](./pkgbuilds/README.md).


### Scripts
- background-changer
- check kernel: reboot required or not
- gitreset
- gitshrink
- killprocess
- linux-wallpaperengine
- logout
- maintenace
- pytorch cuda test
- screenrecord
- screenshot
- volume control
- wayland session lock

### Wallpapers
Please check in [dotfile/wallpaper](./wallpaper/).

### Window manager
- dwm (Xorg)
- KDE Plasma (DE on workstation)
- Hyprland (Wayland)

## License
The code is available under the [MIT license][license].

---
**Dotfile** ©kelen. Released under the MIT License.

Authored and maintained by kelen.

<!-- Link labels: -->
[license]: LICENSE