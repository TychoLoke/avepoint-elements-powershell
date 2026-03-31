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
