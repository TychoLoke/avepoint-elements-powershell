function Disconnect-AvptElements {
    <#
    .SYNOPSIS
    Removes the current AvePoint Elements connection.

    .DESCRIPTION
    Clears in-memory connection and token state for the current PowerShell session.

    .EXAMPLE
    Disconnect-AvptElements
    #>
    [CmdletBinding()]
    param()

    $state = Get-AvptModuleState
    $state.Connection = $null
    $state.Token = $null
}

