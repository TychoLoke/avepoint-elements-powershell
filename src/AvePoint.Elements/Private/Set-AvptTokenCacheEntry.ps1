function Set-AvptTokenCacheEntry {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Key,

        [Parameter(Mandatory)]
        [string[]] $Scope,

        [Parameter(Mandatory)]
        [object] $Token
    )

    $state = Get-AvptModuleState
    if (-not $state.TokenCache) {
        $state.TokenCache = @{}
    }

    $state.TokenCache[$Key] = [pscustomobject]@{
        Key       = $Key
        Scope     = @($Scope)
        ScopeText = ($Scope -join ' ')
        Token     = $Token
    }
}

