#!/bin/bash

sudo pacman -S git

git config --global user.name "GIT_NAME"
git config --global user.email GIT_EMAIL

ssh-keygen -t rsa -C "your_email@example.com"
exec ssh-agent bash
ssh-add ~/.ssh/id_rsa

# GitHub/Settings/SSH Key/ctr+v;

ssh -T git@github.com
