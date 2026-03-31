function Connect-AvptElements {
    <#
    .SYNOPSIS
    Connects to the AvePoint Elements API.

    .DESCRIPTION
    Creates an in-memory connection for the AvePoint Elements API using either
    client secret authentication or certificate-based authentication.
    When called without the required connection details, it starts a guided
    onboarding flow with environment and permission selection.

    .PARAMETER Environment
    The AvePoint Elements environment preset to use.

    .PARAMETER Scope
    One or more permission scopes assigned to the Elements app registration.

    .PARAMETER ScopeBundle
    One or more named scope bundles to initialize and cache during connection.

    .PARAMETER UseScopeMenu
    Opens an interactive numbered permission menu so you can select the same
    scopes that were chosen in the Elements portal app registration.

    .PARAMETER ReadOnlyScopeMenu
    Limits the interactive permission menu to read-only scopes.

    .PARAMETER Guided
    Forces the interactive onboarding flow even when other parameters could be
    supplied directly.

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
    Connect-AvptElements -Environment Commercial -Credential $credential -ScopeBundle Common,User,Risk,Workspace

    .EXAMPLE
    Connect-AvptElements -Environment Commercial -Credential $credential -UseScopeMenu

    .EXAMPLE
    Connect-AvptElements -Environment Commercial -ClientId '00000000-0000-0000-0000-000000000000' -CertificatePath ./app.pfx -CertificatePassword (Read-Host -AsSecureString) -Scope 'elements.customers.read.all'
    #>
    [CmdletBinding(DefaultParameterSetName = 'Interactive')]
    param(
        [Parameter()]
        [ValidateSet('Commercial', 'Government', 'Aos2', 'FedRAMP')]
        [string] $Environment,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]] $Scope,

        [Parameter()]
        [ValidateSet('Common', 'Baseline', 'User', 'Risk', 'Workspace')]
        [string[]] $ScopeBundle,

        [Parameter()]
        [switch] $UseScopeMenu,

        [Parameter()]
        [switch] $ReadOnlyScopeMenu,

        [Parameter()]
        [switch] $Guided,

        [Parameter(ParameterSetName = 'ClientSecret')]
        [pscredential] $Credential,

        [Parameter(ParameterSetName = 'CertificatePath')]
        [Parameter(ParameterSetName = 'CertificateThumbprint')]
        [ValidateNotNullOrEmpty()]
        [string] $ClientId,

        [Parameter(ParameterSetName = 'CertificatePath')]
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

    $shouldRunGuided = $Guided -or (
        -not $PSBoundParameters.ContainsKey('Credential') -and
        -not $PSBoundParameters.ContainsKey('ClientId') -and
        -not $PSBoundParameters.ContainsKey('CertificatePath') -and
        -not $PSBoundParameters.ContainsKey('CertificateThumbprint')
    )

    if ($shouldRunGuided) {
        $guidedSession = Start-AvptConnectOnboarding -ReadOnlyScopeMenu:$ReadOnlyScopeMenu

        $Environment = $guidedSession.Environment
        $Scope = $guidedSession.Scope
        if ($guidedSession.PSObject.Properties['ScopeBundle'] -and $guidedSession.ScopeBundle) {
            $ScopeBundle = $guidedSession.ScopeBundle
        }
        $TenantName = $guidedSession.TenantName

        if ($guidedSession.PSObject.Properties['Credential']) {
            $Credential = $guidedSession.Credential
        }

        if ($guidedSession.PSObject.Properties['ClientId']) {
            $ClientId = $guidedSession.ClientId
        }

        if ($guidedSession.PSObject.Properties['CertificatePath']) {
            $CertificatePath = $guidedSession.CertificatePath
        }

        if ($guidedSession.PSObject.Properties['CertificatePassword']) {
            $CertificatePassword = $guidedSession.CertificatePassword
        }

        if ($guidedSession.PSObject.Properties['CertificateThumbprint']) {
            $CertificateThumbprint = $guidedSession.CertificateThumbprint
        }
    }

    if (-not $Environment) {
        if ($UseScopeMenu -or $ReadOnlyScopeMenu) {
            $Environment = Read-AvptEnvironmentSelection
        }
        else {
            $Environment = 'Commercial'
        }
    }

    if (-not $Scope -and -not $ScopeBundle) {
        if ($UseScopeMenu -or $ReadOnlyScopeMenu) {
            $Scope = Read-AvptPermissionSelection -ReadOnlyOnly:$ReadOnlyScopeMenu
        }
        else {
            $ScopeBundle = @('Common', 'Baseline', 'User', 'Risk', 'Workspace')
        }
    }

    if (-not $Credential -and -not $ClientId) {
        throw 'Authentication details are required. Provide -Credential or certificate-based parameters, or run Connect-AvptElements with no arguments for guided onboarding.'
    }

    $environmentConfig = Get-AvptEnvironmentConfig -Environment $Environment
    $state = Get-AvptModuleState

    $connection = [ordered]@{
        Environment = $environmentConfig.Name
        BaseUri     = if ($BaseUri) { $BaseUri.TrimEnd('/') } else { $environmentConfig.BaseUri }
        TokenUri    = if ($TokenUri) { $TokenUri } else { $environmentConfig.TokenUri }
        Scope       = @($Scope)
        ScopeBundle = @($ScopeBundle)
        DefaultBundle = if ($ScopeBundle) { $ScopeBundle[0] } else { $null }
        TenantName  = $TenantName
    }

    if ($Credential) {
        $connection.AuthType = 'ClientSecret'
        $connection.ClientId = $Credential.UserName
        $connection.ClientSecret = $Credential.Password
    }
    elseif ($CertificatePath) {
        $connection.AuthType = 'Certificate'
        $connection.ClientId = $ClientId
        $connection.Certificate = Get-AvptCertificate -CertificatePath $CertificatePath -CertificatePassword $CertificatePassword
    }
    elseif ($CertificateThumbprint) {
        $connection.AuthType = 'Certificate'
        $connection.ClientId = $ClientId
        $connection.Certificate = Get-AvptCertificate -Thumbprint $CertificateThumbprint
    }
    else {
        throw 'Certificate-based authentication requires -ClientId with either -CertificatePath or -CertificateThumbprint.'
    }

    $state.Connection = [pscustomobject] $connection
    $state.Token = $null
    $state.TokenCache = @{}

    try {
        $requestParameters = @{
            ClientId = $state.Connection.ClientId
            TokenUri = $state.Connection.TokenUri
        }

        if ($state.Connection.AuthType -eq 'ClientSecret') {
            $requestParameters.ClientSecret = $state.Connection.ClientSecret
        }
        else {
            $requestParameters.Certificate = $state.Connection.Certificate
        }

        if ($ScopeBundle) {
            $bundleResults = Initialize-AvptTokenCache -ScopeBundle $ScopeBundle -RequestParameters $requestParameters
        }
        else {
            $requestedScopeString = $Scope -join ' '
            if ($requestedScopeString.Length -gt 300) {
                Write-Warning "Requested scope string length is $($requestedScopeString.Length) characters. Live Commercial endpoint testing on 2026-03-31 showed invalid_scope responses once combined scope strings exceeded roughly 300 characters."
            }

            $state.Token = Request-AvptAccessToken @requestParameters -Scope $Scope
        }
    }
    catch {
        $state.Connection = $null
        $state.Token = $null
        $state.TokenCache = @{}
        throw
    }

    if ($PassThru) {
        if ($ScopeBundle) {
            [pscustomobject]@{
                Environment  = $state.Connection.Environment
                BaseUri      = $state.Connection.BaseUri
                TokenUri     = $state.Connection.TokenUri
                ClientId     = $state.Connection.ClientId
                AuthType     = $state.Connection.AuthType
                ScopeBundle  = $state.Connection.ScopeBundle
                BundleStatus = $bundleResults
                TenantName   = $state.Connection.TenantName
            }
        }
        else {
            [pscustomobject]@{
                Environment          = $state.Connection.Environment
                BaseUri              = $state.Connection.BaseUri
                TokenUri             = $state.Connection.TokenUri
                ClientId             = $state.Connection.ClientId
                AuthType             = $state.Connection.AuthType
                RequestedScope       = $Scope
                RequestedScopeCount  = $Scope.Count
                RequestedScopeLength = $requestedScopeString.Length
                GrantedScope         = $state.Token.Scope
                GrantedScopeCount    = $state.Token.Scope.Count
                TenantName           = $state.Connection.TenantName
                ExpiresAt            = $state.Token.ExpiresAt
            }
        }
    }
    else {
        Write-Host ''
        Write-Host 'Connected to AvePoint Elements.' -ForegroundColor Green
        Write-Host (" Environment : {0}" -f $state.Connection.Environment) -ForegroundColor DarkGray
        Write-Host (" Auth Type   : {0}" -f $state.Connection.AuthType) -ForegroundColor DarkGray
        if ($ScopeBundle) {
            Write-Host (" Bundles     : {0}" -f (($ScopeBundle | Sort-Object) -join ', ')) -ForegroundColor DarkGray
            foreach ($bundle in $bundleResults | Sort-Object Name) {
                Write-Host ("  {0,-10} {1} scopes, {2} chars" -f $bundle.Name, $bundle.RequestedScopeCount, $bundle.RequestedScopeLength) -ForegroundColor DarkGray
            }
        }
        else {
            Write-Host (" Requested   : {0}" -f (($Scope | Sort-Object) -join ', ')) -ForegroundColor DarkGray
            Write-Host (" Scope Count : {0}" -f $Scope.Count) -ForegroundColor DarkGray
            Write-Host (" Scope Chars : {0}" -f $requestedScopeString.Length) -ForegroundColor DarkGray
            Write-Host (" Granted     : {0}" -f (($state.Token.Scope | Sort-Object) -join ', ')) -ForegroundColor DarkGray
        }
        if ($state.Connection.TenantName) {
            Write-Host (" Label       : {0}" -f $state.Connection.TenantName) -ForegroundColor DarkGray
        }
        if ($ScopeBundle) {
            $expiryList = $bundleResults | Sort-Object Name | ForEach-Object { '{0}: {1}' -f $_.Name, $_.ExpiresAt }
            Write-Host (" Expires At  : {0}" -f ($expiryList -join ' | ')) -ForegroundColor DarkGray
        }
        else {
            Write-Host (" Expires At  : {0}" -f $state.Token.ExpiresAt) -ForegroundColor DarkGray
        }
    }
}
