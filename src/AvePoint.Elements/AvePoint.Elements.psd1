@{
    RootModule           = 'AvePoint.Elements.psm1'
    ModuleVersion        = '0.4.0'
    GUID                 = '7fbe5f68-bb17-4a67-81d5-8ad3884d783f'
    Author               = 'Tycho Loke'
    CompanyName          = 'Open Source'
    Copyright            = '(c) 2026 Tycho Loke. All rights reserved.'
    Description          = 'PowerShell toolkit for MSP operations on the AvePoint Elements API.'
    PowerShellVersion    = '7.0'
    CompatiblePSEditions = @('Core')
    FunctionsToExport    = @(
        'Connect-AvptElements'
        'Disconnect-AvptElements'
        'Get-AvptBackupJob'
        'Get-AvptBackupOverview'
        'Get-AvptBaseline'
        'Get-AvptBaselineReport'
        'Get-AvptBaselineTenant'
        'Get-AvptCustomer'
        'Get-AvptCustomerService'
        'Get-AvptPermissionScope'
        'Get-AvptProductOverview'
        'Get-AvptRiskHitItem'
        'Get-AvptRiskRule'
        'Get-AvptScanProfile'
        'Get-AvptScanProfileChange'
        'Get-AvptScanProfileDetail'
        'Get-AvptScopeBundle'
        'Get-AvptTenantSeat'
        'Invoke-AvptTenantMonitorAction'
        'New-AvptBaseline'
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
            ReleaseNotes = 'Add baseline and risk cmdlets plus improved object shaping for customer and service outputs.'
        }
    }
}
