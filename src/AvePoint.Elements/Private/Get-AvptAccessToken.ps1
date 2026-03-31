function Get-AvptAccessToken {
    [CmdletBinding()]
    param(
        [string] $BundleName,

        [string[]] $Scope,

        [switch] $ForceRefresh
    )

    $state = Get-AvptModuleState

    if (-not $state.Connection) {
        throw 'No AvePoint Elements connection is active. Run Connect-AvptElements first.'
    }

    if ($BundleName) {
        $cacheEntry = $state.TokenCache[$BundleName]
        if (-not $cacheEntry) {
            throw "No cached token bundle named '$BundleName' is available. Reconnect with -ScopeBundle $BundleName."
        }
    }
    elseif ($Scope) {
        $key = 'Custom:' + ($Scope -join '|')
        $cacheEntry = $state.TokenCache[$key]
    }
    else {
        $cacheEntry = if ($state.Connection.DefaultBundle) { $state.TokenCache[$state.Connection.DefaultBundle] } else { $null }
    }

    if (
        -not $ForceRefresh -and
        $cacheEntry -and
        $cacheEntry.Token -and
        $cacheEntry.Token.ExpiresAt -gt [DateTimeOffset]::UtcNow.AddMinutes(5)
    ) {
        return $cacheEntry.Token.AccessToken
    }

    $requestSplat = @{
        ClientId = $state.Connection.ClientId
        TokenUri = $state.Connection.TokenUri
    }

    $requestedScope = if ($BundleName) {
        $cacheEntry.Scope
    }
    elseif ($Scope) {
        $Scope
    }
    elseif ($state.Connection.DefaultBundle) {
        $state.TokenCache[$state.Connection.DefaultBundle].Scope
    }
    else {
        $state.Connection.Scope
    }
    $requestSplat.Scope = $requestedScope

    if ($state.Connection.AuthType -eq 'ClientSecret') {
        $requestSplat.ClientSecret = $state.Connection.ClientSecret
    }
    else {
        $requestSplat.Certificate = $state.Connection.Certificate
    }

    $token = Request-AvptAccessToken @requestSplat

    if ($BundleName) {
        Set-AvptTokenCacheEntry -Key $BundleName -Scope $requestedScope -Token $token
    }
    elseif ($Scope) {
        Set-AvptTokenCacheEntry -Key ('Custom:' + ($requestedScope -join '|')) -Scope $requestedScope -Token $token
    }
    else {
        $state.Token = $token
    }

    $token.AccessToken
}
