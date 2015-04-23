# Copy over settings and back up bashprofile

# Back up bash_profile and copy over new one
touch ~/.bash_profile
cp ~/.bash_profile{,.bak}

beget () {
  setting=$1
  echo "Moving $setting..."
  cp "$SETTINGS/dotfiles/$setting" "${HOME}/.$setting"
}

beget bash_profile

source ~/.bash_profile
