#!/bin/bash

# This script installs homebrew, our package manager
# http://brew.sh/

function install_or_update_brew () {
  $(which -s brew)
  if [[ $? != 0 ]]; then
      echo ''
      echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
      echo ''
      echo 'Brew is already installed. Running Homebrew Updates...'
      brew update
      brew doctor
  fi
}

install_or_update_brew

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Tigerspike Classics
brew install git
brew install blueutil
brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Tap a new formula repository from GitHub, or list existing taps
brew tap homebrew/versions

# Ensures all tapped formula are symlinked into Library/Formula
# and prunes dead formula from Library/Formula
brew tap --repair

# Remove outdated versions from the cellar
brew cleanup
