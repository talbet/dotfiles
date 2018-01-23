#!/usr/bin/env bash

brew install pow
brew cask install anvil
brew cask install ccmenu
brew cask install launchrocket
brew cask install tableplus
brew cask install tmux
brew cask install overmind

# Hotels setup
brew install postgis
brew install redis
brew install imagemagick
brew install ruby-build
brew install rbenv
brew install v8

brew services start postgresql
brew services start redis

rbenv install 2.3.3

# Extras
# brew cask install eqmac
# brew cask install daisydisk
# brew cask install insomnia
# brew cask install gitscout
# brew cask install sip
# brew cask install typora
# brew cask install virtualbox

