function Start-AvptElementsShell {
    <#
    .SYNOPSIS
    Starts the interactive Elements Shell experience.
    #>
    [CmdletBinding()]
    param(
        [switch] $SkipConnect
    )

    $state = Get-AvptModuleState
    if (-not $state.Connection -and -not $SkipConnect) {
        Connect-AvptElements | Out-Null
    }

    while ($true) {
        Clear-Host
        Show-AvptBanner
        Write-Host ' APPLICATION MODE' -ForegroundColor White
        Write-Host ' Dashboard-driven access to common AvePoint Elements workflows' -ForegroundColor DarkGray
        Write-Host ''
        Show-AvptShellDashboard
        Write-Host ''

        $selection = Read-AvptChoice -Title 'Choose an Elements Shell action:' -Options @(
            [pscustomobject]@{
                Label = 'Session: connect or reconnect'
                Description = 'Open guided onboarding and refresh the current session.'
                Value = 'Connect'
            }
            [pscustomobject]@{
                Label = 'Session: inspect connection'
                Description = 'Show the current session, token bundle, and expiry information.'
                Value = 'Status'
            }
            [pscustomobject]@{
                Label = 'Customer center'
                Description = 'Open customer workflows, summaries, services, and backup views.'
                Value = 'CustomerCenter'
            }
            [pscustomobject]@{
                Label = 'Tenant center'
                Description = 'Open tenant workflows, security views, and workspace posture.'
                Value = 'TenantCenter'
            }
            [pscustomobject]@{
                Label = 'Browse: customers'
                Description = 'List customers in a grid-style default view.'
                Value = 'Customers'
            }
            [pscustomobject]@{
                Label = 'Browse: users'
                Description = 'Open guided security user visibility for a tenant.'
                Value = 'Users'
            }
            [pscustomobject]@{
                Label = 'Browse: workspace overview'
                Description = 'Inspect workspace posture and storage signals for a tenant.'
                Value = 'Workspace'
            }
            [pscustomobject]@{
                Label = 'Browse: backup overview'
                Description = 'Inspect Microsoft 365 backup coverage by service module.'
                Value = 'Backup'
            }
            [pscustomobject]@{
                Label = 'Action: new customer preview'
                Description = 'Guide a dry-run onboarding flow without creating anything.'
                Value = 'NewCustomer'
            }
            [pscustomobject]@{
                Label = 'Exit application'
                Description = 'Close Elements Shell.'
                Value = 'Exit'
            }
        ) -Prompt 'Action number'

        Clear-Host
        Show-AvptBanner
        switch ($selection) {
            'Connect' {
                Connect-AvptElements | Out-Null
                Wait-AvptShellContinue
            }
            'Status' {
                Invoke-AvptShellResultAction -InputObject (Test-AvptElementsConnection) -AsList -Title 'Connection Status'
            }
            'CustomerCenter' {
                Invoke-AvptCustomerShellCenter
            }
            'TenantCenter' {
                Invoke-AvptTenantShellCenter
            }
            'Customers' {
                Invoke-AvptShellResultAction -InputObject (Get-AvptCustomer -All) -Title 'Customers'
            }
            'Users' {
                Invoke-AvptShellResultAction -InputObject (Get-AvptSecurityUserOverview -All) -Title 'Security Users'
            }
            'Workspace' {
                Invoke-AvptShellResultAction -InputObject (Get-AvptWorkspaceOverview) -AsList -Title 'Workspace Overview'
            }
            'Backup' {
                Invoke-AvptShellResultAction -InputObject (Get-AvptBackupOverview) -Title 'Backup Overview'
            }
            'NewCustomer' {
                Show-AvptShellPanel -Title 'New Customer Preview' -Lines @(
                    'This workflow runs New-AvptCustomer with -WhatIf.'
                    'No customer will be created.'
                ) -AccentColor 'DarkYellow'
                $firstName = Read-Host 'First name'
                $lastName = Read-Host 'Last name'
                $organizationName = Read-Host 'Organization name'
                $registrationAccount = Read-Host 'Registration account'
                $password = Read-Host 'Temporary password'
                $countryCode = Read-Host 'Country code (2 letters)'

                New-AvptCustomer -FirstName $firstName -LastName $lastName -OrganizationName $organizationName `
                    -RegistrationAccount $registrationAccount -Password $password -CountryCode $countryCode -WhatIf
                Wait-AvptShellContinue
            }
            'Exit' {
                return
            }
        }
    }
}
