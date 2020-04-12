
function Write-Progress($message) {
    Write-Host $message -ForegroundColor Cyan
}

function Install-Prerequisites() {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Setup-Explorer() {
    Write-Progress "Show file extensions in Explorer"
    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Set-ItemProperty $key Hidden 1
    Set-ItemProperty $key HideFileExt 0
    Set-ItemProperty $key ShowSuperHidden 1
}

function Setup-Desktop() {
    Write-Progress "Only display taskbar on the main monitor"
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" MMTaskbarEnabled -Type dword 1
}

function Install-Keyboard() {
    Write-Progress "Installing Programmer Dvorak"
    choco install programmer-dvorak -y
    $LanguageList = New-WinUserLanguageList -Language en-US
    $LanguageList[0].InputMethodTips[0] = "0409:19360409"
    $LanguageList[0].InputMethodTips.Add("0409:00000409")
    Set-WinUserLanguageList $LanguageList

    Write-Progress "Mapping capslock to backspace and right shift to delete"
    Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" ScancodeMap ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x0e,0x00,0x3a,0x00,0x53,0xe0,0x36,0x00,0x00,0x00,0x00,0x00))
}

function Install-FirefoxExtension($ExtensionUrl) {
    & "C:\Program Files\Mozilla Firefox\firefox.exe" -new-tab $ExtensionUrl
}

function Install-BaseApplications() {
    Write-Progress "Installing Base Applications"
    choco install -y firefox vscode git 7zip vlc spotify windirstat sharex everything telegram
    
    Write-Progress "Installing Firefox extensions"
    Install-FirefoxExtension "https://addons.mozilla.org/firefox/downloads/file/3509837/lastpass_password_manager.xpi"
    Install-FirefoxExtension "https://addons.mozilla.org/firefox/downloads/file/3474268/ghostery_privacy_ad_blocker.xpi"

    Write-Progress "Configuring Firefox. Not implemented yet."
    $prefsFile = "%APPDATA%\Mozilla\Firefox\Profiles\*.default-release\prefs.js"
    
    Write-Progress "Configuring git."
    # TODO move this into a common file shared with linux
    git config --global alias.lb "!git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' --count=`${1:-15}"
}

function Install-PersonalApplications() {
    Write-Progress "Installing Personal Applications"
    choco install -y discord steam jetbrainstoolbox intellijidea-ultimate
    
    Install-FirefoxExtension "https://addons.mozilla.org/firefox/downloads/file/3515793/reddit_enhancement_suite.xpi",
    Install-FirefoxExtension "https://addons.mozilla.org/firefox/downloads/file/3304129/imagus.xpi"
    Install-FirefoxExtension "https://addons.mozilla.org/firefox/downloads/file/3519841/facebook_containe.xpi"
    Install-FirefoxExtension "https://addons.mozilla.org/firefox/downloads/file/3531227/honey.xpi"
}

function Install-WorkApplications() {
    Write-Progress "Installing Work Applications"
    choco install -y office-tool microsoft-teams

    & "C:\Program Files\Mozilla Firefox\firefox.exe" -new-tab "https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Enterprise&rel=16"
}

function Install-Base() {
    Install-Prerequisites
    Set-ExecutionPolicy Unrestricted -Force
    Setup-Desktop
    Setup-Explorer
    Install-BaseApplications
}

function Install-Personal() {
    Install-Base
    Install-PersonalApplications
}

function Install-Work() {
    Install-Base
    Install-WorkApplications
}

cd $PSScriptRoot
