#!/bin/bash

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
git clone https://aur.archlinux.org/spotify.git
cd spotify
makepkg -si --noconfirm
cd ..
rm -rf spotify
