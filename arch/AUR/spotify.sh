#!/bin/bash

git clone https://aur.archlinux.org/spotify.git
cd spotify
makepkg -si --noconfirm
cd ..
rm -rf spotify
