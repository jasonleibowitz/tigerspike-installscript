echo "Setting Solorized Colors for Terminal..."
open "$SETTINGS/dotfiles/Solarized Dark.terminal"
sleep 1
defaults write com.apple.terminal "Default Window Settings" -string "Solarized Dark"
defaults write com.apple.terminal "Startup Window Settings" -string "Solarized Dark"
