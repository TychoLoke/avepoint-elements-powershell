@{
    RootModule           = 'AvePoint.Elements.psm1'
    ModuleVersion        = '0.9.0'
    GUID                 = '7fbe5f68-bb17-4a67-81d5-8ad3884d783f'
    Author               = 'Tycho Loke'
    CompanyName          = 'Open Source'
    Copyright            = '(c) 2026 Tycho Loke. All rights reserved.'
    Description          = 'PowerShell toolkit for MSP operations on the AvePoint Elements API.'
    PowerShellVersion    = '7.0'
    CompatiblePSEditions = @('Core')
    FunctionsToExport    = @(
        'Add-AvptCustomerService'
        'Connect-AvptElements'
        'Disconnect-AvptElements'
        'Get-AvptBackupJob'
        'Get-AvptBackupOverview'
        'Get-AvptBaseline'
        'Get-AvptBaselineReport'
        'Get-AvptBaselineTenant'
        'Get-AvptCustomer'
        'Get-AvptCustomerService'
        'Get-AvptCustomerSummary'
        'Get-AvptPermissionScope'
        'Get-AvptProductOverview'
        'Get-AvptRiskHitItem'
        'Get-AvptRiskRule'
        'Get-AvptScanProfile'
        'Get-AvptScanProfileChange'
        'Get-AvptScanProfileDetail'
        'Get-AvptSecurityUserOverview'
        'Get-AvptScopeBundle'
        'Get-AvptTenantSeat'
        'Get-AvptTenantSummary'
        'Get-AvptUser'
        'Get-AvptUsers'
        'Get-AvptWorkspaceCompliance'
        'Get-AvptWorkspaceDataProtectionStatistic'
        'Get-AvptWorkspaceDataSecurityPosture'
        'Get-AvptWorkspaceOverview'
        'Invoke-AvptTenantMonitorAction'
        'New-AvptBaseline'
        'New-AvptCustomer'
        'Start-AvptElementsShell'
        'Test-AvptScopeSet'
        'Test-AvptElementsConnection'
    )
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @()
    PrivateData          = @{
        PSData = @{
            Tags         = @('AvePoint', 'Elements', 'MSP', 'Automation', 'PowerShell')
            ProjectUri   = 'https://github.com/TychoLoke/avepoint-elements-powershell'
            LicenseUri   = 'https://github.com/TychoLoke/avepoint-elements-powershell/blob/main/LICENSE'
            ReleaseNotes = 'Add the first Avalonia desktop application shell with a professional dashboard UI and documented build path.'
        }
    }
}
