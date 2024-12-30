# Windows setup

Personal: 

```
# Run from admin powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/pensono/Dotfiles/master/windows/Setup.ps1')); Install-Personal
```

Work

```
# Run from admin powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/pensono/Dotfiles/master/windows/Setup.ps1')); Install-Work
```

# Mac Setup

```
# Run from Terminal
git clone https://github.com/pensono/Dotfiles.git # Developer tools will install
./Dotfiles/mac/setup.sh
```