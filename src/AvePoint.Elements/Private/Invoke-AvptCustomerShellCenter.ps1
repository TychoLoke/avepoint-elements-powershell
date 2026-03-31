function Invoke-AvptCustomerShellCenter {
    [CmdletBinding()]
    param()

    while ($true) {
        Clear-Host
        Show-AvptBanner
        Show-AvptShellPanel -Title 'Customer Center' -Lines @(
            'Customer-focused workflows and summaries'
            'All actions support guided customer selection'
        ) -AccentColor 'Blue'
        Write-Host ''

        $selection = Read-AvptChoice -Title 'Choose a customer action:' -Options @(
            [pscustomobject]@{ Label = 'Customer summary'; Description = 'Services, tenants, and backup totals'; Value = 'Summary' }
            [pscustomobject]@{ Label = 'Customer services'; Description = 'Assigned AvePoint products and subscriptions'; Value = 'Services' }
            [pscustomobject]@{ Label = 'Backup overview'; Description = 'Module-level backup coverage'; Value = 'Backup' }
            [pscustomobject]@{ Label = 'Product overview'; Description = 'Purchased seats for a selected product'; Value = 'ProductOverview' }
            [pscustomobject]@{ Label = 'Back'; Description = 'Return to the main dashboard'; Value = 'Back' }
        ) -Prompt 'Customer action'

        switch ($selection) {
            'Summary' { Invoke-AvptShellResultAction -InputObject (Get-AvptCustomerSummary) -Title 'Customer Summary' -AsList }
            'Services' { Invoke-AvptShellResultAction -InputObject (Get-AvptCustomerService) -Title 'Customer Services' }
            'Backup' { Invoke-AvptShellResultAction -InputObject (Get-AvptBackupOverview) -Title 'Backup Overview' }
            'ProductOverview' { Invoke-AvptShellResultAction -InputObject (Get-AvptProductOverview) -Title 'Product Overview' -AsList }
            'Back' { return }
        }
    }
}
