set -ex

# https://apple.stackexchange.com/a/324832
# Rebind capslock to backspace and right shift to shift-delete
mkdir -p ~/Library/LaunchAgents
cp $(dirname "$0")/keyboardremap.plist ~/Library/LaunchAgents
chmod 600 ~/Library/LaunchAgents/keyboardremap.plist
launchctl load ~/Library/LaunchAgents/keyboardremap.plist

# Home/end keys go to the end of line instead of the end of the page
mkdir -p ~/Library/KeyBindings
cp $(dirname "$0")/DefaultKeyBinding.dict ~/Library/KeyBindings

# fn keys work by default
defaults write -g com.apple.keyboard.fnState -boolean false
# Globe key activates emoji picker
defaults write -g PressFunctionKey -int 4

$(dirname "$0")/../shared/git_setup.sh

# Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> /Users/ethanshea/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/ethanshea/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install apps
brew install --cask raycast visual-studio-code ghostty programmer-dvorak spotify cursor google-chrome bitwarden rectangle notion
brew install gh

# Better git diff
# https://x.com/rauchg/status/1831421759666676165
brew install delta
git config --global core.pager "delta"

# Setup GitHub ssh key
ssh-keygen -t ed25519 -C "ethan.shea1@gmail.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
gh auth login

echo "Host github.com" >> ~/.ssh/config
echo "  AddKeysToAgent yes" >> ~/.ssh/config
echo "  UseKeychain yes" >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config


if ! [ -x "$(command -v nvm)" ]; then
    # https://nodejs.org/en/download
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    # Post-install
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # Install latest node
    nvm install node
fi

# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
source /Users/ethan/.zshrc

