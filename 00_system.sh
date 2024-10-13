#!/bin/sh

LOG_FILE="log.txt"
CUSTOM_HOSTNAME='burrow'

#Configure hostname
echo "Configuring hostname" >> "$LOG_FILE"
sudo bash -c "echo $CUSTOM_HOSTNAME > /etc/hostname"

#Configure hosts
echo "Configuring hosts file" >> "$LOG_FILE"
sudo bash -c "echo \"127.0.0.1       localhost\" >> /etc/hosts"
sudo bash -c "echo \"::1             localhost\" >> /etc/hosts"
sudo bash -c "echo \"127.0.1.1       $CUSTOM_HOSTNAME.localdomain $CUSTOM_HOSTNAME\" >> /etc/hosts"

# Configure reflector
echo "Configuring reflector" >> "$LOG_FILE"
sudo pacman -Sy reflector
sudo mkdir -p /etc/xdg/reflector && sudo cp reflector/reflector.conf /etc/xdg/reflector/reflector.conf
sudo mkdir -p /etc/pacman.d/hooks && sudo cp reflector/mirrorupgrade.hook /etc/pacman.d/hooks/mirrorupgrade.hook

# Install Yay
echo "Installing yay" >> "$LOG_FILE"
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd .. && rm -rf yay-bin
yay --cleanmenu=false --diffmenu=false --editmenu=false --noremovemake --save

# Install system apps
echo "Installing xorg" >> "$LOG_FILE"
yay -S xorg xorg-server

echo "Installing system apps" >> "$LOG_FILE"
APPS_SYSTEM=$(cat apps-system.txt | tr '\n' ' ')
yay -S $APPS_SYSTEM

echo "Installing GPU apps" >> "$LOG_FILE"
APPS_GPU=$(cat apps-gpu.txt | tr '\n' ' ')
yay -S $APPS_GPU

echo "Installing dev apps" >> "$LOG_FILE"
APPS_DEV=$(cat apps-dev.txt | tr '\n' ' ')
yay -S $APPS_DEV

echo "Installing generic apps" >> "$LOG_FILE"
APPS_GENERIC=$(cat apps-generic.txt | tr '\n' ' ')
yay -S $APPS_GENERIC

# Configure Java
echo "Configuring Java" >> "$LOG_FILE"
sudo archlinux-java set zulu-11

# Configure user groups
echo "Configuring user groups" >> "$LOG_FILE"
sudo usermod -aG docker $USER

# Enable services
echo "Enabling services" >> "$LOG_FILE"
sudo systemctl enable NetworkManager
sudo systemctl enable sddm
sudo systemctl enable ufw
sudo systemctl enable docker
sudo systemctl enable lactd

# Configure ufw
echo "Configuring ufw" >> "$LOG_FILE"
sudo ufw default deny
sudo ufw enable
