#!/bin/bash

sudo pacman -Syu --noconfirm npm

git clone https://aur.archlinux.org/nvm.git
cd nvm
makepkg -si --noconfirm
cd ..
rm -rf nvm

git clone https://aur.archlinux.org/insomnia.git
cd insomnia
makepkg -si --noconfirm
cd ..
rm -rf insomnia
