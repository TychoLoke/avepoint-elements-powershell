function Add-AvptCustomerService {
    <#
    .SYNOPSIS
    Adds an AvePoint service subscription to a customer.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [string] $CustomerId,
        [int] $ProductType,
        [Parameter(Mandatory)]
        [ValidateSet(0, 1)]
        [int] $LicenseType,
        [ValidateSet(0, 1)]
        [int] $AvePointStorageType,
        [ValidateRange(1, 99)]
        [int] $RetentionYear,
        [switch] $Byos,
        [string] $StorageProfileId,
        [object[]] $LicenseItem
    )

    $CustomerId = (Resolve-AvptCustomerSelection -CustomerId $CustomerId).CustomerId
    $ProductType = Resolve-AvptProductTypeSelection -ProductType $ProductType

    if ($Byos) {
        if (-not $StorageProfileId) {
            throw 'StorageProfileId is required when -Byos is used.'
        }
    }
    elseif (-not $PSBoundParameters.ContainsKey('AvePointStorageType') -or -not $PSBoundParameters.ContainsKey('RetentionYear')) {
        throw 'Either specify -Byos with -StorageProfileId, or provide -AvePointStorageType and -RetentionYear.'
    }

    if ($LicenseType -eq 1 -and (-not $LicenseItem -or @($LicenseItem).Count -eq 0)) {
        throw 'LicenseItem is required for enterprise subscriptions.'
    }

    $body = @{
        product     = $ProductType
        licenseType = $LicenseType
    }

    if ($Byos) {
        $body.byos = $true
        $body.storageProfileId = $StorageProfileId
    }
    else {
        $body.avepointStorageType = $AvePointStorageType
        $body.retentionYear = $RetentionYear
        $body.byos = $false
    }

    if ($LicenseItem) { $body.licenseItems = $LicenseItem }

    $productLabel = $ProductType
    $catalogItem = @(Get-AvptProductTypeCatalog | Where-Object ProductType -eq $ProductType)[0]
    if ($catalogItem) { $productLabel = $catalogItem.Name }

    if ($PSCmdlet.ShouldProcess($CustomerId, "Add AvePoint service '$productLabel'")) {
        $path = "/partner/external/v3/general/customers/$CustomerId/services"
        $response = Invoke-AvptWebRequest -Method Post -Path $path -Body $body -ScopeBundle 'Common'
        $result = ConvertTo-AvptFriendlyObject -InputObject $response -TypeName 'AvePoint.Elements.AddCustomerServiceResult'
        $result | Add-Member -NotePropertyName ProductType -NotePropertyValue $ProductType
        $result | Add-Member -NotePropertyName ProductName -NotePropertyValue $productLabel
        $result | Add-Member -NotePropertyName CustomerId -NotePropertyValue $CustomerId
        $result
    }
}
