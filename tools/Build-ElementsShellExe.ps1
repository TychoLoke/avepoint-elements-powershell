[CmdletBinding()]
param(
    [string] $OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath '../dist/ElementsShell.exe')
)

if (-not $IsWindows) {
    throw 'ElementsShell.exe packaging is only supported on Windows hosts.'
}

$ps2exe = Get-Module -ListAvailable -Name ps2exe
if (-not $ps2exe) {
    Install-Module ps2exe -Scope CurrentUser -Force -SkipPublisherCheck
}

$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath '../app/ElementsShell.ps1'
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
$outputDirectory = Split-Path -Path $resolvedOutput -Parent
New-Item -Path $outputDirectory -ItemType Directory -Force | Out-Null

Invoke-PS2EXE -InputFile $scriptPath -OutputFile $resolvedOutput -Title 'Elements Shell' -Product 'AvePoint Elements PowerShell' -Description 'Interactive shell for the AvePoint Elements PowerShell toolkit' -NoConsole:$false
