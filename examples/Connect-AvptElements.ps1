$clientSecret = ConvertTo-SecureString 'your-client-secret' -AsPlainText -Force
$credential = [pscredential]::new('your-client-id', $clientSecret)

Connect-AvptElements `
    -Environment Commercial `
    -Credential $credential `
    -TenantName 'contoso-demo' `
    -Scope 'your.scope.value'
