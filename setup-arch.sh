#!/usr/bin/env bash

set -e

# 
echo '[+] Updating pacman...'
sudo pacman -Syu --noconfirm

# 
echo '[+] Installing base packages...'
sudo pacman -S --noconfirm \
  base-devel \
  curl \
  unzip \
  zip \
  htop \

echo '[+] Installing yay (AUR helper)...'
if ! command -v yay >/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

echo '[+] Installing tools with yay...'
yay -S --noconfirm \
  stow \
  nano \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  zsh-syntax-highlighting \
  docker \
  docker-compose \
  vivaldi \
  discord \
  vesktop \
  spotify \
  asdf-vm \
  vscodium \
  
# 
echo '[+] Dotfiles setting...'
cd dotfiles
sudo stow -t / ROOT --adopt
stow -t ~ USER --adopt
cd ..

# 
echo '[+] ZSH setting...'
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# 
echo '[+] Installing asdf plugins...'
. "$HOME/.asdf/asdf.sh"
 
asdf plugin-add nodejs || true
asdf plugin-add python || true
asdf plugin-add dotnet-core || true

# 
echo '[+] Setup finished'
chsh -s $(which zsh)
echo '[+] To start zsh now, run: exec zsh'
zsh
