#!/bin/bash

sudo apt update && sudo apt install snapd
systemctl restart snapd
sudo snap install slack --classic
