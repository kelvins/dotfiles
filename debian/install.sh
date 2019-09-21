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
sudo snap install slack

# Install Docker
sudo snap install docker

# Install GCloud SDK
sudo snap install google-cloud-sdk

# Install HTTPie
sudo apt-get install httpie

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
