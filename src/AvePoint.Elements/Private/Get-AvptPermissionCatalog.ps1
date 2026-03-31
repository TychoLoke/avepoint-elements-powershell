function Get-AvptPermissionCatalog {
    [CmdletBinding()]
    param()

    @(
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'CustomersRead'
            Scope       = 'elements.customers.read.all'
            AccessLevel = 'Read'
            Description = 'Read customer records and partner customer visibility.'
        }
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'CustomersReadWrite'
            Scope       = 'elements.customers.readwrite.all'
            AccessLevel = 'ReadWrite'
            Description = 'Create and modify customer records.'
        }
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'LicenseRead'
            Scope       = 'elements.license.read.all'
            AccessLevel = 'Read'
            Description = 'Read product overview, tenant seat, and licensing visibility.'
        }
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'LicenseReadWrite'
            Scope       = 'elements.license.readwrite.all'
            AccessLevel = 'ReadWrite'
            Description = 'Modify licensing-related records when supported.'
        }
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'ScanProfilesRead'
            Scope       = 'elements.scanprofiles.read.all'
            AccessLevel = 'Read'
            Description = 'Read scan profile definitions, detail, and changes.'
        }
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'JobsRead'
            Scope       = 'elements.jobs.read.all'
            AccessLevel = 'Read'
            Description = 'Read operational and backup job information.'
        }
        [pscustomobject]@{
            Category    = 'Common'
            Name        = 'ProtectedObjectsRead'
            Scope       = 'elements.cbprotected.read.all'
            AccessLevel = 'Read'
            Description = 'Read Cloud Backup protected object visibility.'
        }
        [pscustomobject]@{
            Category    = 'BaselineManagement'
            Name        = 'BaselineRead'
            Scope       = 'elements.bm.baseline.read.all'
            AccessLevel = 'Read'
            Description = 'Read baselines and baseline reports.'
        }
        [pscustomobject]@{
            Category    = 'BaselineManagement'
            Name        = 'BaselineReadWrite'
            Scope       = 'elements.bm.baseline.readwrite.all'
            AccessLevel = 'ReadWrite'
            Description = 'Create and modify baselines.'
        }
        [pscustomobject]@{
            Category    = 'BaselineManagement'
            Name        = 'TenantMonitorRead'
            Scope       = 'elements.bm.tenant.read.all'
            AccessLevel = 'Read'
            Description = 'Read tenant monitor and baseline tenant visibility.'
        }
        [pscustomobject]@{
            Category    = 'BaselineManagement'
            Name        = 'TenantMonitorReadWrite'
            Scope       = 'elements.bm.tenant.readwrite.all'
            AccessLevel = 'ReadWrite'
            Description = 'Run tenant monitor actions and modify tenant monitor data.'
        }
        [pscustomobject]@{
            Category    = 'RiskManagement'
            Name        = 'RiskRead'
            Scope       = 'elements.rm.read.all'
            AccessLevel = 'Read'
            Description = 'Read risk rules and hit items.'
        }
        [pscustomobject]@{
            Category    = 'UserManagement'
            Name        = 'UserRead'
            Scope       = 'elements.um.user.read.all'
            AccessLevel = 'Read'
            Description = 'Read users and security user overview data.'
        }
        [pscustomobject]@{
            Category    = 'UserManagement'
            Name        = 'UserReadWrite'
            Scope       = 'elements.um.user.readwrite.all'
            AccessLevel = 'ReadWrite'
            Description = 'Modify user management data when supported.'
        }
        [pscustomobject]@{
            Category    = 'WorkspaceManagement'
            Name        = 'WorkspaceRead'
            Scope       = 'elements.wm.read.all'
            AccessLevel = 'Read'
            Description = 'Read workspace overview, compliance, and posture data.'
        }
    )
}

