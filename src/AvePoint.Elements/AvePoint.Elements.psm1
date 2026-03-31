$script:AvptState = @{
    Connection = $null
    Token      = $null
    TokenCache = @{}
}

$publicPath = Join-Path -Path $PSScriptRoot -ChildPath 'Public'
$privatePath = Join-Path -Path $PSScriptRoot -ChildPath 'Private'

foreach ($scriptPath in @(Get-ChildItem -Path $privatePath -Filter '*.ps1' -ErrorAction SilentlyContinue | Sort-Object FullName)) {
    . $scriptPath.FullName
}

foreach ($scriptPath in @(Get-ChildItem -Path $publicPath -Filter '*.ps1' -ErrorAction SilentlyContinue | Sort-Object FullName)) {
    . $scriptPath.FullName
}

$publicFunctions = Get-ChildItem -Path $publicPath -Filter '*.ps1' -ErrorAction SilentlyContinue |
    Sort-Object BaseName |
    Select-Object -ExpandProperty BaseName

Export-ModuleMember -Function $publicFunctions
