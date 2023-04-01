# Dotfiles

## Essentials

```
sudo apt update && sudo apt install -y \
    wget tree git vim htop \
    ack-grep curl httpie \
    xclip gnome-tweaks
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

## Terminator

```
sudo add-apt-repository ppa:gnome-terminator
sudo apt update && sudo apt install -y fonts-powerline terminator
```

## Another apps

- spotify
- slack
- brave
- docker
- k9s
- sqlectron
- insomnia
- flameshot
