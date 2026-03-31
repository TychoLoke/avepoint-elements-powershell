$clientSecret = ConvertTo-SecureString 'your-client-secret' -AsPlainText -Force
$credential = [pscredential]::new('your-client-id', $clientSecret)

Connect-AvptElements `
    -Environment Commercial `
    -Credential $credential `
    -TenantName 'contoso-demo' `
    -Scope @(
        'elements.customers.read.all'
        'elements.license.read.all'
    )

# Or use the built-in scope menu.
Connect-AvptElements `
    -Environment Commercial `
    -Credential $credential `
    -UseScopeMenu

# Or initialize separate tokens for all endpoint families.
Connect-AvptElements `
    -Environment Commercial `
    -Credential $credential `
    -ScopeBundle Common,Baseline,User,Risk,Workspace

# Or run the full guided onboarding flow.
Connect-AvptElements

# Example read-only operations.
Get-AvptCustomer -All
Get-AvptBackupOverview -CustomerId '00000000-0000-0000-0000-000000000000'
Get-AvptScanProfile -CustomerId '00000000-0000-0000-0000-000000000000'
Get-AvptBaseline -All
Get-AvptRiskRule -CustomerId '00000000-0000-0000-0000-000000000000' -TenantId '11111111-1111-1111-1111-111111111111'

# Friendly selection without copying IDs.
Get-AvptBackupOverview
Get-AvptProductOverview
Get-AvptUser
Get-AvptWorkspaceOverview
Get-AvptCustomerSummary
Get-AvptTenantSummary

# Safe write actions.
New-AvptCustomer -FirstName 'Alex' -LastName 'Morgan' -OrganizationName 'Contoso MSP Demo' `
    -RegistrationAccount 'admin@contoso-demo.onmicrosoft.com' -Password 'UseATemporaryPassword123!' `
    -CountryCode 'US' -WhatIf
