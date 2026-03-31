function Start-AvptElementsShell {
    <#
    .SYNOPSIS
    Starts the interactive Elements Shell experience.
    #>
    [CmdletBinding()]
    param(
        [switch] $SkipConnect
    )

    Show-AvptBanner
    Write-Host ' INTERACTIVE CONSOLE' -ForegroundColor White
    Write-Host ' Menu-driven access to common AvePoint Elements workflows' -ForegroundColor DarkGray
    Write-Host ''

    $state = Get-AvptModuleState
    if (-not $state.Connection -and -not $SkipConnect) {
        Connect-AvptElements | Out-Null
    }

    while ($true) {
        Write-Host ''
        $connectionStatus = Test-AvptElementsConnection -Quiet
        $statusLabel = if ($connectionStatus) { 'Connected' } else { 'Not connected' }
        $statusColor = if ($connectionStatus) { 'Green' } else { 'Red' }
        Write-Host (' Session: {0}' -f $statusLabel) -ForegroundColor $statusColor
        Write-Host ''

        $selection = Read-AvptChoice -Title 'Choose an Elements Shell action:' -Options @(
            [pscustomobject]@{
                Label = 'Connect or reconnect'
                Description = 'Start the guided onboarding flow.'
                Value = 'Connect'
            }
            [pscustomobject]@{
                Label = 'Connection status'
                Description = 'Test the current Elements session.'
                Value = 'Status'
            }
            [pscustomobject]@{
                Label = 'Customer summary'
                Description = 'One-command operational summary for a customer.'
                Value = 'CustomerSummary'
            }
            [pscustomobject]@{
                Label = 'Tenant summary'
                Description = 'One-command operational summary for a tenant.'
                Value = 'TenantSummary'
            }
            [pscustomobject]@{
                Label = 'Browse customers'
                Description = 'List customers with friendly default output.'
                Value = 'Customers'
            }
            [pscustomobject]@{
                Label = 'Browse users'
                Description = 'Open guided user visibility for a tenant.'
                Value = 'Users'
            }
            [pscustomobject]@{
                Label = 'Workspace overview'
                Description = 'Inspect workspace posture for a tenant.'
                Value = 'Workspace'
            }
            [pscustomobject]@{
                Label = 'Backup overview'
                Description = 'Inspect Microsoft 365 backup coverage for a customer.'
                Value = 'Backup'
            }
            [pscustomobject]@{
                Label = 'New customer (WhatIf)'
                Description = 'Dry-run the onboarding command without making changes.'
                Value = 'NewCustomer'
            }
            [pscustomobject]@{
                Label = 'Exit'
                Description = 'Close Elements Shell.'
                Value = 'Exit'
            }
        ) -Prompt 'Action number'

        Write-Host ''
        switch ($selection) {
            'Connect' {
                Connect-AvptElements | Out-Null
            }
            'Status' {
                Show-AvptShellResult -InputObject (Test-AvptElementsConnection) -AsList
            }
            'CustomerSummary' {
                Show-AvptShellResult -InputObject (Get-AvptCustomerSummary) -AsList
            }
            'TenantSummary' {
                Show-AvptShellResult -InputObject (Get-AvptTenantSummary) -AsList
            }
            'Customers' {
                Show-AvptShellResult -InputObject (Get-AvptCustomer -All)
            }
            'Users' {
                Show-AvptShellResult -InputObject (Get-AvptSecurityUserOverview -All)
            }
            'Workspace' {
                Show-AvptShellResult -InputObject (Get-AvptWorkspaceOverview) -AsList
            }
            'Backup' {
                Show-AvptShellResult -InputObject (Get-AvptBackupOverview)
            }
            'NewCustomer' {
                Write-Host ' New customer onboarding preview will run with -WhatIf.' -ForegroundColor DarkYellow
                $firstName = Read-Host 'First name'
                $lastName = Read-Host 'Last name'
                $organizationName = Read-Host 'Organization name'
                $registrationAccount = Read-Host 'Registration account'
                $password = Read-Host 'Temporary password'
                $countryCode = Read-Host 'Country code (2 letters)'

                New-AvptCustomer -FirstName $firstName -LastName $lastName -OrganizationName $organizationName `
                    -RegistrationAccount $registrationAccount -Password $password -CountryCode $countryCode -WhatIf
            }
            'Exit' {
                return
            }
        }
    }
}
