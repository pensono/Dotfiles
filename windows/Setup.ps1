
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
    echo $PSScriptRoot\Disable_show_taskbar_on_all_displays.reg
    Invoke-Command { reg import "$PSScriptRoot\Disable_show_taskbar_on_all_displays.reg" }
}

function Install-Keyboard() {
    Write-Progress "Installing Programmer Dvorak"
    choco install programmer-dvorak -y

    Write-Progress "Mapping capslock to backspace and right shift to delete"
    Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" ScancodeMap ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x0e,0x00,0x3a,0x00,0x53,0xe0,0x36,0x00,0x00,0x00,0x00,0x00))
}

function Install-BaseApplications() {
    Write-Progress "Installing Base Applications"
    choco install -y firefox vscode git 7zip vlc spotify windirstat sharex everything telegram
    
    Write-Progress "Installing Firefox extensions"
    $extensions = 
        "https://addons.mozilla.org/firefox/downloads/file/3509837/lastpass_password_manager-4.42.0.2-fx.xpi",
        "https://addons.mozilla.org/firefox/downloads/file/3474268/ghostery_privacy_ad_blocker-8.4.6-an+fx.xpi",
        "https://addons.mozilla.org/firefox/downloads/file/3515793/reddit_enhancement_suite-5.18.11-an+fx.xpi",
        "https://addons.mozilla.org/firefox/downloads/file/3304129/imagus-0.9.8.72-fx.xpi"

    $extensions | ForEach {
        & "C:\Program Files\Mozilla Firefox\firefox.exe" -new-tab $_
    }    

    Write-Progress "Configuring Firefox. Not implemented yet."
    $prefsFile = "%APPDATA%\Mozilla\Firefox\Profiles\*.default-release\prefs.js"
    
    Write-Progress "Configuring git."
    # TODO move this into a common file shared with linux
    git config --global alias.lb "!git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' --count=`${1:-15}"
}

function Install-PersonalApplications() {
    Write-Progress "Installing Personal Applications"
    choco install -y discord steam
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
