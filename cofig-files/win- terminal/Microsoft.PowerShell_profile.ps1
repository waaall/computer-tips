#===============================设置别名=====================================
# Remove-Item alias:\wget
# Remove-Item alias:\curl
# Set-Alias -Name st -Value 'C:\Program Files\Sublime Text 3\sublime_text.exe'
#Set-Alias -Name vs -Value 'C:\Program Files\Microsoft VS Code\code.exe'

#===============================导入插件=====================================
Import-Module PSReadLine

Import-Module posh-git

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\zash.omp.json" | Invoke-Expression

#===============================导入zoxide====================================
# Invoke-Expression (& { (zoxide init powershell | Out-String) })
