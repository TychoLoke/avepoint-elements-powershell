function Get-AvptScopeBundleCatalog {
    [CmdletBinding()]
    param()

    @(
        [pscustomobject]@{
            Name        = 'Common'
            Description = 'Customers, services, licensing, scan profiles, jobs, and protected-object visibility.'
            Scope       = @(
                'elements.customers.read.all'
                'elements.customers.readwrite.all'
                'elements.license.read.all'
                'elements.license.readwrite.all'
                'elements.scanprofiles.read.all'
                'elements.jobs.read.all'
                'elements.cbprotected.read.all'
            )
        }
        [pscustomobject]@{
            Name        = 'Baseline'
            Description = 'Baseline management, tenant monitor visibility, and tenant monitor actions.'
            Scope       = @(
                'elements.bm.baseline.read.all'
                'elements.bm.baseline.readwrite.all'
                'elements.bm.tenant.read.all'
                'elements.bm.tenant.readwrite.all'
            )
        }
        [pscustomobject]@{
            Name        = 'User'
            Description = 'Security user overview and user management operations.'
            Scope       = @(
                'elements.um.user.read.all'
                'elements.um.user.readwrite.all'
            )
        }
        [pscustomobject]@{
            Name        = 'Risk'
            Description = 'Risk rule and matched object visibility.'
            Scope       = @(
                'elements.rm.read.all'
            )
        }
        [pscustomobject]@{
            Name        = 'Workspace'
            Description = 'Workspace overview, compliance, posture, and data-protection statistics.'
            Scope       = @(
                'elements.wm.read.all'
            )
        }
    )
}

