#!/bin/bash

echo "Updating package index..."
sudo apt -qq update

echo "Installing essentials..."

echo "  [build-essential] Meta-package to build dependencies"
sudo apt -qq install -y build-essential

echo "  [libssl-dev] Dev libraries for SSL/TLS"
sudo apt -qq install -y libssl-dev

echo "  [openssl] Library used for network communication"
sudo apt -qq install -y openssl

echo "  [curl] Client URL"
sudo apt -qq install -y curl
