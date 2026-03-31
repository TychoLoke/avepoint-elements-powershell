function Invoke-AvptTenantShellCenter {
    [CmdletBinding()]
    param()

    while ($true) {
        Clear-Host
        Show-AvptBanner
        Show-AvptShellPanel -Title 'Tenant Center' -Lines @(
            'Tenant-focused security, workspace, and posture workflows'
            'All actions support guided tenant selection'
        ) -AccentColor 'Blue'
        Write-Host ''

        $selection = Read-AvptChoice -Title 'Choose a tenant action:' -Options @(
            [pscustomobject]@{ Label = 'Tenant summary'; Description = 'Users, workspace, and protection rollup'; Value = 'Summary' }
            [pscustomobject]@{ Label = 'Security users'; Description = 'Guided security user overview'; Value = 'Users' }
            [pscustomobject]@{ Label = 'Workspace overview'; Description = 'Workspace counts and storage signals'; Value = 'Workspace' }
            [pscustomobject]@{ Label = 'Workspace compliance'; Description = 'Compliance rate and evaluated workspace counts'; Value = 'Compliance' }
            [pscustomobject]@{ Label = 'Data security posture'; Description = 'Sensitive exposure indicators'; Value = 'Posture' }
            [pscustomobject]@{ Label = 'Data protection statistics'; Description = 'Ransomware and suspicious activity indicators'; Value = 'Protection' }
            [pscustomobject]@{ Label = 'Back'; Description = 'Return to the main dashboard'; Value = 'Back' }
        ) -Prompt 'Tenant action'

        switch ($selection) {
            'Summary' { Invoke-AvptShellResultAction -InputObject (Get-AvptTenantSummary) -Title 'Tenant Summary' -AsList }
            'Users' { Invoke-AvptShellResultAction -InputObject (Get-AvptSecurityUserOverview -All) -Title 'Security Users' }
            'Workspace' { Invoke-AvptShellResultAction -InputObject (Get-AvptWorkspaceOverview) -Title 'Workspace Overview' -AsList }
            'Compliance' { Invoke-AvptShellResultAction -InputObject (Get-AvptWorkspaceCompliance) -Title 'Workspace Compliance' -AsList }
            'Posture' { Invoke-AvptShellResultAction -InputObject (Get-AvptWorkspaceDataSecurityPosture) -Title 'Data Security Posture' -AsList }
            'Protection' { Invoke-AvptShellResultAction -InputObject (Get-AvptWorkspaceDataProtectionStatistic) -Title 'Data Protection Statistics' -AsList }
            'Back' { return }
        }
    }
}
