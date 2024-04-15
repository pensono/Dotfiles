# https://apple.stackexchange.com/a/324832
# Rebind capslock to backspace and right shift to shift-delete
mkdir ~/Library/LaunchAgent
cp $(dirname "$0")/keyboardremap.plist ~/Library/LaunchAgent
chmod 600 ~/Library/LaunchAgents/keyboardremap.plist
launchctl load ~/Library/LaunchAgents/keyboardremap.plist

# Home/end keys go to the end of line instead of the end of the page
mkdir -p ~/Library/KeyBindings
cp $(dirname "$0")/DefaultKeyBinding.dict ~/Library/KeyBindings

$(dirname "$0")/../shared/git_setup.sh

# Install apps
brew install --cask raycast
