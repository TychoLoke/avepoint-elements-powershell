BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '../src/AvePoint.Elements/AvePoint.Elements.psd1'
    Import-Module $modulePath -Force
}

Describe 'AvePoint.Elements module manifest' {
    It 'imports successfully' {
        Get-Module AvePoint.Elements | Should -Not -BeNullOrEmpty
    }

    It 'exports the expected public functions' {
        (Get-Command -Module AvePoint.Elements).Name | Should -Be @(
            'Add-AvptCustomerService'
            'Connect-AvptElements'
            'Disconnect-AvptElements'
            'Get-AvptBackupJob'
            'Get-AvptBackupOverview'
            'Get-AvptBaseline'
            'Get-AvptBaselineReport'
            'Get-AvptBaselineTenant'
            'Get-AvptCustomer'
            'Get-AvptCustomerService'
            'Get-AvptCustomerSummary'
            'Get-AvptPermissionScope'
            'Get-AvptProductOverview'
            'Get-AvptRiskHitItem'
            'Get-AvptRiskRule'
            'Get-AvptScanProfile'
            'Get-AvptScanProfileChange'
            'Get-AvptScanProfileDetail'
            'Get-AvptScopeBundle'
            'Get-AvptSecurityUserOverview'
            'Get-AvptTenantSeat'
            'Get-AvptTenantSummary'
            'Get-AvptUser'
            'Get-AvptUsers'
            'Get-AvptWorkspaceCompliance'
            'Get-AvptWorkspaceDataProtectionStatistic'
            'Get-AvptWorkspaceDataSecurityPosture'
            'Get-AvptWorkspaceOverview'
            'Invoke-AvptTenantMonitorAction'
            'New-AvptBaseline'
            'New-AvptCustomer'
            'Start-AvptElementsShell'
            'Test-AvptElementsConnection'
            'Test-AvptScopeSet'
        )
    }
}

Describe 'Get-AvptScopeBundle' {
    It 'returns the built-in scope bundles' {
        $result = Get-AvptScopeBundle
        ($result.Name | Sort-Object) | Should -Be @('Baseline', 'Common', 'Risk', 'User', 'Workspace')
    }
}

Describe 'Get-AvptPermissionScope' {
    It 'returns the built-in permission catalog' {
        $result = Get-AvptPermissionScope
        $result.Count | Should -Be 15
        ($result.Scope -contains 'elements.customers.read.all') | Should -BeTrue
    }

    It 'filters read-only permissions' {
        $result = Get-AvptPermissionScope -AccessLevel Read
        ($result.AccessLevel | Select-Object -Unique) | Should -Be 'Read'
    }
}

Describe 'Connect-AvptElements' {
    It 'stores connection state for client secret authentication' {
        InModuleScope AvePoint.Elements {
            Mock Request-AvptAccessToken {
                [pscustomobject]@{
                    AccessToken = 'token-value'
                    ExpiresAt   = [DateTimeOffset]::UtcNow.AddHours(1)
                    Scope       = @('elements.customers.read.all')
                    TokenType   = 'Bearer'
                }
            }

            $secret = ConvertTo-SecureString 'sample-secret' -AsPlainText -Force
            $credential = [pscredential]::new('client-id', $secret)

            $session = Connect-AvptElements -Credential $credential -Scope 'elements.customers.read.all' -PassThru

            $session.ClientId | Should -Be 'client-id'
            $session.AuthType | Should -Be 'ClientSecret'
            (Get-AvptModuleState).Token.AccessToken | Should -Be 'token-value'
        }
    }

    It 'initializes named scope bundles into the token cache' {
        InModuleScope AvePoint.Elements {
            Mock Request-AvptAccessToken {
                [pscustomobject]@{
                    AccessToken = ('token-' + (($Scope -join '|').GetHashCode()))
                    ExpiresAt   = [DateTimeOffset]::UtcNow.AddHours(1)
                    Scope       = @($Scope)
                    TokenType   = 'Bearer'
                }
            }

            $secret = ConvertTo-SecureString 'sample-secret' -AsPlainText -Force
            $credential = [pscredential]::new('client-id', $secret)

            $session = Connect-AvptElements -Credential $credential -ScopeBundle Common,Baseline,User,Risk,Workspace -PassThru

            $session.ScopeBundle.Count | Should -Be 5
            (Get-AvptModuleState).TokenCache['Common'] | Should -Not -BeNullOrEmpty
            (Get-AvptModuleState).TokenCache['Baseline'] | Should -Not -BeNullOrEmpty
            (Get-AvptModuleState).TokenCache['User'] | Should -Not -BeNullOrEmpty
            (Get-AvptModuleState).TokenCache['Risk'] | Should -Not -BeNullOrEmpty
            (Get-AvptModuleState).TokenCache['Workspace'] | Should -Not -BeNullOrEmpty
        }
    }

    It 'uses guided onboarding when called without auth parameters' {
        InModuleScope AvePoint.Elements {
            Mock Start-AvptConnectOnboarding {
                [pscustomobject]@{
                    Environment = 'Commercial'
                    TenantName  = 'contoso-demo'
                    Scope       = @('elements.customers.read.all')
                    Credential  = [pscredential]::new(
                        'client-id',
                        (ConvertTo-SecureString 'sample-secret' -AsPlainText -Force)
                    )
                }
            }

            Mock Request-AvptAccessToken {
                [pscustomobject]@{
                    AccessToken = 'token-value'
                    ExpiresAt   = [DateTimeOffset]::UtcNow.AddHours(1)
                    Scope       = @('elements.customers.read.all')
                    TokenType   = 'Bearer'
                }
            }

            $session = Connect-AvptElements -PassThru

            $session.ClientId | Should -Be 'client-id'
            $session.TenantName | Should -Be 'contoso-demo'
            $session.GrantedScope | Should -Contain 'elements.customers.read.all'
        }
    }
}

Describe 'Disconnect-AvptElements' {
    It 'clears connection state' {
        InModuleScope AvePoint.Elements {
            $state = Get-AvptModuleState
            $state.Connection = [pscustomobject]@{ ClientId = 'client-id' }
            $state.Token = [pscustomobject]@{ AccessToken = 'token' }

            Disconnect-AvptElements

            $state.Connection | Should -BeNullOrEmpty
            $state.Token | Should -BeNullOrEmpty
        }
    }
}

Describe 'Test-AvptElementsConnection' {
    It 'returns true in quiet mode when the connection is valid' {
        InModuleScope AvePoint.Elements {
            Mock Get-AvptAccessToken { 'token-value' }

            $state = Get-AvptModuleState
            $state.Connection = [pscustomobject]@{
                Environment = 'Commercial'
                BaseUri     = 'https://graph.avepointonlineservices.com'
                AuthType    = 'ClientSecret'
                Scope       = @('elements.customers.read.all')
                DefaultBundle = $null
            }
            $state.Token = [pscustomobject]@{
                ExpiresAt = [DateTimeOffset]::UtcNow.AddHours(1)
            }
            $state.TokenCache = @{}

            Test-AvptElementsConnection -Quiet | Should -BeTrue
        }
    }
}

Describe 'Test-AvptScopeSet' {
    It 'returns granted scope diagnostics on success' {
        InModuleScope AvePoint.Elements {
            Mock Request-AvptAccessToken {
                [pscustomobject]@{
                    AccessToken = 'token-value'
                    ExpiresAt   = [DateTimeOffset]::UtcNow.AddHours(1)
                    Scope       = @('elements.customers.read.all', 'elements.license.read.all')
                    TokenType   = 'Bearer'
                }
            }

            $secret = ConvertTo-SecureString 'sample-secret' -AsPlainText -Force
            $credential = [pscredential]::new('client-id', $secret)

            $result = Test-AvptScopeSet -Credential $credential -Scope @('elements.customers.read.all', 'elements.license.read.all')

            $result.Success | Should -BeTrue
            $result.RequestedScopeCount | Should -Be 2
            $result.GrantedScopeCount | Should -Be 2
        }
    }
}

Describe 'Read-only cmdlets' {
    It 'uses the Common bundle for customer retrieval' {
        InModuleScope AvePoint.Elements {
            Mock Invoke-AvptPagedOperation {
                @(
                    [pscustomobject]@{
                        id = 'customer-1'
                        organization = 'Contoso'
                        ownerEmail = 'owner@example.com'
                        jobStatus = 0
                        countryOrRegion = 'United States'
                        managementMode = 1
                        tenants = @()
                    }
                )
            } -ParameterFilter { $ScopeBundle -eq 'Common' -and $Path -eq '/partner/external/v3/general/customers/batch' }

            $result = @(Get-AvptCustomer)
            $result[0].ManagementModeName | Should -Be 'PartnerManaged'
            $result[0].TenantCount | Should -Be 0
        }
    }

    It 'allows interactive customer selection for backup overview' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptCustomerSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    Customer   = $null
                }
            }

            Mock Invoke-AvptPagedOperation {
                @(
                    [pscustomobject]@{
                        customerId = 'customer-1'
                        customer = 'owner@example.com'
                        serviceType = 'Cloud Backup for Microsoft 365'
                        serviceModule = 'Exchange Online'
                    }
                )
            } -ParameterFilter { $ScopeBundle -eq 'Common' -and $Path -like '*/cloud-backup-m365/overview' }

            $result = @(Get-AvptBackupOverview)
            $result[0].customerId | Should -Be 'customer-1'
        }
    }

    It 'uses the Common bundle for backup jobs' {
        InModuleScope AvePoint.Elements {
            Mock Invoke-AvptPagedOperation {
                @(
                    [pscustomobject]@{
                        jobType = 7
                        jobModule = 304
                        status = 2
                        jobId = 'job-1'
                    }
                )
            } -ParameterFilter { $ScopeBundle -eq 'Common' -and $Path -like '*/avpt-products/jobs/batch' }

            $result = @(Get-AvptBackupJob -CustomerId 'customer-1')
            $result[0].JobTypeName | Should -Be 'Microsoft365'
            $result[0].StatusName | Should -Be 'Finished'
        }
    }

    It 'uses the Baseline bundle for baseline retrieval' {
        InModuleScope AvePoint.Elements {
            Mock Invoke-AvptPagedOperation {
                @(
                    [pscustomobject]@{
                        baselineId = 'baseline-1'
                        baselineName = 'Baseline A'
                        status = 3
                    }
                )
            } -ParameterFilter { $ScopeBundle -eq 'Baseline' -and $Path -eq '/partner/external/v3/bm/baselines/batch' }

            $result = @(Get-AvptBaseline)
            $result[0].StatusName | Should -Be 'Active'
        }
    }

    It 'uses the Risk bundle for risk rule retrieval' {
        InModuleScope AvePoint.Elements {
            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    result = @(
                        [pscustomobject]@{
                            ruleId = 'rule-1'
                            dataSource = 6
                            hitItemCount = 10
                        }
                    )
                }
            } -ParameterFilter { $ScopeBundle -eq 'Risk' -and $Path -like '*/detection/rules' }

            $result = @(Get-AvptRiskRule -CustomerId 'customer-1' -TenantId 'tenant-1')
            $result[0].DataSourceName | Should -Be 'Users'
        }
    }

    It 'supports baseline creation with ShouldProcess' {
        InModuleScope AvePoint.Elements {
            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    baselineId = 'baseline-1'
                }
            } -ParameterFilter { $ScopeBundle -eq 'Baseline' -and $Path -eq '/partner/external/v3/bm/baselines' }

            $result = New-AvptBaseline -Name 'Baseline A' -Color 0 -CustomerId 'customer-1' -TenantId 'tenant-1' -Confirm:$false
            $result.baselineId | Should -Be 'baseline-1'
        }
    }

    It 'supports customer onboarding with ShouldProcess' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptDataCenterSelection { 'e44bb3ed-f1d8-4055-8c77-c8fd8cd63409' }
            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    id = 'customer-2'
                    status = 1
                }
            } -ParameterFilter { $ScopeBundle -eq 'Common' -and $Path -eq '/partner/external/v3/general/customers' }

            $result = New-AvptCustomer -FirstName 'Alex' -LastName 'Morgan' -OrganizationName 'Contoso Demo' `
                -RegistrationAccount 'admin@example.com' -Password 'Temporary123!' -CountryCode 'US' -Confirm:$false

            $result.StatusName | Should -Be 'Successful'
            $result.OrganizationName | Should -Be 'Contoso Demo'
        }
    }

    It 'supports customer service assignment with ShouldProcess' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptCustomerSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    Customer   = $null
                }
            }
            Mock Resolve-AvptProductTypeSelection { 40 }
            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    status = 1
                    message = 'created'
                }
            } -ParameterFilter { $ScopeBundle -eq 'Common' -and $Path -eq '/partner/external/v3/general/customers/customer-1/services' }

            $result = Add-AvptCustomerService -CustomerId 'customer-1' -ProductType 40 -LicenseType 0 -AvePointStorageType 0 -RetentionYear 1 -Confirm:$false
            $result.ProductName | Should -Be 'Baseline Management'
            $result.CustomerId | Should -Be 'customer-1'
        }
    }

    It 'uses the User bundle for security user overview' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptTenantSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    TenantId   = 'tenant-1'
                }
            }

            Mock Invoke-AvptPagedOperation {
                @(
                    [pscustomobject]@{
                        id = 'user-1'
                        displayName = 'Alex Admin'
                        userPrincipalName = 'alex@example.com'
                        mail = 'alex@example.com'
                        company = 'Contoso'
                        department = 'IT'
                        status = @(0, 1)
                    }
                )
            } -ParameterFilter { $ScopeBundle -eq 'User' -and $Path -like '*/overview/security/users' }

            $result = @(Get-AvptSecurityUserOverview -CustomerId 'customer-1' -TenantId 'tenant-1')
            $result[0].StatusNames | Should -Be 'MfaDisabled, SignInBlocked'
            $result[0].PSObject.TypeNames[0] | Should -Be 'AvePoint.Elements.SecurityUserOverview'
        }
    }

    It 'allows interactive user selection for user detail' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptUserSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    TenantId   = 'tenant-1'
                    UserId     = 'user-1'
                }
            }

            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    id = 'user-1'
                    displayName = 'Alex Admin'
                    loginName = 'alex@example.com'
                    mail = 'alex@example.com'
                    jobTitle = 'Administrator'
                    department = 'IT'
                    usageLocation = 'US'
                    alternateEmailAddress = @('alex.alt@example.com')
                    status = @(5)
                }
            } -ParameterFilter { $ScopeBundle -eq 'User' -and $Path -like '*/users/user-1' }

            $result = Get-AvptUser
            $result.StatusNames | Should -Be 'Compliance'
            $result.AlternateEmailCount | Should -Be 1
        }
    }

    It 'uses the Workspace bundle for workspace overview' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptTenantSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    TenantId   = 'tenant-1'
                }
            }

            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    workspaces = 20
                    activeWorkspaces = 10
                    orphanedWorkspaces = 4
                    workspacesWithGuestUsers = 5
                    reachingStorageLimitWorkspaces = 1
                }
            } -ParameterFilter { $ScopeBundle -eq 'Workspace' -and $Path -like '*/overview/workspace' }

            $result = Get-AvptWorkspaceOverview -CustomerId 'customer-1' -TenantId 'tenant-1'
            $result.GuestWorkspaceRate | Should -Be 25
            $result.OrphanedWorkspaceRate | Should -Be 20
        }
    }

    It 'calculates workspace compliance rate' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptTenantSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    TenantId   = 'tenant-1'
                }
            }

            Mock Invoke-AvptWebRequest {
                [pscustomobject]@{
                    workspacesInCompliance = 75
                    workspacesOutOfCompliance = 25
                }
            } -ParameterFilter { $ScopeBundle -eq 'Workspace' -and $Path -like '*/overview/data-protection/compliance-rate' }

            $result = Get-AvptWorkspaceCompliance -CustomerId 'customer-1' -TenantId 'tenant-1'
            $result.ComplianceRate | Should -Be 75
            $result.TotalWorkspacesEvaluated | Should -Be 100
        }
    }

    It 'builds a customer summary from multiple sources' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptCustomerSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    Customer   = $null
                }
            }
            Mock Get-AvptCustomer {
                [pscustomobject]@{
                    id = 'customer-1'
                    organization = 'Contoso'
                    ownerEmail = 'owner@example.com'
                    countryOrRegion = 'United States'
                    ManagementModeName = 'PartnerManaged'
                    TenantCount = 2
                    TenantNames = 'Tenant A, Tenant B'
                }
            }
            Mock Get-AvptCustomerService {
                @(
                    [pscustomobject]@{
                        ServiceNames = 'Baseline Management'
                        products = @([pscustomobject]@{ service = 'Baseline Management' })
                    }
                    [pscustomobject]@{
                        ServiceNames = 'Workspace Management'
                        products = @([pscustomobject]@{ service = 'Workspace Management' })
                    }
                )
            }
            Mock Get-AvptBackupOverview {
                @(
                    [pscustomobject]@{
                        totalProtectedObjects = 5
                        totalScannedObjects = 7
                        dataSizeStoredInAvePoint = '1.50 GB'
                    }
                    [pscustomobject]@{
                        totalProtectedObjects = 10
                        totalScannedObjects = 20
                        dataSizeStoredInAvePoint = '2.25 GB'
                    }
                )
            }

            $result = Get-AvptCustomerSummary -CustomerId 'customer-1'
            $result.ProductCount | Should -Be 2
            $result.ProtectedObjectCount | Should -Be 15
            $result.AvePointStorageGb | Should -Be 3.75
        }
    }

    It 'builds a tenant summary from user and workspace data' {
        InModuleScope AvePoint.Elements {
            Mock Resolve-AvptTenantSelection {
                [pscustomobject]@{
                    CustomerId = 'customer-1'
                    TenantId   = 'tenant-1'
                }
            }
            Mock Get-AvptSecurityUserOverview {
                @(
                    [pscustomobject]@{ StatusCodes = @(3, 6) }
                    [pscustomobject]@{ StatusCodes = @(8) }
                    [pscustomobject]@{ StatusCodes = @() }
                )
            }
            Mock Get-AvptWorkspaceOverview {
                [pscustomobject]@{
                    workspaces = 50
                    activeWorkspaces = 40
                    orphanedWorkspaces = 5
                    GuestWorkspaceRate = 20
                }
            }
            Mock Get-AvptWorkspaceCompliance {
                [pscustomobject]@{
                    ComplianceRate = 88.5
                }
            }
            Mock Get-AvptWorkspaceDataSecurityPosture {
                [pscustomobject]@{
                    TotalSensitiveExposureSignals = 12
                }
            }
            Mock Get-AvptWorkspaceDataProtectionStatistic {
                [pscustomobject]@{
                    TotalProtectionAlerts = 7
                }
            }

            $result = Get-AvptTenantSummary -CustomerId 'customer-1' -TenantId 'tenant-1'
            $result.HighRiskUserCount | Should -Be 1
            $result.InactiveUserCount | Should -Be 1
            $result.TestUserCount | Should -Be 1
            $result.ProtectionAlerts | Should -Be 7
        }
    }
}

Describe 'Invoke-AvptWebRequest' {
    It 'retries throttled requests and returns parsed content' {
        InModuleScope AvePoint.Elements {
            $calls = 0

            Mock Resolve-AvptUri { 'https://graph.avepointonlineservices.com/partner/customers' }
            Mock Get-AvptAccessToken { 'token-value' }
            Mock Start-Sleep {}
            Mock Invoke-WebRequest {
                $script:calls++

                if ($script:calls -eq 1) {
                    [pscustomobject]@{
                        StatusCode        = 429
                        StatusDescription = 'Too Many Requests'
                        Content           = '{"message":"slow down"}'
                        Headers           = @{ 'Retry-After' = @('0') }
                    }
                }
                else {
                    [pscustomobject]@{
                        StatusCode        = 200
                        StatusDescription = 'OK'
                        Content           = '{"value":[{"id":"1"}]}'
                        Headers           = @{}
                    }
                }
            }

            $result = Invoke-AvptWebRequest -Method Get -Path '/partner/customers'
            $result.value[0].id | Should -Be '1'
        }
    }
}

Describe 'Invoke-AvptPagedRequest' {
    It 'follows nextLink values when -All is used' {
        $result = & (Get-Module AvePoint.Elements) {
            $script:calls = 0

            $requestScript = {
                param($request)
                $script:calls++

                if ($script:calls -eq 1) {
                    [pscustomobject]@{
                        value    = @(
                            [pscustomobject]@{ id = '1' }
                            [pscustomobject]@{ id = '2' }
                        )
                        nextLink = 'https://graph.avepointonlineservices.com/partner/customers?page=2'
                    }
                }
                else {
                    [pscustomobject]@{
                        value    = @(
                            [pscustomobject]@{ id = '3' }
                        )
                        nextLink = $null
                    }
                }
            }

            @(Invoke-AvptPagedRequest -Method Get -Path '/partner/customers' -All -RequestScript $requestScript)
        }

        $result.Count | Should -Be 3
    }
}

Describe 'Start-AvptElementsShell' {
    It 'can start and exit without connecting when SkipConnect is used' {
        InModuleScope AvePoint.Elements {
            Mock Show-AvptBanner {}
            Mock Test-AvptElementsConnection { $false }
            Mock Read-AvptChoice { 'Exit' }

            { Start-AvptElementsShell -SkipConnect } | Should -Not -Throw
        }
    }
}
