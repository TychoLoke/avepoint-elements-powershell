function Request-AvptAccessToken {
    [CmdletBinding(DefaultParameterSetName = 'ClientSecret')]
    param(
        [Parameter(Mandatory)]
        [string] $ClientId,

        [Parameter(Mandatory)]
        [string] $TokenUri,

        [Parameter(Mandatory)]
        [string[]] $Scope,

        [Parameter(Mandatory, ParameterSetName = 'ClientSecret')]
        [Security.SecureString] $ClientSecret,

        [Parameter(Mandatory, ParameterSetName = 'Certificate')]
        [System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate
    )

    $body = @{
        client_id  = $ClientId
        scope      = ($Scope -join ' ')
        grant_type = 'client_credentials'
    }

    if ($PSCmdlet.ParameterSetName -eq 'ClientSecret') {
        $body.client_secret = ConvertTo-AvptPlainText -SecureString $ClientSecret
    }
    else {
        $body.client_assertion_type = 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer'
        $body.client_assertion = New-AvptClientAssertionJwt -ClientId $ClientId -Audience $TokenUri -Certificate $Certificate
    }

    Write-Verbose "Requesting access token from $TokenUri"

    $response = Invoke-RestMethod -Uri $TokenUri -Method Post -Body $body -ContentType 'application/x-www-form-urlencoded'
    $expiresAt = [DateTimeOffset]::UtcNow.AddSeconds([int] $response.expires_in)

    [pscustomobject]@{
        AccessToken = $response.access_token
        ExpiresAt   = $expiresAt
        Scope       = @($response.scope -split '\s+' | Where-Object { $_ })
        TokenType   = $response.token_type
    }
}

