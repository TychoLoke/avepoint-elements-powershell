function Test-AvptElementsConnection {
    <#
    .SYNOPSIS
    Tests the current AvePoint Elements connection.

    .DESCRIPTION
    Validates that a connection exists, a token can be obtained, and optionally
    performs a probe request against a supplied API path.

    .PARAMETER ProbePath
    An optional API path to call after validating token acquisition.

    .PARAMETER Quiet
    Returns only a Boolean result when specified.

    .EXAMPLE
    Test-AvptElementsConnection

    .EXAMPLE
    Test-AvptElementsConnection -ProbePath '/partner/customers'
    #>
    [CmdletBinding()]
    param(
        [string] $ProbePath,
        [switch] $Quiet
    )

    try {
        $state = Get-AvptModuleState
        if (-not $state.Connection) {
            throw 'No AvePoint Elements connection is active.'
        }

        $null = Get-AvptAccessToken

        $probeSucceeded = $false
        if ($ProbePath) {
            $null = Invoke-AvptWebRequest -Method Get -Path $ProbePath
            $probeSucceeded = $true
        }

        $result = [pscustomobject]@{
            Connected      = $true
            Environment    = $state.Connection.Environment
            BaseUri        = $state.Connection.BaseUri
            AuthType       = $state.Connection.AuthType
            Scope          = $state.Connection.Scope
            ExpiresAt      = $state.Token.ExpiresAt
            ProbePath      = $ProbePath
            ProbeSucceeded = $probeSucceeded
        }

        if ($Quiet) {
            return $true
        }

        return $result
    }
    catch {
        if ($Quiet) {
            return $false
        }

        [pscustomobject]@{
            Connected      = $false
            Environment    = $null
            BaseUri        = $null
            AuthType       = $null
            Scope          = @()
            ExpiresAt      = $null
            ProbePath      = $ProbePath
            ProbeSucceeded = $false
            Error          = $_.Exception.Message
        }
    }
}
