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
            'Connect-AvptElements'
            'Disconnect-AvptElements'
            'Get-AvptBackupJob'
            'Get-AvptBackupOverview'
            'Get-AvptBaseline'
            'Get-AvptBaselineReport'
            'Get-AvptBaselineTenant'
            'Get-AvptCustomer'
            'Get-AvptCustomerService'
            'Get-AvptPermissionScope'
            'Get-AvptProductOverview'
            'Get-AvptRiskHitItem'
            'Get-AvptRiskRule'
            'Get-AvptScanProfile'
            'Get-AvptScanProfileChange'
            'Get-AvptScanProfileDetail'
            'Get-AvptScopeBundle'
            'Get-AvptTenantSeat'
            'Invoke-AvptTenantMonitorAction'
            'New-AvptBaseline'
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
