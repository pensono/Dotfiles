# https://apple.stackexchange.com/a/324832
# Rebind capslock to backspace and right shift to shift-delete
mkdir ~/Library/LaunchAgent
cp keyboardremap.plist ~/Library/LaunchAgent
chmod 600 ~/Library/LaunchAgents/keyboardremap.plist
launchctl load ~/Library/LaunchAgents/keyboardremap.plist

$(dirname "$0")/../shared/git_setup.sh
