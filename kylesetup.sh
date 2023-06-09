#!/bin/bash
sudo apt update
sudo apt install -y fish compton polybar feh firefox polybar xinit autorandr kitty pcmanfm redshift libudev-dev alsa libasound2-dev build-essential pkg-config
sudo snap install --beta nvim --classic

sudo cp -rd .config/ ~/
sudo cp -rd Pictures/ ~/
sudo cp -rd fonts/ /usr/share/
sudo cp ./shells /etc/shells

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo apt install -y ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install -y i3

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
sudo apt update
sudo apt upgrade -y

echo "type startx to get started in i3!"
