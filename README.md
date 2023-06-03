# Dotfiles

My environment configurations:

- :penguin: [Ubuntu](https://ubuntu.com) - OS
- :fox_face: [Firefox](https://www.mozilla.org/en-US/firefox) - Browser
- :dog: [K9S](https://k9scli.io) - Kubernetes CLI
- :whale: [Docker](https://www.docker.com) - Containers
- :camera_flash: [Flameshot](https://flameshot.org) - Screenshot
- :guitar: [Spotify](https://spotify.com) - Music
- :speaking_head: [Slack](https://slack.com) - Communication
- :computer: [Terminator](https://gnome-terminator.org) - Terminal emulator
- :computer: [ZSH](https://www.zsh.org) - Terminal framework
- :pencil: [Neovim](https://neovim.io) - IDE
- :sleepy: [Insomnia](https://insomnia.rest/) - REST API client
- :vampire: [Dracula](https://draculatheme.com) - Theme
- :art: [GIMP](https://www.gimp.org) - Image manipulation

## Essentials

```
sudo apt update && sudo apt install -y \
    wget git htop ack-grep httpie xclip gnome-tweaks
```

## gcloud

```
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update && sudo apt install google-cloud-sdk
```

## kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

## oh-my-zsh

```
sudo apt update && sudo apt install -y fonts-powerline zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Python Essentials

```
sudo apt update && sudo apt install -y \
    build-essential libssl-dev libffi-dev python-dev openssl liblzma-dev libbz2-dev zlib1g-dev
```
