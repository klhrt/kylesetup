#!/bin/bash
sudo apt update
sudo apt install -y fish compton polybar feh firefox polybar xinit autorandr kitty pcmanfm redshift libudev-dev alsa libasound2-dev build-essential pkg-config

sudo cp -rd .config/ ~/
sudo cp -rd Pictures/ ~/
sudo cp -rd fonts/ /usr/share/
sudo cp ./shells /etc/shells

sudo apt install -y awesome

cd ~/Downloads
wget -c http://archive.ubuntu.com/ubuntu/pool/main/l/lvm2/liblvm2app2.2_2.02.176-4.1ubuntu3.18.04.3_amd64.deb
sudo apt-get install lvm2 ./liblvm2app2.2_2.02.176-4.1ubuntu3.18.04.3_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/k/kvpm/kvpm_0.9.10-1.1_amd64.deb
sudo apt-get install -y ./kvpm_0.9.10-1.1_amd64.deb

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

export PATH="$PATH:~/.cargo/bin/"

chsh -s /usr/bin/fish

cargo install porsmo
cargo install ttyper
cargo install ncspot
cargo install helix
sudo apt update
sudo apt upgrade -y

echo "type startx to get started in i3!"
