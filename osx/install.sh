#!/bin/bash

# Install Homebrew
sudo xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor

# Install git
brew install git

# Install iTerm2
brew install --cask iterm2

# Install ZSH
brew install zsh

# Install oh-my-zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install vim
brew install vim

# Install htop
brew install htop

# Install ack
brew install ack

# Install tree
brew install tree

# Install curl
brew install curl

# Install httpie
brew install httpie

# Install pyenv
brew install pyenv

# Install Rust
brew install rustup

# Install Go
brew install go

# Install kubectl
brew install kubectl

# Install helm
brew install helm

# Install kustomize
brew install kustomize

# Install K9S
brew install derailed/k9s/k9s
