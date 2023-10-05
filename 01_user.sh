#!/bin/sh

# Install apps
APPS=$(cat apps.txt | tr '\n' ' ')
yay -S $APPS

# Configure shell
git clone https://github.com/jakubaakk/dotfiles.git
cp dotfiles/* ~/.
cp dotfiles/.* ~/.
chsh -s /bin/zsh $USER

# Install nvm and lts node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm i --lts

# Git config
git config --global user.name 'Jakub Filko'
git config --global user.email 'jakubaakk@jakubfilko.cz'
