#!/bin/bash

git clone https://aur.archlinux.org/spotify.git
cd spotify
makepkg -si
cd ..
rm -rf spotify
