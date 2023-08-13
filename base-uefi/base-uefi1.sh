#!/bin/bash

systemctl stop reflector.service
timedatectl set-ntp true
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
cat > /etc/pacman.d/mirrorlist << "EOF"
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
EOF
cat /etc/pacman.d/mirrorlist.bak >> /etc/pacman.d/mirrorlist && rm /etc/pacman.d/mirrorlist.bak

echo "Partition the disks and mounting the file systems now."
