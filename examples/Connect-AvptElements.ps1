$clientSecret = ConvertTo-SecureString 'your-client-secret' -AsPlainText -Force
$credential = [pscredential]::new('your-client-id', $clientSecret)

Connect-AvptElements `
    -Environment Production `
    -Credential $credential `
    -TenantName 'contoso-demo'

