#!/bin/bash

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

pacman -S numix-themes
