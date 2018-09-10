#!/bin/sh

sudo apt install whois

# create user
sudo useradd -m -s /bin/bash -p `echo isucon | mkpasswd -s -m sha-512` sesta

# create authorized_keys
mkdir /home/sesta/.ssh
mkdir /home/isucon/.ssh

# dependency packages
sudo apt-get -y install curl vim git tmux zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config zip unzip

sudo su -c "curl https://github.com/sesta.keys >> /home/sesta/.ssh/authorized_keys"
sudo su -c "curl https://github.com/sesta.keys >> /home/isucon/.ssh/authorized_keys"

# add sudo group
usermod -G sudo sesta

# git config
git config --system user.email "oreno-isucon@isucon.com"
git config --system user.name "oreno-isucon"
git config --system core.editor "vim"

# config tmux
echo "set-option -g default-terminal \"screen-256color\"" > /home/isucon/.tmux.conf

# chown
sudo chown -R isucon:isucon /home/isucon/.ssh

# install netdata
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata
sudo ./netdata-installer.sh

# install alp command
curl -LO https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
unzip alp_linux_amd64.zip && rm alp_linux_amd64.zip
sudo mv ./alp /usr/bin/
