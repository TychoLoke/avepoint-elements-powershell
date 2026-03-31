function Initialize-AvptTokenCache {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]] $ScopeBundle,

        [Parameter(Mandatory)]
        [hashtable] $RequestParameters
    )

    $bundles = Resolve-AvptScopeBundle -Name $ScopeBundle
    $results = foreach ($bundle in $bundles) {
        $token = Request-AvptAccessToken @RequestParameters -Scope $bundle.Scope
        Set-AvptTokenCacheEntry -Key $bundle.Name -Scope $bundle.Scope -Token $token

        [pscustomobject]@{
            Name               = $bundle.Name
            Scope              = $bundle.Scope
            RequestedScopeText = ($bundle.Scope -join ' ')
            RequestedScopeCount = $bundle.Scope.Count
            RequestedScopeLength = (($bundle.Scope -join ' ').Length)
            GrantedScope       = $token.Scope
            GrantedScopeCount  = $token.Scope.Count
            ExpiresAt          = $token.ExpiresAt
        }
    }

    @($results)
}

