function New-AvptClientAssertionJwt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $ClientId,

        [Parameter(Mandatory)]
        [string] $Audience,

        [Parameter(Mandatory)]
        [System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate
    )

    if (-not $Certificate.HasPrivateKey) {
        throw 'The certificate must include a private key for client assertion authentication.'
    }

    $now = [DateTimeOffset]::UtcNow
    $expires = $now.AddMinutes(5)
    $securityKey = [Microsoft.IdentityModel.Tokens.X509SecurityKey]::new($Certificate)
    $signingCredentials = [Microsoft.IdentityModel.Tokens.SigningCredentials]::new(
        $securityKey,
        [Microsoft.IdentityModel.Tokens.SecurityAlgorithms]::RsaSha256
    )

    $header = [System.IdentityModel.Tokens.Jwt.JwtHeader]::new($signingCredentials)
    $header['x5t'] = [Microsoft.IdentityModel.Tokens.Base64UrlEncoder]::Encode($Certificate.GetCertHash())

    $payload = [System.IdentityModel.Tokens.Jwt.JwtPayload]::new(
        $ClientId,
        $Audience,
        $null,
        $now.UtcDateTime,
        $expires.UtcDateTime,
        $now.UtcDateTime
    )
    $payload['sub'] = $ClientId
    $payload['jti'] = [guid]::NewGuid().Guid

    $token = [System.IdentityModel.Tokens.Jwt.JwtSecurityToken]::new($header, $payload)
    $handler = [System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler]::new()
    $handler.WriteToken($token)
}

