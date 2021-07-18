#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install vim
pacman -Syu --noconfirm vim

# Install man
pacman -Syu --noconfirm man

# Install grep
pacman -Syu --noconfirm grep

# Install sed
pacman -Syu --noconfirm sed

# Install which
pacman -Syu --noconfirm which

# Install htop
pacman -Syu --noconfirm htop

# Install tree
pacman -Syu --noconfirm tree

# Install git
pacman -Syu --noconfirm git

# Install tig
pacman -Syu --noconfirm tig

# Install wget
pacman -Syu --noconfirm wget

# Install curl
pacman -Syu --noconfirm curl

# Install ack
pacman -Syu --noconfirm ack

# Install neofetch
pacman -Syu --noconfirm neofetch

# Install grep
pacman -Syu --noconfirm xclip

# Install openssh
pacman -Syu --noconfirm openssh

# Install terminator
pacman -Syu --noconfirm terminator

# Install zsh
pacman -Syu --noconfirm zsh

# Install python-pip
pacman -Syu --noconfirm python-pip

# Install pyenv
pacman -Syu --noconfirm pyenv

# Install cmake
pacman -Syu --noconfirm cmake

# Install docker
pacman -Syu --noconfirm docker
systemctl enable docker.service
sudo gpasswd -a $USER docker

# Install docker-compose
pacman -Syu --noconfirm docker-compose

# Install kubectl
pacman -Syu --noconfirm kubectl

# Install k9s
pacman -Syu --noconfirm k9s

# Install flameshot
pacman -Syu --noconfirm flameshot

# Install gimp
pacman -Syu --noconfirm gimp

# Install base devel
pacman -Syu --noconfirm base-devel
