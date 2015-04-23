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
sudo defaults write com.apple.spaces spans-displays -bool true

echo ""
echo "Remove all default apps from the Dock"
sudo -u ${USER} defaults write com.apple.dock persistent-apps -array ''

echo ""
echo "Enable Remote Login"
systemsetup -setremotelogin on

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
sudo defaults write com.apple.finder ShowPathbar -bool true

echo ""
echo "Show status bar in Finder"
sudo defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "New Finder Windows Show Home folder"
sudo defaults write com.apple.finder NewWindowTarget -string 'PfHm'
sudo defaults write com.apple.finder NewWindowTargetPath -string "file://localhost/Users/${USER}"

echo ""
echo "Search the current folder by default"
sudo defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

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
sudo defaults write com.apple.alf.plist globalstate -integer 1

echo ""
echo "Enable tap to click"
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write com.apple.Apple.MultitouchTrackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -integer 1
sudo defaults write com.apple.mouse.tapBehaviour -integer 1

echo ""
echo "Set Desktop Background"
sudo ln -sF ../settings/images/background.png /System/Library/CoreServices/DefaultDesktop.png
sudo rm -rF /Library/Caches/com.apple.desktop.admin.png
sudo mv ../settings/images/login_background.png /Library/Caches/com.apple.desktop.admin.png

echo ""
echo "Set Screensaver Preferences"
sudo defautls write com.apple.screensaver askForPassword -integer 1

# Enable root user
echo ""
echo "Enabling root user"
sudo dsenableroot
echo -e "newyork123admin\nnewyork123admin" | passwd root

# Configure App Licenses
echo ""
echo "Configuring Microsoft Office"
sudo defaults write com.microsoft.office.licensing sequence -string ${ms_office_license_key}
