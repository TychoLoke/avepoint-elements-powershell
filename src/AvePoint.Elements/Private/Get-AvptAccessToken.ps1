function Get-AvptAccessToken {
    [CmdletBinding()]
    param(
        [switch] $ForceRefresh
    )

    $state = Get-AvptModuleState

    if (-not $state.Connection) {
        throw 'No AvePoint Elements connection is active. Run Connect-AvptElements first.'
    }

    if (
        -not $ForceRefresh -and
        $state.Token -and
        $state.Token.ExpiresAt -gt [DateTimeOffset]::UtcNow.AddMinutes(5)
    ) {
        return $state.Token.AccessToken
    }

    $requestSplat = @{
        ClientId = $state.Connection.ClientId
        TokenUri = $state.Connection.TokenUri
        Scope    = $state.Connection.Scope
    }

    if ($state.Connection.AuthType -eq 'ClientSecret') {
        $requestSplat.ClientSecret = $state.Connection.ClientSecret
    }
    else {
        $requestSplat.Certificate = $state.Connection.Certificate
    }

    $state.Token = Request-AvptAccessToken @requestSplat
    $state.Token.AccessToken
}

