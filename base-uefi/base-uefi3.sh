#!/bin/bash

echo "This is third script for base-uefi, mainly for setting up the system and user configuration after installing the base system."

echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain    arch" >> /etc/hosts

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen

echo 'LANG=en_US.UTF-8'  > /etc/locale.conf

echo 'root:passwd' | chpasswd

pacman -S intel-ucode
pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable --now NetworkManager
useradd -m -G wheel -s /bin/zsh kelen
usermod -aG video kelen
echo "kelen:passwd" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" >>/etc/sudoers

cat >> /etc/pacman.conf << "EOF"
[multilib]
Include = /etc/pacman.d/mirrorlist
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
EOF
pacman -Syyu
pacman -S archlinuxcn-keyring

echo "Now exit the chroot environment and unmount the partitions, then reboot into the new system."
echo "After rebooting into the new system, run the fourth script."

# exit
# umount -R /mnt

# reboot
