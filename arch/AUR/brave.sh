#!/bin/bash

git clone https://aur.archlinux.org/brave-bin.git
cd brave-bin
makepkg -si --noconfirm
cd ..
rm -rf brave-bin
