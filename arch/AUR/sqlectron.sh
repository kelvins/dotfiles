#!/bin/bash

git clone https://aur.archlinux.org/sqlectron-gui.git
cd sqlectron-gui
makepkg -si --noconfirm
cd ..
rm -rf sqlectron-gui
