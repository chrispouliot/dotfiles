#!/bin/bash

# ------
# TOOLING
# ------


echo "Starting setup.."

echo "Installing Homebrew.."

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

echo "Installing zsh.."

brew install zsh zsh-completions

echo "Installing pyenv and pyenv-virtualenv.."

brew install pyenv
brew install pyenv-virtualenv

echo "Installing nvm.."

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

echo "Installing thefuck.."

brew install thefuck


# -----------------
# APPS AND SETTINGS
# -----------------


if ! open -Ra "Visual Studio Code" 2>/dev/null; then
  echo "Installing vscode.."
  brew cask install visual-studio-code
fi

read -p "Open VSCode and go to settings. Hit enter to continue.."
echo "Hard linking vscode settings.."

ln vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json


if ! open -Ra "Hyper" 2>/dev/null; then
    echo "Installing hyper.."
    brew cask install hyper
fi

echo "Hard linking hyper settings.."

rm ~/.hyper.js 2>/dev/null
ln hyper.js ~/.hyper.js


if ! open -Ra "spectacle" 2>/dev/null; then
    echo "Installing spectacle.."
    brew cask install spectacle
fi

echo "Hard linking spectacle settings.."
rm ~/Library/Application\ Support/Spectacle/Shortcuts.json 2>/dev/null
ln spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json


echo "Hard linking zshrc.."

ln zshrc ~/.zshrc


# ------------
# PRIVATE KEYS
# ------------


read -p 'Local machine user/ip to copy ssh and netrc files: ' localvar

ssh-copy-id $localvar

scp $localvar:~/.ssh/config ~/.ssh/config

scp $localvar:~/.netrc ~/.nerc


# -------------
# macOS changes
# -------------
# Many taken from https://github.com/mathiasbynens/dotfiles


# Auto hide dock and set huge show delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 99999 && killall Dock

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

killall "Finder" &> /dev/null

# Spotlight search
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null


# ----------------------------------------------
# OH MY ZSH (last because it changes the prompt)
# ----------------------------------------------


echo "Installing oh my zsh.."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"