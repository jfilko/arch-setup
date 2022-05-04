#!/bin/sh

# Install apps
APPS=$(cat apps.txt | tr '\n' ' ')
yay -S $APPS

# Configure Virtual Box
sudo systemctl enable vboxservice
sudo usermod -aG vboxusers jakub
sudo usermod -aG vboxsf jakub
