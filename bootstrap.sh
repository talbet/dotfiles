#!/usr/bin/env bash

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Updating macOS"
sudo softwareupdate -i -a

# Install command-line tools
if [[ "$(xcode-select -p)" == "" ]]; then
  echo "Installing Xcode Command Line Tools"
  xcode-select --install
fi

# Check for Homebrew, Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update # Make sure we’re using the latest Homebrew.
brew upgrade # Upgrade any already-installed formulae.

# We installed the new shell, now we have to activate it
# echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
# sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
# Change to the new shell, prompts for password
# chsh -s /usr/local/bin/zsh

if test ! $(brew bundle check); then
  echo "Installing brews..."
  brew bundle
fi

brew cleanup # Remove outdated versions