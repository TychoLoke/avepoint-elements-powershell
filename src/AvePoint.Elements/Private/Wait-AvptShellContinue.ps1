function Wait-AvptShellContinue {
    [CmdletBinding()]
    param(
        [string] $Message = 'Press Enter to return to the dashboard'
    )

    Write-Host ''
    [void] (Read-Host $Message)
}
