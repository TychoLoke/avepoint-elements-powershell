function Test-AvptScopeSet {
    <#
    .SYNOPSIS
    Tests whether a specific AvePoint Elements scope set can obtain a token.

    .DESCRIPTION
    Requests an access token for the supplied scope combination and returns
    diagnostics that help identify invalid scope combinations.

    .PARAMETER Environment
    The AvePoint Elements environment preset to use.

    .PARAMETER Scope
    One or more permission scopes to request.

    .PARAMETER Credential
    A PSCredential where the user name is the client ID and the password is the client secret.

    .PARAMETER BaseUri
    Optional override for the API base URI.

    .PARAMETER TokenUri
    Optional override for the identity token URI.

    .EXAMPLE
    Test-AvptScopeSet -Environment Commercial -Credential $credential -Scope @(
        'elements.customers.read.all'
        'elements.license.read.all'
    )
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet('Commercial', 'Government', 'Aos2', 'FedRAMP')]
        [string] $Environment = 'Commercial',

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Scope,

        [Parameter(Mandatory)]
        [pscredential] $Credential,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $BaseUri,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $TokenUri
    )

    $environmentConfig = Get-AvptEnvironmentConfig -Environment $Environment
    $resolvedTokenUri = if ($TokenUri) { $TokenUri } else { $environmentConfig.TokenUri }
    $scopeString = $Scope -join ' '

    try {
        $token = Request-AvptAccessToken -ClientId $Credential.UserName -ClientSecret $Credential.Password -TokenUri $resolvedTokenUri -Scope $Scope
        [pscustomobject]@{
            Environment          = $Environment
            TokenUri             = $resolvedTokenUri
            RequestedScope       = $Scope
            RequestedScopeCount  = $Scope.Count
            RequestedScopeLength = $scopeString.Length
            Success              = $true
            GrantedScope         = $token.Scope
            GrantedScopeCount    = $token.Scope.Count
            ExpiresAt            = $token.ExpiresAt
            Error                = $null
        }
    }
    catch {
        [pscustomobject]@{
            Environment          = $Environment
            TokenUri             = $resolvedTokenUri
            RequestedScope       = $Scope
            RequestedScopeCount  = $Scope.Count
            RequestedScopeLength = $scopeString.Length
            Success              = $false
            GrantedScope         = @()
            GrantedScopeCount    = 0
            ExpiresAt            = $null
            Error                = $_.Exception.Message
        }
    }
}

