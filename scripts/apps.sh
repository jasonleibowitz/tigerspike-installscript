#!/bin/bash

# Tigerspike Classics
apps=(
	google-drive
	google-chrome
	google-hangouts
	alfred
	clamxav
	microsoft-office
	qlcolorcode
	qlmarkdown
	qlprettypatch
	qlstephen
	quicklook-json
	chromecast
)

# Product Manager Apps
pmapps=(
	omnigraffle
	omniplan
)

echo "Installing Tigerspike classic apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# To Do: Conditional apps for pm vs ux vs whatever else - JL
echo "Installing Project Manager apps..."
brew cask install --appdir="/Applications" ${pmapps[@]}

echo "Giving alfred directions to the apps..."
brew cask alfred link
