#!/bin/bash

git clone https://aur.archlinux.org/slack-desktop.git
cd slack-desktop
makepkg -si --noconfirm
cd ..
rm -rf slack-desktop
