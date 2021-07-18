#!/bin/bash

git clone https://aur.archlinux.org/brave.git
cd brave
makepkg -si --noconfirm
cd ..
rm -rf brave
