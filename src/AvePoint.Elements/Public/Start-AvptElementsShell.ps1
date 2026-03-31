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
                Label = 'Customer: summary'
                Description = 'Open a customer operational summary with services and backup totals.'
                Value = 'CustomerSummary'
            }
            [pscustomobject]@{
                Label = 'Tenant: summary'
                Description = 'Open a tenant operational summary across users, workspace, and protection.'
                Value = 'TenantSummary'
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
                Show-AvptShellResult -InputObject (Test-AvptElementsConnection) -AsList -Title 'Connection Status'
                Wait-AvptShellContinue
            }
            'CustomerSummary' {
                Show-AvptShellResult -InputObject (Get-AvptCustomerSummary) -AsList -Title 'Customer Summary'
                Wait-AvptShellContinue
            }
            'TenantSummary' {
                Show-AvptShellResult -InputObject (Get-AvptTenantSummary) -AsList -Title 'Tenant Summary'
                Wait-AvptShellContinue
            }
            'Customers' {
                Show-AvptShellResult -InputObject (Get-AvptCustomer -All) -Title 'Customers'
                Wait-AvptShellContinue
            }
            'Users' {
                Show-AvptShellResult -InputObject (Get-AvptSecurityUserOverview -All) -Title 'Security Users'
                Wait-AvptShellContinue
            }
            'Workspace' {
                Show-AvptShellResult -InputObject (Get-AvptWorkspaceOverview) -AsList -Title 'Workspace Overview'
                Wait-AvptShellContinue
            }
            'Backup' {
                Show-AvptShellResult -InputObject (Get-AvptBackupOverview) -Title 'Backup Overview'
                Wait-AvptShellContinue
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
