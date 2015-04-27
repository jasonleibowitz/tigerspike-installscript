#!/bin/bash
# sudo opensnoop -n cfprefsd

# This will configure the machine to follow Tigerspike defaults

echo "This script will make your Mac awesome!"

echo ""
echo "Automatically quit the printer app once the print job is complete"
sudo defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo ""
echo "Avoid Creating DS_Store files on Network Volumes"
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Save screenshots in PNG format"
sudo defaults write com.apple.screencapture type -string 'png'

echo ""
echo "Save screenshots to the desktop"
sudo defaults write com.apple.screencapture location -string '~/Desktop'

echo ""
echo "Disable Disk Image Verification"
sudo defaults write com.apple.frameworks.diskimages skip-verify -bool true
sudo defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
sudo defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo ""
echo "Displays do not have separate Spaces"
sudo defaults write ~/Library/Preferences/com.apple.spaces.plist spans-displays -bool true
sudo chmod 775 ~/Library/Preferences/com.apple.spaces.plist

echo ""
echo "Remove all default apps from the Dock"
sudo -u ${USER} defaults write com.apple.dock persistent-apps -array ''

echo ""
echo "Enable Remote Login"
systemsetup -setremotelogin on

echo ""
echo "Enable Screen Sharing"
# sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
# sudo launchctl load /System/Library/LaunchDaemons/com.apple.screensharing.plist
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -off -restart -agent -privs -all -allowAccessFor -allUsers

echo ""
echo "Expand Print Panel by Default"
sudo defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo ""
echo "Expand Save Panel by Default"
sudo defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo ""
echo "Allow text select in Quick Look"
sudo defaults write com.apple.finder QLEnableTextSelection -bool true

echo ""
echo "Disable the warning before emptying the Trash"
sudo defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo ""
echo "Display Full Path in Finder"
sudo defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo ""
echo "Show Path Bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo ""
echo "Show status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "Show Sidebar in Finder"
defaults write com.apple.finder ShowSidebar -bool true

echo ""
echo "New Finder Windows Show Home folder"
defaults write com.apple.finder NewWindowTargetPath -string "~/"
defaults write com.apple.finder NewWindowTarget -string "PfHm"

echo ""
echo "Search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo ""
echo "Use list view in all Finder windows by default"
sudo defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo ""
echo "Add battery percentage in menubar"
sudo defaults write com.apple.menuextra.battery ShowPercent -string "YES"

echo ""
echo "Prevent Time Machine from prompting to use hard drives as backup volumes"
sudo defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo ""
echo "Save to disk (not to iCloud) by default"
sudo defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo ""
echo "Display login window as name and password"
sudo defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool true

echo ""
echo "Set apperance color to graphite"
sudo defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleAquaColorVariant -integer 6

echo ""
echo "Turn on Firewall"
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

echo ""
echo "Enable tap to click"
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write com.apple.Apple.MultitouchTrackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -integer 1
sudo defaults write com.apple.mouse.tapBehaviour -integer 1

echo ""
echo "Turn off Bluetooth"
blueutil power 0

echo ""
echo "Set Desktop Background"
sudo cp -sF settings/images/background.png /System/Library/CoreServices/DefaultDesktop.jpg
sudo rm -rF /Library/Caches/com.apple.desktop.admin.png
sudo cp settings/images/login_background.png /Library/Caches/com.apple.desktop.admin.png

echo ""
echo "Set Screensaver Preferences"
defaults write com.apple.screensaver askForPassword -integer 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable root user
echo ""
echo "Enabling root user"
sudo dsenableroot -u ${USER} -p newyork123 -r newyork123admin

# Configure App Licenses
# echo ""
# echo "Configuring Microsoft Office"
# sudo defaults write com.microsoft.office.licensing sequence -string ${ms_office_license_key}

# Configure Printer
# http://d43.me/blog/1826/add-a-printer-via-command-line-in-os-x/
echo ""
echo "Configuring Printer"
lpadmin -E -p "Canon_5030" -v "lpd://192.168.1.20/" -P "../settings/drivers/Canon_5030.ppd" -o printer-is-shared=false; cupsenable "Canon_5030"; cupsaccept "Canon_5030"

# Set Computer Name to Asset ID
echo ""
echo "Setting Computer Name to AssetID"
sudo scutil --set HostName ${asset_id}
sudo scutil --set LocalHostName ${asset_id}
sudo scutil --set ComputerName ${asset_id}
dscacheutil -flushcache
