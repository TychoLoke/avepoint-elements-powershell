function Show-AvptShellResult {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $InputObject,

        [switch] $AsList
    )

    if ($null -eq $InputObject) {
        Write-Host 'No data returned.' -ForegroundColor DarkYellow
        return
    }

    if ($AsList) {
        $InputObject | Format-List * | Out-Host
        return
    }

    if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
        @($InputObject) | Format-Table -AutoSize | Out-Host
        return
    }

    $InputObject | Format-List * | Out-Host
}
