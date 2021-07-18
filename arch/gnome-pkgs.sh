#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Packages from the GNOME group: https://archlinux.org/groups/x86_64/gnome/
pacman -Syu --noconfirm \
       baobab \
       cheese \
       eog \
       evince \
       file-roller \
       gnome-backgrounds \
       gnome-calculator \
       sushi \
       gnome-color-manager \
       gnome-control-center \
       gnome-disk-utility \
       xdg-user-dirs-gtk \
       mutter \
       nautilus \
       gnome-font-viewer \
       gnome-keyring \
       gnome-menus \
       gnome-screenshot \
       gnome-session \
       gnome-settings-daemon \
       gnome-shell \
       gnome-shell-extensions \
       gnome-themes-extra \
       gnome-tweaks \
       adwaita-icon-theme
