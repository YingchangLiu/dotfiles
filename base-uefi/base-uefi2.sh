#!/bin/bash

echo "This is second script for base-uefi, mainly for installing the base system and generating the fstab file after partitioning the disks."

pacstrap /mnt base base-devel linux linux-firmware vim bash-completion  zsh-completions networkmanager

genfstab -U /mnt > /mnt/etc/fstab

echo "Now chroot into the new system and run the third script."