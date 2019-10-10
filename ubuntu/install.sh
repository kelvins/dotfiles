# Update apt-get
sudo apt-get update

# Install some basic packages
sudo apt-get install -y ack tree htop vim git

# Install and start snap
sudo apt-get install snapd
systemctl restart snapd

# Install Spotify
sudo snap install spotify

# Install Insomnia
sudo snap install insomnia

# Install Slack
sudo snap install slack --classic

# Install Docker
sudo snap install docker

# Install DataGrip
sudo snap install datagrip --classic

# Install GCloud SDK
# sudo snap install google-cloud-sdk
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

# Install HTTPie
sudo apt-get install -y httpie

# Install terminator
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install -y terminator

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

# Install DBeaver
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
sudo apt-get install -f

# Install OH MY ZSH
sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Solarized Powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Powerline fonts
sudo apt-get install fonts-powerline

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
