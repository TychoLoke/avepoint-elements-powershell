function Start-AvptConnectOnboarding {
    [CmdletBinding()]
    param(
        [switch] $ReadOnlyScopeMenu
    )

    Show-AvptBanner

    Write-Host '[Session Setup]' -ForegroundColor Red
    $environment = Read-AvptEnvironmentSelection
    Write-Host ''
    Write-Host " Selected environment: $environment" -ForegroundColor Cyan

    $tenantName = Read-Host 'Optional tenant or partner label'

    Write-Host ''
    Write-Host '[Authentication]' -ForegroundColor Red
    $authMode = Read-AvptAuthSelection

    $result = [ordered]@{
        Environment = $environment
        TenantName  = if ([string]::IsNullOrWhiteSpace($tenantName)) { $null } else { $tenantName }
    }

    Write-Host ''
    Write-Host '[Authorization]' -ForegroundColor Red
    $bundleMode = Read-Host 'Use named scope bundles for Common, Baseline, User, Risk, and Workspace? (Y/n)'
    if ([string]::IsNullOrWhiteSpace($bundleMode) -or $bundleMode -match '^(y|yes)$') {
        $result.ScopeBundle = Read-AvptScopeBundleSelection
    }
    else {
        $result.Scope = Read-AvptPermissionSelection -ReadOnlyOnly:$ReadOnlyScopeMenu
    }

    switch ($authMode) {
        'ClientSecret' {
            Write-Host ''
            $clientId = Read-Host 'Client ID'
            $clientSecret = Read-Host 'Client secret' -AsSecureString
            $result.Credential = [pscredential]::new($clientId, $clientSecret)
        }
        'CertificatePath' {
            Write-Host ''
            $result.ClientId = Read-Host 'Client ID'
            $result.CertificatePath = Read-Host 'Path to PFX certificate'
            $passwordPrompt = Read-Host 'Does the PFX require a password? (y/N)'
            if ($passwordPrompt -match '^(y|yes)$') {
                $result.CertificatePassword = Read-Host 'Certificate password' -AsSecureString
            }
        }
        'CertificateThumbprint' {
            Write-Host ''
            $result.ClientId = Read-Host 'Client ID'
            $result.CertificateThumbprint = Read-Host 'Certificate thumbprint'
        }
    }

    [pscustomobject] $result
}
