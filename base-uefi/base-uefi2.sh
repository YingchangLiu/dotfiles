#!/bin/bash

pacstrap /mnt base base-devel linux linux-firmware dhcpcd vim bash-completion zsh zsh-completions ntfs-3g

genfstab -U /mnt > /mnt/etc/fstab
