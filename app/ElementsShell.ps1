$modulePath = Join-Path -Path $PSScriptRoot -ChildPath '../src/AvePoint.Elements/AvePoint.Elements.psd1'
Import-Module $modulePath -Force

Start-AvptElementsShell
