#!/usr/bin/env bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
  sudo dnf install ansible -y
fi

ansible-playbook -i ~/github/dotfiles/hosts ~/github/dotfiles/setup.yml --ask-become-pass

if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "dotfiles: Bootstrap complete" -message "Successfully set up dev environment."
fi
