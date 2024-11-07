#!/bin/bash

# Essentials
brew install curl 
brew install wget 
brew install stow 
brew install git 
brew install neovim 
brew install starship 
brew install --cask raycast
brew install --cask wezterm 
brew install --cask font-caskaydia-cove-nerd-font
brew install --cask nikitabobko/tap/aerospace
brew install gh

# Tools
brew install fd
brew install sd
brew install eza
brew install zoxide
brew install bat
brew install ripgrep
brew install duf
brew install btop
brew install tldr
brew install gping
brew install thefuck
brew install fastfetch
brew install tre-command
brew install ack
brew install bash-completion
brew install jq
brew install htop
brew install coreutils
brew install watch
brew install ngrok

# Python
curl https://pyenv.run | bash
curl -sSL https://install.python-poetry.org | python3 -
curl -LsSf https://astral.sh/uv/install.sh | sh

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Mojo
curl -ssL https://magic.modular.com/b248c712-4a3f-4b57-b3f1-62fe7248e1cd | bash


# Misc.
brew install --cask visual-studio-code
brew install --cask bruno
brew install --cask google-chrome
brew install --cask firefox
brew install --cask obsidian
brew install --cask spotify
brew install --cask windows-app
brew install --cask slack
brew install --cask whatsapp
brew install --cask discord
brew install --cask beekeeper-studio

# Docker
brew install --cask docker
brew install bash-completion
brew install docker-completion
brew install docker-compose-completion
brew install docker-machine
brew install docker-machine-completion

# AWS command line
brew install awscli # Official command line
pip3 install saws    # A supercharged AWS command line interface (CLI).

# terraform
brew install terraform

# K8S command line
brew install kubectx
brew install asdf
asdf install kubectl latest

