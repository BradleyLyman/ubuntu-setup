Set-PSReadLineOption -EditMode "Vi" -Colors @{
  Command = [ConsoleColor]::White
  Comment = [ConsoleColor]::White
  ContinuationPrompt = [ConsoleColor]::White
  DefaultToken = [ConsoleColor]::White
  Emphasis = [ConsoleColor]::White
  Error = [ConsoleColor]::White
  Keyword = [ConsoleColor]::White
  Member = [ConsoleColor]::White
  Number = [ConsoleColor]::White
  Operator = [ConsoleColor]::White
  Parameter = [ConsoleColor]::White
  Selection = [ConsoleColor]::White
  String = [ConsoleColor]::White
  Type = [ConsoleColor]::White
  Variable = [ConsoleColor]::White
}

function prompt {
  Write-Host "┏╸" -ForegroundColor Magenta -NoNewLine
  Write-Host $pwd -ForegroundColor DarkYellow

  $branch = & git branch 2>out-null
  if ($branch -ne $null) {
    Set-PSReadLineOption -ExtraPromptLineCount 2
    Write-Host "┣╸" -ForegroundColor Magenta -NoNewLine
    Write-Host "<" -ForegroundColor DarkYellow -NoNewLine
    Write-Host $branch.SubString(2) -ForegroundColor Magenta -NoNewLine
    Write-Host ">" -ForegroundColor DarkYellow
  }
  else {
    Set-PSReadLineOption -ExtraPromptLineCount 1
    # Write-Host "┣╸" -ForegroundColor Magenta
  }

  Write-Host "┗" -ForegroundColor Magenta -NoNewLine
  "╸"
}

function awscli {
  Import-Module AWSPowerShell.NetCore
}

