function Export-AvptShellData {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $InputObject,

        [Parameter(Mandatory)]
        [ValidateSet('Csv', 'Json')]
        [string] $Format
    )

    $defaultName = 'elements-shell-{0}.{1}' -f (Get-Date -Format 'yyyyMMdd-HHmmss'), $Format.ToLowerInvariant()
    $path = Read-Host "Export path [$defaultName]"
    if ([string]::IsNullOrWhiteSpace($path)) {
        $path = $defaultName
    }

    $resolvedPath = [System.IO.Path]::GetFullPath($path)
    $directory = Split-Path -Path $resolvedPath -Parent
    if ($directory) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    switch ($Format) {
        'Csv' {
            @($InputObject) | Export-Csv -Path $resolvedPath -NoTypeInformation -Force
        }
        'Json' {
            $InputObject | ConvertTo-Json -Depth 20 | Set-Content -Path $resolvedPath -Encoding UTF8
        }
    }

    Write-Host (" Exported to {0}" -f $resolvedPath) -ForegroundColor Green
}
