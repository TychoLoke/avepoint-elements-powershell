function Get-AvptEnumMap {
    [CmdletBinding()]
    param()

    @{
        JobStatus = @{
            0 = 'N/A'
            1 = 'Working'
            2 = 'Failed'
            3 = 'WaitingForConfiguration'
            4 = 'MultipleIssuesFound'
            5 = 'FinishedWithException'
            6 = 'NoBackupUpdates'
        }
        ManagementMode = @{
            0 = 'CustomerManaged'
            1 = 'PartnerManaged'
            2 = 'ToBeConfigured'
        }
        ScanMode = @{
            0 = 'Express'
            1 = 'Advanced'
        }
        TenantType = @{
            0 = 'Microsoft365'
            1 = 'Salesforce'
            2 = 'Google'
            3 = 'Dynamics365'
        }
        JobType = @{
            0  = 'Microsoft365Scan'
            7  = 'Microsoft365'
            10 = 'GoogleWorkspaceScan'
            11 = 'GoogleWorkspace'
            12 = 'IaaSPaaS'
            15 = 'Salesforce'
            16 = 'Dynamics365'
        }
        Status = @{
            0  = 'None'
            1  = 'Running'
            2  = 'Finished'
            3  = 'Failed'
            4  = 'FinishedWithException'
            5  = 'Skipped'
            6  = 'Pending'
            7  = 'FailedToStart'
            8  = 'Canceled'
            9  = 'Rejected'
            10 = 'Stopped'
            11 = 'NotScanned'
            12 = 'Disabled'
            13 = 'NotStarted'
            14 = 'WaitingForConfiguration'
        }
        LastScanStatus = @{
            0  = 'None'
            1  = 'Running'
            2  = 'Finished'
            3  = 'Failed'
            4  = 'FinishedWithException'
            5  = 'Skipped'
            6  = 'Pending'
            7  = 'FailedToStart'
            8  = 'Canceled'
            9  = 'Rejected'
            10 = 'Stopped'
            11 = 'NotScanned'
            12 = 'Disabled'
            13 = 'NotStarted'
            14 = 'WaitingForConfiguration'
        }
    }
}

