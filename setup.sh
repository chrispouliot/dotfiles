#!/bin/bash

function ask_confirm {
	read -p "Install and setup $1? " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return 0
    else
        return 1
    fi
}

echo "Starting setup.."


# ------
# TOOLING
# ------
if ask_confirm "Install tooling"; then
	app_name=Xcode
	read -p "Download $app_name from the Apple Store. Hit Enter to continue.."
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name dev tools.."
		xcode-select --install
	fi


	echo "Installing Homebrew.."

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap caskroom/cask
	brew tap caskroom/drivers

	echo "Installing zsh.."

	brew install zsh zsh-completions
	ln zshrc ~/.zshrc

	echo "Installing pyenv and pyenv-virtualenv.."

	brew install pyenv
	brew install pyenv-virtualenv

	echo "Installing nvm.."

	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

	echo "Installing thefuck.."

	brew install thefuck

	echo "Installing Heroku toolbelt.."

	brew install heroku/brew/heroku

	echo "Installing awscli.."

	brew install awscli

	echo "Installing GNU Grep.."

	brew install grep
fi


# -----------------
# APPS AND SETTINGS
# -----------------
app_name="Visual Studio Code"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install visual-studio-code
	fi
	read -p "Open $app_name and go to settings so the directory exists. Hit enter to continue.."
	echo "Hard linking vscode settings.."
	ln -f vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json
fi

app_name="Hyper"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install hyper
	fi
	echo "Hard linking $app_name settings.."
	ln -f hyper.js ~/.hyper.js
fi


app_name="1Password"
if ask_confirm $app_name; then
	read -p "Download $app_name from the Apple Store so the licence is present then delete it. Hit Enter to continue.."
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install 1password
	fi
fi


app_name="Spotify"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install spotify
	fi
fi


app_name="Google Play Music Desktop Player"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install google-play-music-desktop-player
	fi
fi


app_name="VLC"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install vlc
	fi
fi


app_name="Zoom.us"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install zoomus
	fi
fi


app_name="Rambox"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install rambox
	fi
fi


app_name="Docker"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install docker
	fi
fi

app_name="SteelSeries ExactMouse Tool"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install steelseries-exactmouse-tool
	fi
fi

app_name="Bartender 2"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew cask install bartender
	fi
	echo "Hard linking $app_name settings.."
	ln -f bartender.plist ~/Library/Preferences/com.surteesstudios.Bartender.plist
fi


app_name="Chunkwm"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew tap crisidev/homebrew-chunkwm
		brew install chunkwm
	fi

	echo "Hard linking $app_name settings.."

	ln -f chunkwmrc ~/.chunkwmrc
	brew services start chunkwm
fi

app_name="khd"
if ask_confirm $app_name; then
	if ! open -Ra $app_name 2>/dev/null; then
		echo "Installing $app_name.."
		brew install koekeishiya/formulae/khd
	fi

	echo "Hard linking $app_name settings.."

	ln -f khdrc ~/.khdrc
	brew services start khd
fi

# ------------
# GIT AND GIT SO FANCY
# ------------

ln -f gitignore ~/.gitignore
git config --global core.excludesfile ~/.gitignore

brew install diff-so-fancy

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true

git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta "227"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "227 bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"


# ------------
# PRIVATE KEYS
# ------------


read -p 'Local machine user@ip to copy uncommitted files: ' localvar

ssh-copy-id $localvar

# -p preserves modified dates, -r recursive

scp -p $localvar:~/.ssh/config ~/.ssh/config

scp -p $localvar:~/.netrc ~/.netrc

scp -p $localvar:~/.zsh_history ~/.zsh_history

scp -rp $localvar:~/.LocalMusic ~/.LocalMusic


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

# Spotlight icon and helper
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

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
