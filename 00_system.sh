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
yay -S xorg xorg-server
APPS_SYSTEM=$(cat apps-system.txt | tr '\n' ' ')
yay -S $APPS_SYSTEM

# Configure Java
sudo archlinux-java set zulu-17

# Configure user groups
sudo usermod -aG docker $USER

# Enable services
sudo systemctl enable NetworkManager
sudo systemctl enable sddm
sudo systemctl enable haveged
sudo systemctl enable ufw
sudo systemctl enable docker

# Configure ufw
sudo systemctl start ufw
sudo ufw default deny
sudo ufw enable

# Battle.net WINE
sudo yay -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
