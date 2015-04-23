#  _   _                           _ _
# | |_(_) __ _  ___ _ __ ___ _ __ (_) | _____
# | __| |/ _` |/ _ \ '__/ __| '_ \| | |/ / _ \
# | |_| | (_| |  __/ |  \__ \ |_) | |   <  __/
#  \__|_|\__, |\___|_|  |___/ .__/|_|_|\_\___|
#        |___/              |_|
#
#  _           _        _ _                 _       _
# (_)_ __  ___| |_ __ _| | |  ___  ___ _ __(_)_ __ | |_
# | | '_ \/ __| __/ _` | | | / __|/ __| '__| | '_ \| __|
# | | | | \__ \ || (_| | | | \__ \ (__| |  | | |_) | |_
# |_|_| |_|___/\__\__,_|_|_| |___/\___|_|  |_| .__/ \__|
#                                            |_|
#
# Automation Script for setting up a Mac at Tigerspike
#

osx_version=$(sw_vers -productVersion)
SRC_DIR=~/.installscript
SCRIPTS=$SRC_DIR/scripts
SETTINGS=$SRC_DIR/settings
INSTALL_REPO=https://github.com/jasonleibowitz/installfest_scripts.git

# Functions

function pause_awhile () {
   read -p "$* Press Enter to continue"
}

# Get Variables from user
read -p "Enter the user's full name: "	user_name
read -p "Enter this computer's AssetID: " asset_id
read -p "Enter the license for MS Office" ms_office_license_key

# To Do: Add support to older version other than just Yosemite - JL

# Check if Command Line Tools are installed, if not install them.

if [ $(xcode-select -p) == /Library/Developer/CommandLineTools ];
then
	echo "Command Line Tools are installed"
else
	echo "Command Line Tools are not installed. Installing now."
	xcode-select --install
fi

# clear terminal screen

echo "We are going to need your sudo password"
sudo echo "Thanks"

# Keep-alive: update existing 'sudo' time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null

# Ensure we're updated and in control of the home folder
echo "Let's make sure we have full control of your user folder."
echo "This may take a while."
sudo chown -R ${USER} ~
diskutil repairPermissions /
echo "Checking for recommended software updates."
echo "This may require a restart."
sudo softwareupdate -i -r --ignore iTunes
sudo chown -R ${USER} ~

# Download the repo for the absolute paths
if [[ ! -d $SRC_DIR ]]; then
	echo "Downloading Installscript repo..."
	git clone $INSTALL_REPO $SRC_DIR
	# hide folder
	chflags hidden $SRC_DIR
else
	# update repo
	echo "Updating repo..."
	cd $SRC_DIR
	git pull origin master
fi

# Install homebrew and formulae
pause_awhile "Installing our Package Manager Homebrew"
source $SCRIPTS/brew.sh

# Additional settings and bash_profile
pause_awhile "Config settings for terminal"
source $SCRIPTS/settings.sh

# Apps
pause_awhile "Installing applications for development"
source $SCRIPT/apps.sh

# Setting Terminal Colors
pause_awhile "Setting Terminal Settings"
source $SCRIPT/terminal.sh

# Tigerspike OSX Settings
pause_awhile "Updating System Settings"
source $SCRIPT/osx_settings.sh

source ~/.bash_profile
