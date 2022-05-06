#!/bin/sh

# catch error
set -e

# Ask for the administrator password upfront
sudo -v

# Installation Homebrew
echo "Starting Homebrew Installation..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Homebrew Installation: Completed"

touch ~/.zprofile
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)

# Installation of formulas
echo 'Starting formulas installation...'
brew install git
brew install zsh
brew install marp-cli
brew install pandoc
brew install postgresql
brew install pyenv
brew install mas
echo 'Formulas installation completed'

# Installation of casks
echo 'Starting casks installation...'
brew install discord --cask
brew install google-chrome --cask
brew install google-drive --cask
brew install iterm2 --cask
brew install slack --cask
brew install spotify --cask
brew install zoom --cask
brew install visual-studio-code --cask
brew install mysides
echo 'Casks installation completed'

################################################################################

### Computer/Host Name ###
echo 'Setting up System Preference...'
sudo scutil --set ComputerName "$HOME"
sudo -S scutil --set HostName "$HOME.HOST"

### Finder ###
# Finder sidebar
# mysides add $HOME file://$HOME/
# mysides remove Desktop
# mysides remove Documents

# Delete tags from sidebar
defaults write com.apple.finder ShowRecentTags -bool false

# Change default view as column
defaults write com.apple.finder FXPreferredViewStyle clmv

# Set $HOME as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

# Show Status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show Path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Place the folders top
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Enable File animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Enable Folder animations
defaults write com.apple.finder AnimateWindowZoom -bool false

# Enable all animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

## Finder Settings

# Open new folder not tab
defaults write com.apple.finder FinderSpawnTab -bool false

# Display calculateAllSizes (Useful for list view)
defaults write com.apple.finder calculateAllSizes -bool true

# Set search scope
	# This Mac: 'SCev'
	# Current Folder: 'SCcf'
	# Previous Scope: 'SCsp'
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

## Restart finder

killall Finder
echo "Restarting Finder after 5s..."
sleep 5

### End of Finder Setting ###

### Dock ###
# Show recents apps on the Dock
defaults write com.apple.dock show-recents -bool false

# Set the icon size
defaults write com.apple.dock tilesize -int 40

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

### End of Dock Setting ###

### Launchpad ###
# change columns and rows
defaults write com.apple.dock springboard-columns -int 10
defaults write com.apple.dock springboard-rows -int 8

# Reset LaunchPad (Hash)
defaults write com.apple.dock ResetLaunchPad -bool true

### End of Launchpad ###

### Mission Control ###
# Group windows by application
defaults write com.apple.dock expose-group-apps 1

# Automatically rearrange Spaces based on most resent use
defaults write com.apple.dock mru-spaces -bool false



### Hot corners ###
# Possible values:
    # 0: no-op
    # 2: Mission Control
    # 3: Show application windows
    # 4: Desktop
    # 5: Start screen saver
    # 6: Disable screen saver
    # 7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # 13: Lock Screen

# Top left screen corner -> Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner -> Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner -> Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner -> Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

### End of Hot corners ###

killall Dock
echo "Refreshing Dock after 5s..."
sleep 5

### System UI ###
## Status bar
# Display battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string true

# Change clock format
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"

# Display items
defaults write com.apple.systemuiserver menuExtras -array \
"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
"/System/Library/CoreServices/Menu Extras/Battery.menu" \
"/System/Library/CoreServices/Menu Extras/Clock.menu" \
"/System/Library/CoreServices/Menu Extras/Displays.menu" \
"/System/Library/CoreServices/Menu Extras/Volume.menu"

## Keyboard
# Nothing

killall SystemUIServer
echo "Refresh SystemUIServer after 5s..."
sleep 5

### End of System UI ###

### Trackpad ###
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad Scroll Direction
defaults write -g com.apple.swipescrolldirection -int 0

### End of Trackpad ###

### Text Input ###
# Enable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Enable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable text-completion
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false

### End of Text Input ###

### Set Default Browser ###
# Set chrome as default browser
open -a "Google Chrome" --args --make-default-browser
# read -p "Setup Google Chrome. Press [Enter] key to resume setup..."

### End of Set Default Browser ###

### Other ###
# Upgrade quality of Bluetooth Audio
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (ediitable)" -int 40ss

# Sound (Screenshot, Trash and etc...)
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

# Display cashe
dscacheutil -flushcache

### End of Other ###

# Reboot Dock, Finder and SystemUIServer
sudo killall Dock
sudo killall Finder
sudo killall SystemUIServer
sudo killall Dock
echo "Rebooting all above-metioned after 5s..."
sleep 5
echo "Setting up System Preference: Complete"

################################################################################

### Setup pyenv ###
# make .zshrc
touch ~/.zshrc

# set pyenv on zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# source .zshrc
source ~/.zshrc

### End of puenv ###

### Install miniforge ###
pyenv install miniforge3-4.10.3-10
pyenv global miniforge3-4.10.3-10

# Enable auto_activate_base
conda config --set auto_activate_base false

### End of miniforge ###

# make .zshrc
echo 'source ~/.pyenv/versions/miniforge3-4.10.3-10/bin/activate' >> ~/.zshrc

source ~/.zshrc

### Setup .zprofile ###

echo "Setting up ~/.zprofile..."

touch ~/.zprofile
cat <<EOS > ~/.zprofile
# brew
eval $(/opt/homebrew/bin/brew shellenv)
# Environment
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
EOS
echo "Setting up ~/.zprofile: Complete"
### End of .zprofile ###

### Install from Appstore ###
echo "Installing Apps from AppStore using mas command..."
echo "Please login with your Apple ID."
open -a "App Store"
read -p "Press [Enter] key to resume setup..."

# mas install 408981434  # imovie
# mas install 409183694  # keynote
# mas install 409201541  # pages
# mas install 409203825  # numbers
# mas install 441258766  # Magnet
# mas install 485812721  # TweetDeck
# mas install 497799835  # Xcode
# mas install 1444383602 # GoodNotes
# mas install 462054704  # Microsoft Word
# mas install 462058435  # Microsoft Excel
# mas install 462062816  # Microsoft PowerPoint
# mas install 936243210  # MiniPlay for Spotify & iTunes

echo "Installing Apps from AppStore Completde"

echo "Congraturations... All DONE!!!"
echo "<<< macOS Environment Configurator from Ryuichi Hirano(based on tyl's) >>>"
echo "END....."
echo "Reboot machine 10s later..."
sleep 10
sudo shutdown -r now
