#!/bin/bash

echo "Updating package index..."
sudo apt update

echo "Installing essentials..."
echo "  [build-essential] Meta-package to build dependencies"
apt install -y build-essential
