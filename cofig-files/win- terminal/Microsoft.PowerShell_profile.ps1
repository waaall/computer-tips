#===============================设置别名=====================================
Remove-Item alias:\wget
Remove-Item alias:\curl
Set-Alias -Name st -Value 'C:\Program Files\Sublime Text 3\sublime_text.exe'

#===============================导入插件=====================================
Import-Module PSReadLine
Import-Module posh-git 
Import-Module oh-my-posh 

Set-PSReadLineOption -PredictionSource History

#===============================设置主题=====================================
#Set-Theme Robbyrussell
Set-Theme Star



