set -e

# https://apple.stackexchange.com/a/324832
# Rebind capslock to backspace and right shift to shift-delete
mkdir -p ~/Library/LaunchAgents
cp $(dirname "$0")/keyboardremap.plist ~/Library/LaunchAgents
chmod 600 ~/Library/LaunchAgents/keyboardremap.plist
launchctl load ~/Library/LaunchAgents/keyboardremap.plist

# Home/end keys go to the end of line instead of the end of the page
mkdir -p ~/Library/KeyBindings
cp $(dirname "$0")/DefaultKeyBinding.dict ~/Library/KeyBindings

$(dirname "$0")/../shared/git_setup.sh

# Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> /Users/ethanshea/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/ethanshea/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install apps
brew install --cask raycast visual-studio-code ghostty programmer-dvorak spotify

# Better git diff
# https://x.com/rauchg/status/1831421759666676165
brew install delta
git config --global core.pager "delta"
