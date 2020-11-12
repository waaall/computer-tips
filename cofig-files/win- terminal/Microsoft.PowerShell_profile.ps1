Remove-Item alias:\wget
Remove-Item alias:\curl

Import-Module PSReadLine
Import-Module posh-git 
Import-Module oh-my-posh 

Set-Theme Robbyrussell

Set-PSReadLineOption -PredictionSource History


