#!/bin/bash

pacstrap /mnt base base-devel linux linux-firmware vim bash-completion  zsh-completions networkmanager

genfstab -U /mnt > /mnt/etc/fstab
