#!/bin/sh

LOG_FILE="log.txt"


# asus-linux
sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

wget "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x8b15a6b0e9a3fa35" -O g14.sec
sudo pacman-key -a g14.sec

sudo bash -c "echo \"[g14]\" >> /etc/pacman.conf"
sudo bash -c "echo \"Server = https://arch.asus-linux.org\" >> /etc/pacman.conf"

yay

# Install asus apps
echo "Installing asus apps" >> "$LOG_FILE"
APPS_ASUS_LAPTOP=$(cat apps-asus-laptop.txt | tr '\n' ' ')
yay -S $APPS_ASUS_LAPTOP

sudo systemctl enable power-profiles-daemon.service
sudo systemctl enable  supergfxd

