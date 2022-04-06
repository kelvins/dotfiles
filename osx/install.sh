#!/bin/bash

# Install Homebrew
sudo xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor

brew install --cask iterm2
brew install zsh

# Install oh-my-zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install vim htop ack tree curl httpie

brew install pyenv rustup go

brew install kubectl helm kustomize k9s
