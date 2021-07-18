#!/bin/bash

git clone https://aur.archlinux.org/insomnia.git
cd insomnia
makepkg -si --noconfirm
cd ..
rm -rf insomnia
