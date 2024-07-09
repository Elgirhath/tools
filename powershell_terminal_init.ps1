winget install JanDeDobbeleer.OhMyPosh -s winget

oh-my-posh font install Meslo

if (!(Test-Path $profile)) {
    New-Item $profile -Force
}

$profileDir = Split-Path $profile -Parent

# Run this from VSCode profile aswell
Copy-Item $PSScriptRoot\profile.ps1 $profile
Copy-Item $PSScriptRoot\check.psm1 $profileDir

if ($env:TERM_PROGRAM -eq "vscode") {
    # Change font in vs code integrated terminal
    $vsCodeSettingsPath = "$($env:AppData)\Code\User\settings.json"
    
    $vsCodeSettings = Get-Content $vsCodeSettingsPath | ConvertFrom-Json
    $vsCodeSettings = [pscustomobject] @{ 
        "terminal" = [pscustomobject] @{
            "integrated" = [pscustomobject] @{
                "fontFamily" = "MesloLGL Nerd Font Mono"
            }
        }
    }
    
    $vsCodeSettings | ConvertTo-Json -Depth 20 | Out-File $vsCodeSettingsPath -Encoding utf8
}

$windowsTerminalSettingsPath = Get-ChildItem "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal*/LocalState/settings.json"
$windowsTerminalSettings = Get-Content $windowsTerminalSettingsPath | ConvertFrom-Json
$windowsTerminalSettings.profiles.defaults = [pscustomobject] @{
    "font" = [pscustomobject] @{
        "face" = "MesloLGL Nerd Font Mono"
    }
}

$windowsTerminalSettings | ConvertTo-Json -Depth 20 | Out-File $windowsTerminalSettingsPath

# Change font in other editors that use powershell

Install-Module Posh-Git -Force
