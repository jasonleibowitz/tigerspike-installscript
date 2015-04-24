install_dmg () {
  echo 'Hark, a dmg!'
  file_name="$1"
  MOUNTPOINT="/Volumes/MountPoint"
  IFS="
  "
  hdiutil attach -mountpoint $MOUNTPOINT "$file_name.dmg"
  app=$(find $MOUNTPOINT 2>/dev/null -maxdepth 2 -iname \*.app)
  if [ ! -z "$app" ]; then
    cp -a "$app" /Applications/
  # for app in `find $MOUNTPOINT -type d -maxdepth 2 -name \*.app `; do
  # done
  fi
  echo 'Hark! A pkg!'
  pkg=$(find $MOUNTPOINT 2>/dev/null -maxdepth 2 -iname \*.pkg)
  if [ ! -z "$pkg" ]; then
    # PL: Need to handle harddrive names that aren't Macintosh HD
    sudo installer -package $pkg -target /
  fi
  hdiutil detach $MOUNTPOINT
}

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

echo "Installing Project Manager apps..."
brew cask install -appdir="/Applications" ${pmapps[@]}

echo "Giving alfred directions to the apps..."
brew cask alfred link

echo "Installing Printer Driver"
install_dmg ../settings/drivers/UFRII_v10.06.00_Mac
