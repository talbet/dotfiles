#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
echo "Run as admin for best results"
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
brew install coreutils
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install ZSH.
brew install zsh
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/zsh

# Install wget
brew install wget

# # Install Python
# brew install python
# brew install python3

# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv

# Install other useful binaries.
brew install ack
brew install dark-mode
brew install git
brew install lolcat
brew install openssl
brew install ssh-copy-id
brew install stow
brew install svgo
brew install thefuck
brew install tree
brew install youtube-dl

# Tap Homebrew Cask
brew tap caskroom/cask
brew tap caskroom/fonts

# Add fonts
brew cask install font-hasklig
brew cask install font-source-code-pro
brew cask install font-sourcecodepro-nerd-font

# Core casks
brew cask install 1password
brew cask install awareness
brew cask install bartender
brew cask install bettertouchtool
brew cask install contexts
brew cask install dash
brew cask install flux
brew cask install karabiner-elements
brew cask install path-finder
brew cask install spotify

# Development tool casks
brew cask install iterm2
brew cask install visual-studio-code

# Misc casks
brew cask install google-chrome
brew cask install firefox
brew cask install macdown
brew cask install mplayerx
brew cask install numi
brew cask install slack
brew cask install itsycal

# Disk casks
brew cask install dropbox
brew cask install google-drive-file-stream

# Remove outdated versions from the cellar.
brew cleanup