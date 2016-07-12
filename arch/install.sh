#!/bin/bash

lsblk

#partition
cfdisk /dev/sda

#file system
mkfs.ext4 /dev/sda1

mkswap /dev/sda2
swapon /dev/sda2

mkfs.ext4 /dev/sda3

#mounting
mkdir /mnt/boot /mnt/var /mnt/home

mount /dev/sda3 /mnt
mount /dev/sda1 /mnt/boot

#base install
pacstrap -i /mnt base base-devel

#update
pacman -Syu

#grub
pacstrap /mnt grub-bios

#fstab
genfstab -U /mnt >> /mnt/etx/fstab

#change root
arch-chroot /mnt /bin/bash

#locale
#uncomment en_US.UTF-8 UTF-8 in /etc/locale.gen
locale-gen
echo >> LANG=en_US.UTF8 >> /etc/locale.conf

#time
tzselect
ln -s /usr/share/zoneinfo/Zone/SubZone /etc/localtime

#initramfs
mkinitcpio -p linux

#hostname
echo myhostname > /etc/hostname
#/etc/hosts
#127.0.0.1	localhost.localdomain	localhost	 myhostname
#::1		localhost.localdomain	localhost	 myhostname

#root password
passwd root

#add user
useradd -m -g users -G wheel -s /bin/bash krivitski-no
passwd krivitski-no

#grub install
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
#reboot

#enable dhcpcd
systemctl enable dhcpcd
systemctl start dhcpcd
ping google.com -c 5

#sudo users
nano /etc/sudoers
krivitski-no ALL=(ALL) ALL

#minimal xorg
pacman -S xorg
pacman -S xterm xorg-xclock xorg-twm xorg-xinit xorg-server-utils

#mate de
pacman -Syu mate mate-extra

#desktop manager
pacman -Syu lightdm-gtk-greeter accountsservice
systemctl enable lightdm
systemctl enable accounts-daemon
#reboot

#net tools
sudo pacman -Syy net-tools gtkmm

#vb guest additions
sudo pacman -S virtualbox-guest-utils
