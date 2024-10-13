#!/bin/sh

LOG_FILE="log.txt"

# Install apps
echo "Installing user apps" >> "$LOG_FILE"
APPS=$(cat apps.txt | tr '\n' ' ')
yay -S $APPS

# Configure shell
echo "Configuring shell" >> "$LOG_FILE"
git clone https://github.com/jfilko/dotfiles.git
cp dotfiles/* ~/.
cp dotfiles/.* ~/.
chsh -s /bin/zsh $USER

# Install nvm and lts node
echo "Installing nvm and lts node" >> "$LOG_FILE"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm i --lts
