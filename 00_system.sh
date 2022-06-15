#!/bin/sh

CUSTOM_HOSTNAME='grimmauld-place'

#Configure hostname
sudo bash -c "echo $CUSTOM_HOSTNAME > /etc/hostname"

#Configure hosts
sudo bash -c "echo \"127.0.0.1       localhost\" >> /etc/hosts"
sudo bash -c "echo \"::1             localhost\" >> /etc/hosts"
sudo bash -c "echo \"127.0.1.1       $CUSTOM_HOSTNAME.localdomain $CUSTOM_HOSTNAME\" >> /etc/hosts"

# Configure reflector
sudo pacman -Sy reflector
sudo mkdir -p /etc/xdg/reflector && sudo cp reflector/reflector.conf /etc/xdg/reflector/reflector.conf
sudo mkdir -p /etc/pacman.d/hooks && sudo cp reflector/mirrorupgrade.hook /etc/pacman.d/hooks/mirrorupgrade.hook
sudo systemctl start reflector

# Install Yay
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd .. && rm -rf yay-bin
yay --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --noremovemake --save

# Install system apps
yay -S xorg
APPS_SYSTEM=$(cat apps-system.txt | tr '\n' ' ')
yay -S $APPS_SYSTEM
yay -R gnome-boxes

# Configure Java
sudo archlinux-java set zulu-17

# Configure user groups
sudo usermod -aG docker $USER

# Enable services
sudo systemctl enable NetworkManager
sudo systemctl enable gdm
sudo systemctl enable ufw
sudo systemctl enable docker

# Configure ufw
sudo systemctl start ufw
sudo ufw default deny
sudo ufw enable
