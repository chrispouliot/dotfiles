#!/bin/bash


# TOOLING


echo "Starting setup.."

echo "Installing Homebrew.."

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

echo "Installing zsh.."

brew install zsh zsh-completions

echo "Installing oh my zsh.."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing pyenv and pyenv-virtualenv.."

brew install pyenv
brew install pyenv-virtualenv

echo "Installing nvm.."

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

echo "Installing thefuck.."

brew install thefuck


# APPS


echo "Installing vscode.."

brew cask install visual-studio-code

echo "Installing hyper.."

brew cask install hyper


# APP SETTINGS


echo "Hard linking vscode settings.."

ln vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json

echo "Hard linking zshrc.."

ln zshrc ~/.zshrc

echo "Hard linking hyper settings.."

ln hyper.js ~/.hyper.js


# PRIVATE KEYS


read -sp 'Local machine user/ip to copy ssh and netrc files: ' localvar

ssh-copy-id $localvar

scp $localvar:~/.ssh/config ~/.ssh/config

scp $localvar:~/.netrc ~/.nerc