function Get-AvptCustomerSummary {
    <#
    .SYNOPSIS
    Retrieves an operator-friendly customer summary built from multiple Elements endpoints.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [switch] $Raw
    )

    $customerContext = Resolve-AvptCustomerSelection -CustomerId $CustomerId
    $customer = @(Get-AvptCustomer -CustomerId $customerContext.CustomerId)[0]
    $services = @(Get-AvptCustomerService -CustomerId $customerContext.CustomerId)
    $backup = @(Get-AvptBackupOverview -CustomerId $customerContext.CustomerId)

    if ($Raw) {
        return [pscustomobject]@{
            Customer        = $customer
            CustomerService = $services
            BackupOverview  = $backup
        }
    }

    $allProducts = @()
    foreach ($service in $services) {
        $allProducts += @($service.products)
    }

    $storageValues = foreach ($item in $backup) {
        $rawValue = [string] $item.dataSizeStoredInAvePoint
        if ($rawValue -match '^[0-9]+(\.[0-9]+)?\s+GB$') {
            [double] ($rawValue -replace '\s+GB$', '')
        }
    }

    $summary = [pscustomobject]@{
        CustomerId             = $customer.id
        Organization           = $customer.organization
        OwnerEmail             = $customer.ownerEmail
        CountryOrRegion        = $customer.countryOrRegion
        ManagementMode         = $customer.ManagementModeName
        TenantCount            = $customer.TenantCount
        TenantNames            = $customer.TenantNames
        ProductCount           = @($allProducts).Count
        ServiceNames           = (($services | ForEach-Object { $_.ServiceNames } | Where-Object { $_ }) -join ', ')
        BackupModuleCount      = @($backup).Count
        ProtectedObjectCount   = [int] (@($backup | Measure-Object -Property totalProtectedObjects -Sum).Sum)
        ScannedObjectCount     = [int] (@($backup | Measure-Object -Property totalScannedObjects -Sum).Sum)
        AvePointStorageGb      = [math]::Round((@($storageValues | Measure-Object -Sum).Sum), 2)
    }
    $summary.PSObject.TypeNames.Insert(0, 'AvePoint.Elements.CustomerSummary')
    $summary
}
