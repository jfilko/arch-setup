#!/bin/sh

# Configure ufw
sudo systemctl start ufw
sudo ufw default deny
sudo ufw enable

# Install apps
APPS=$(cat apps.txt | tr '\n' ' ')
yay -S $APPS
