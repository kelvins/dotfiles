#!/bin/bash

git clone https://aur.archlinux.org/gnome-shell-extension-dash-to-dock.git
cd gnome-shell-extension-dash-to-dock
makepkg -si --noconfirm
cd ..
rm -rf gnome-shell-extension-dash-to-dock
