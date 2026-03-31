function Get-AvptProductTypeCatalog {
    [CmdletBinding()]
    param()

    @(
        [pscustomobject]@{ ProductType = 1; Name = 'DocAve Online' }
        [pscustomobject]@{ ProductType = 4; Name = 'Cloud Governance' }
        [pscustomobject]@{ ProductType = 32; Name = 'Cloud Backup for Salesforce' }
        [pscustomobject]@{ ProductType = 40; Name = 'Baseline Management' }
        [pscustomobject]@{ ProductType = 41; Name = 'Risk Management' }
        [pscustomobject]@{ ProductType = 42; Name = 'Workspace Management' }
        [pscustomobject]@{ ProductType = 49; Name = 'User Management' }
        [pscustomobject]@{ ProductType = 60; Name = 'MyHub' }
        [pscustomobject]@{ ProductType = 65; Name = 'Workspace Management - Storage Optimization' }
        [pscustomobject]@{ ProductType = 257; Name = 'TyGraph' }
        [pscustomobject]@{ ProductType = 2048; Name = 'Cloud Backup for Microsoft 365' }
        [pscustomobject]@{ ProductType = 4096; Name = 'Cloud Management' }
        [pscustomobject]@{ ProductType = 8192; Name = 'Cloud Archiving' }
        [pscustomobject]@{ ProductType = 65536; Name = 'Opus' }
        [pscustomobject]@{ ProductType = 131072; Name = 'Cloud Backup for Dynamics 365' }
        [pscustomobject]@{ ProductType = 4194304; Name = 'Insights' }
        [pscustomobject]@{ ProductType = 8388608; Name = 'Policies for Microsoft 365' }
        [pscustomobject]@{ ProductType = 16777216; Name = 'Fly' }
        [pscustomobject]@{ ProductType = 33554432; Name = 'Cloud Backup for Google Workspace' }
        [pscustomobject]@{ ProductType = 67108864; Name = 'Cense' }
        [pscustomobject]@{ ProductType = 134217728; Name = 'Enpower' }
        [pscustomobject]@{ ProductType = 1073741824; Name = 'Cloud Backup for IaaS + PaaS' }
    )
}

