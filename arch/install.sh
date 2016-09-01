#!/bin/bash
# xfce4
lsblk

# partition
cfdisk /dev/sda

mkfs.vfat /dev/sda1
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

mkswap /dev/sda2
swapon /dev/sda2

mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt

mkfs.ext4 /dev/sda4
mkdir -p /mnt/home
mount /dev/sda4 /mnt/home

# base install
pacstrap -i /mnt base base-devel grub efibootmgr
# grub-mkconfig -o /boot/grub/grub.cfg
# grub-install --target=x86_64-efi --efi-directory=/mnt/boot/efi --bootloader-id=arch --recheck

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# change root
arch-chroot /mnt /bin/bash

# locale
# uncomment en_US.UTF-8 UTF-8 in /etc/locale.gen
locale-gen
echo LANG=en_US.UTF8 >> /etc/locale.conf

# time
tzselect
ln -s /usr/share/zoneinfo/Zone/SubZone /etc/localtime

# initramfs
mkinitcpio -p linux

# hostname
echo myhostname > /etc/hostname
# /etc/hosts
# 127.0.0.1	localhost.localdomain	localhost	 myhostname
# ::1		localhost.localdomain	localhost	 myhostname

# root password
passwd root

# add user
useradd -m -g users -G wheel,storage,power -s /bin/bash krivitski-no
passwd krivitski-no

# grub install
# mkdir -p /boot/efi
# mount -t vfat /dev/sda1 /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
grub-install /dev/sda
# reboot

# enable dhcpcd
systemctl enable dhcpcd
systemctl start dhcpcd
ping google.com -c 5

# sudo users
# /etc/sudoers
# krivitski-no ALL=(ALL) ALL pfff...
# uncomment wheel shit

# minimal xorg
pacman -S xorg
pacman -S xterm xorg-xclock xorg-twm xorg-xinit xorg-server-utils

# xfce de
pacman -S slim slim-themes archlinux-themes-slim xdg-user-dirs
pacman -S xfce4

systemctl enable slim.service
cp /etc/X11/xinit/xinitrc ~/.xinitrc

# uncomment exec startxfce4

# /etc/slim.conf
current_theme archlinux-soft-grey
# reboot

# net tools
sudo pacman -Syy net-tools gtkmm

# souund troubleshooting
sudo pacman -S pulseaudio
pulseaudio --start

# finish

#/etc/pacman.conf
#[infinality-bundle]
#SigLevel = Never
#Server = http://bohoomil.com/repo/$arch

#[infinality-bundle-multilib]
#SigLevel = Never
#Server = http://bohoomil.com/repo/multilib/$arch

#[infinality-bundle-fonts]
#SigLevel = Never
#Server = http://bohoomil.com/repo/fonts

pacman -Syu
pacman -S infinality-bundle
pacman -S infinality-bundle-multilib
pacman -S ibfonts-meta-extended-lt

fc-presets set
# 3

pacman -S xfce4-whiskermenu-plugin
pacman -S numix-themes

# <============>
