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
        BaselineStatus = @{
            1 = 'RetrievingSettings'
            2 = 'Unused'
            3 = 'Active'
            4 = 'SettingsRetrievalFailed'
            5 = 'RetrievedWithException'
            6 = 'Draft'
        }
        BaselineTenantStatus = @{
            1  = 'Connected'
            2  = 'DeployedWithException'
            3  = 'Deploying'
            4  = 'DeploymentDraftSaved'
            5  = 'DeploymentFailed'
            6  = 'Expired'
            7  = 'Deployed'
            8  = 'RestoreFailed'
            9  = 'Restored'
            10 = 'RestoredWithException'
            11 = 'Restoring'
            12 = 'RetrievingSetting'
            13 = 'ReviewDeployment'
            14 = 'ReviewRestore'
            15 = 'ScheduledDeployment'
            16 = 'ScheduleRestore'
            17 = 'SettingsRetrievalFailed'
        }
        AutoAlignment = @{
            0 = 'Disabled'
            1 = 'Enabled'
        }
        BaselineJobType = @{
            1 = 'ApplyBaseline'
            2 = 'AutoAlignment'
            3 = 'CreateBaseline'
            4 = 'DetectDrift'
            5 = 'Deploy'
            6 = 'DeployDetectedDeviations'
            7 = 'DailyTenantBackup'
            8 = 'EditTenantConfigurations'
            9 = 'RestoreToSpecificDate'
            10 = 'Restore'
        }
        BaselineJobStatus = @{
            0 = 'Waiting'
            1 = 'InProgress'
            2 = 'Finished'
            3 = 'Failed'
            4 = 'Skipped'
            5 = 'FinishedWithException'
        }
        RiskDataSource = @{
            1  = 'Exchange'
            2  = 'Groups'
            3  = 'Teams'
            4  = 'SharePoint'
            5  = 'OneDrive'
            6  = 'Users'
            8  = 'Environments'
            9  = 'Connections'
            10 = 'PowerApps'
            11 = 'PowerAutomate'
            12 = 'PowerBI'
        }
        RiskRuleStatus = @{
            0 = 'Disabled'
            1 = 'Enabled'
        }
        CustomerOnboardingStatus = @{
            1 = 'Successful'
            2 = 'Failed'
            3 = 'CustomerDoesNotExist'
            4 = 'CustomerRegistrationFailed'
            5 = 'AlreadyManagedByCurrentPartner'
            6 = 'SameAsCurrentPartner'
            7 = 'CustomerAlreadyExists'
        }
        UserStatus = @{
            0 = 'MfaDisabled'
            1 = 'SignInBlocked'
            2 = 'PasswordExpired'
            3 = 'HighRisk'
            4 = 'MediumRisk'
            5 = 'Compliance'
            6 = 'Inactive'
            7 = 'PendingDeletion'
            8 = 'TestUser'
        }
    }
}
