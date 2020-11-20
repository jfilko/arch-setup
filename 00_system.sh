#!/bin/sh

# Configure reflector
sudo pacman -S reflector
sudo mkdir -p /etc/xdg/reflector && sudo cp reflector/reflector.conf /etc/xdg/reflector/reflector.conf
sudo mkdir -p /etc/pacman.d/hooks && sudo cp reflector/mirrorupgrade.hook /etc/pacman.d/hooks/mirrorupgrade.hook
sudo systemctl start reflector

# Install Yay
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd .. && rm -rf yay-bin
yay --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --noremovemake --save


# Install system apps
# yay -S xorg xorg-server
APPS_SYSTEM=$(cat apps-system.txt | tr '\n' ' ')
yay -S $APPS_SYSTEM

# Configure user groups
sudo usermod -aG docker $USER

# Enable services
sudo systemctl enable NetworkManager
sudo systemctl enable sddm
sudo systemctl enable ufw
# sudo systemctl enable haveged
# sudo systemctl enable tlp
sudo systemctl enable docker
# sudo systemctl enable ModemManager
# sudo systemctl enable bluetooth
