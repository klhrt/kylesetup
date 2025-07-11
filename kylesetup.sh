#!/bin/bash
sudo apt update
sudo apt install -y fish compton polybar feh firefox polybar xinit autorandr kitty pcmanfm redshift libudev-dev alsa libasound2-dev build-essential pkg-config

sudo cp -rd .config/ ~/
sudo cp -rd Pictures/ ~/
sudo cp -rd fonts/ /usr/share/
sudo cp ./shells /etc/shells

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2025.03.09_all.deb keyring.deb SHA256:2c2601e6053d5c68c2c60bcd088fa9797acec5f285151d46de9c830aaba6173c
sudo apt install ./keyring.deb
echo "deb [signed-by=/usr/share/keyrings/sur5r-keyring.gpg] http://debian.sur5r.net/i3/ $(grep '^VERSION_CODENAME=' /etc/os-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3

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
