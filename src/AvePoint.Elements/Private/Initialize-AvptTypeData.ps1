function Initialize-AvptTypeData {
    [CmdletBinding()]
    param()

    $typeDisplaySets = @{
        'AvePoint.Elements.Customer' = @('organization', 'ownerEmail', 'countryOrRegion', 'ManagementModeName', 'TenantCount', 'JobStatusName')
        'AvePoint.Elements.CustomerService' = @('organization', 'customer', 'ProductCount', 'ServiceNames')
        'AvePoint.Elements.ProductOverview' = @('productType', 'purchasedUserSeat')
        'AvePoint.Elements.BackupOverview' = @('customer', 'serviceModule', 'totalScannedObjects', 'totalProtectedObjects', 'dataSizeStoredInAvePoint')
        'AvePoint.Elements.BackupJob' = @('jobId', 'JobTypeName', 'jobModule', 'StatusName')
        'AvePoint.Elements.ScanProfile' = @('profileName', 'ScanModeName', 'modifiedTime', 'profileId')
        'AvePoint.Elements.Baseline' = @('baselineName', 'StatusName', 'baselineId')
        'AvePoint.Elements.BaselineTenant' = @('tenantName', 'StatusName', 'baselineName', 'tenantId')
        'AvePoint.Elements.BaselineReport' = @('reportId', 'baselineId', 'tenantId')
        'AvePoint.Elements.RiskRule' = @('ruleId', 'ruleName', 'DataSourceName', 'hitItemCount')
        'AvePoint.Elements.RiskHitItem' = @('name', 'DataSourceName', 'severity', 'path')
        'AvePoint.Elements.SecurityUserOverview' = @('displayName', 'userPrincipalName', 'mail', 'StatusNames', 'company', 'department')
        'AvePoint.Elements.User' = @('displayName', 'loginName', 'mail', 'StatusNames', 'jobTitle', 'department', 'usageLocation')
        'AvePoint.Elements.WorkspaceOverview' = @('workspaces', 'activeWorkspaces', 'orphanedWorkspaces', 'workspacesWithGuestUsers', 'reachingStorageLimitWorkspaces')
        'AvePoint.Elements.WorkspaceCompliance' = @('workspacesInCompliance', 'workspacesOutOfCompliance', 'ComplianceRate')
        'AvePoint.Elements.WorkspaceDataSecurityPosture' = @(
            'sensitiveItemsSharedWithEveryone'
            'sensitiveItemsSharedWithEveryoneExceptExternalUsers'
            'sensitiveItemsSharedViaAnyoneLink'
            'sensitiveItemsSharedViaLinkForSpecificExternalUsers'
            'sensitiveItemsSharedViaOrganizationLink'
        )
        'AvePoint.Elements.WorkspaceDataProtectionStatistic' = @(
            'teamsUnderPotentialRansomwareAttack'
            'sharePointSitesUnderPotentialRansomwareAttack'
            'oneDrivesUnderPotentialRansomwareAttack'
            'groupsUnderPotentialRansomwareAttack'
            'teamsWithSuspiciousObjects'
            'sharePointSitesWithSuspiciousObjects'
        )
    }

    foreach ($typeName in $typeDisplaySets.Keys) {
        Update-TypeData -TypeName $typeName -DefaultDisplayPropertySet $typeDisplaySets[$typeName] -Force -ErrorAction SilentlyContinue
    }
}
