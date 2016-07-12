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
