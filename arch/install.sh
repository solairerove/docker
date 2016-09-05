#!/bin/bash
# lsblk

# partition
cfdisk /dev/sda

# formatting
mkfs.vfat /dev/sda1

mkswap /dev/sda2
swapon /dev/sda2

mkfs.ext4 /dev/sda3

mkfs.ext4 /dev/sda4

# mounting
mount /dev/sda3 /mnt

mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

mkdir -p /mnt/home
mount /dev/sda4 /mnt/home

# choose closest mirrors
pacman -Sy
pacman -S reflector
reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

# base install
pacstrap -i /mnt base base-devel

# fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# change root
arch-chroot /mnt /bin/bash

# locale
# uncomment en_US.UTF-8 UTF-8 in /etc/locale.gen
locale-gen
echo LANG=en_US.UTF8 >> /etc/locale.conf

# set local time
tzselect
ln -s /usr/share/zoneinfo/Zone/SubZone /etc/localtime
hwclock --sysohc --utc

# set hostname
echo myhostname > /etc/hostname
# /etc/hosts
# 127.0.0.1	localhost.localdomain	localhost	 myhostname
# ::1		localhost.localdomain	localhost	 myhostname

# add multilib
# uncomment multilib in /etc/pacman.conf
pacman -Sy

# change root password
passwd
pacman -S sudo bash-completion

# add user
useradd -m -g users -G wheel,storage,power -s /bin/bash krivitski-no
passwd krivitski-no
# uncomment wheel ALL=(ALL)ALL

# grub install
mkinitcpio -p linux
pacman -S grub os-prober efibootmgr
grub-mkconfig -o /boot/grub/grub.cfg
grub-install /dev/sda
# exit
# umount -R /mnt
# reboot

# enable dhcpcd
sudo systemctl enable dhcpcd
sudo systemctl start dhcpcd
ping google.com -c 5

# minimal xorg
sudo pacman -S xorg
sudo pacman -S xterm xorg-xclock xorg-twm xorg-xinit xorg-server-utils

# xfce de
sudo pacman -S lightdm lightdm-gtk-greeter xdg-user-dirs
sudo pacman -S xfce4 xfce4-goodies

systemctl enable lightdm.service
cp /etc/X11/xinit/xinitrc ~/.xinitrc
# stay alive foreach shit
# exec startxfce4

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
