winget install JanDeDobbeleer.OhMyPosh -s winget

oh-my-posh font install Meslo

# Run this from VSCode profile aswell
Copy-Item $PSScriptRoot\profile.ps1 $profile


# Change font in vs code integrated terminal
$vsCodeSettingsPath = "$($env:AppData)\Code\User\settings.json"

$vsCodeSettings = Get-Content $vsCodeSettingsPath | ConvertFrom-Json
$vsCodeSettings.'terminal.integrated.fontFamily' = "MesloLGL Nerd Font Mono"

$vsCodeSettings | ConvertTo-Json | Out-File $vsCodeSettingsPath

# Change font in other editors that use powershell
