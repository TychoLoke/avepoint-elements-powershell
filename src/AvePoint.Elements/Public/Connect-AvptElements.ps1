function Connect-AvptElements {
    <#
    .SYNOPSIS
    Connects to the AvePoint Elements API.

    .DESCRIPTION
    Creates an in-memory connection for the AvePoint Elements API using either
    client secret authentication or certificate-based authentication.

    .PARAMETER Environment
    The AvePoint Elements environment preset to use.

    .PARAMETER Scope
    One or more permission scopes assigned to the Elements app registration.

    .PARAMETER Credential
    A PSCredential where the user name is the client ID and the password is the client secret.

    .PARAMETER ClientId
    The application client ID for certificate-based authentication.

    .PARAMETER CertificatePath
    The path to a PFX certificate file.

    .PARAMETER CertificateThumbprint
    The thumbprint of a certificate in the CurrentUser or LocalMachine store.

    .PARAMETER BaseUri
    Optional override for the API base URI.

    .PARAMETER TokenUri
    Optional override for the identity token URI.

    .PARAMETER TenantName
    An optional friendly label for the connected tenant or partner context.

    .EXAMPLE
    $secret = ConvertTo-SecureString 'your-client-secret' -AsPlainText -Force
    $credential = [pscredential]::new('your-client-id', $secret)
    Connect-AvptElements -Environment Commercial -Credential $credential -Scope 'your.scope.value'

    .EXAMPLE
    Connect-AvptElements -Environment Commercial -ClientId '00000000-0000-0000-0000-000000000000' -CertificatePath ./app.pfx -CertificatePassword (Read-Host -AsSecureString) -Scope 'your.scope.value'
    #>
    [CmdletBinding(DefaultParameterSetName = 'ClientSecret')]
    param(
        [Parameter()]
        [ValidateSet('Commercial', 'Government', 'Aos2', 'FedRAMP')]
        [string] $Environment = 'Commercial',

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Scope,

        [Parameter(Mandatory, ParameterSetName = 'ClientSecret')]
        [pscredential] $Credential,

        [Parameter(Mandatory, ParameterSetName = 'CertificatePath')]
        [Parameter(Mandatory, ParameterSetName = 'CertificateThumbprint')]
        [ValidateNotNullOrEmpty()]
        [string] $ClientId,

        [Parameter(Mandatory, ParameterSetName = 'CertificatePath')]
        [ValidateNotNullOrEmpty()]
        [string] $CertificatePath,

        [Parameter(ParameterSetName = 'CertificatePath')]
        [Security.SecureString] $CertificatePassword,

        [Parameter(Mandatory, ParameterSetName = 'CertificateThumbprint')]
        [ValidateNotNullOrEmpty()]
        [string] $CertificateThumbprint,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $BaseUri,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $TokenUri,

        [Parameter()]
        [string] $TenantName,

        [switch] $PassThru
    )

    $environmentConfig = Get-AvptEnvironmentConfig -Environment $Environment
    $state = Get-AvptModuleState

    $connection = [ordered]@{
        Environment = $environmentConfig.Name
        BaseUri     = if ($BaseUri) { $BaseUri.TrimEnd('/') } else { $environmentConfig.BaseUri }
        TokenUri    = if ($TokenUri) { $TokenUri } else { $environmentConfig.TokenUri }
        Scope       = @($Scope)
        TenantName  = $TenantName
    }

    switch ($PSCmdlet.ParameterSetName) {
        'ClientSecret' {
            $connection.AuthType = 'ClientSecret'
            $connection.ClientId = $Credential.UserName
            $connection.ClientSecret = $Credential.Password
        }
        'CertificatePath' {
            $connection.AuthType = 'Certificate'
            $connection.ClientId = $ClientId
            $connection.Certificate = Get-AvptCertificate -CertificatePath $CertificatePath -CertificatePassword $CertificatePassword
        }
        'CertificateThumbprint' {
            $connection.AuthType = 'Certificate'
            $connection.ClientId = $ClientId
            $connection.Certificate = Get-AvptCertificate -Thumbprint $CertificateThumbprint
        }
    }

    $state.Connection = [pscustomobject] $connection
    $state.Token = $null

    try {
        $null = Get-AvptAccessToken -ForceRefresh
    }
    catch {
        $state.Connection = $null
        $state.Token = $null
        throw
    }

    if ($PassThru) {
        [pscustomobject]@{
            Environment = $state.Connection.Environment
            BaseUri     = $state.Connection.BaseUri
            TokenUri    = $state.Connection.TokenUri
            ClientId    = $state.Connection.ClientId
            AuthType    = $state.Connection.AuthType
            Scope       = $state.Connection.Scope
            TenantName  = $state.Connection.TenantName
            ExpiresAt   = $state.Token.ExpiresAt
        }
    }
}
