#!/usr/bin/env bash

# Become super user before starting work
sudo -v

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
if [[ ! $(which brew) ]]; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

# brew bundle check || brew bundle
if [[ $(brew bundle check) ]]; then
  echo "Installing brews..."
  brew bundle
fi

# Remove outdated versions
brew cleanup

# Node setup
yarn global upgrade --silent
yarn global add npm-check --silent
yarn global add create-react-app --silent
yarn global add create-component-app --silent
yarn global add mrm --silent

# Add fish to the list of shells
if [[ ! $(grep /usr/local/bin/fish /etc/shells) ]]; then
 echo "Adding fish to the list of allowed shells"
 echo "/usr/local/bin/fish" | sudo tee -a /etc/shells > /dev/null
fi

# Add zsh to the list of shells
if [[ ! $(grep /usr/local/bin/zsh /etc/shells) ]]; then
 echo "Adding zsh to the list of allowed shells"
 echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells > /dev/null
fi

# Change to the new shell if required
if [[ ! "$SHELL" == "/usr/local/bin/fish" ]]; then
  sudo chsh -s /usr/local/bin/fish $USER
fi
