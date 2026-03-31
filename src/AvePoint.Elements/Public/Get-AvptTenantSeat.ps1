function Get-AvptTenantSeat {
    <#
    .SYNOPSIS
    Retrieves assigned and available user seats for customer tenants.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,

        [ValidateSet(0, 1, 2, 3)]
        [int] $Type,

        [string[]] $TenantId,

        [ValidateRange(1, 100)]
        [int] $PageSize = 50,

        [switch] $All,
        [switch] $Raw
    )

    $CustomerId = (Resolve-AvptCustomerSelection -CustomerId $CustomerId).CustomerId
    if (-not $PSBoundParameters.ContainsKey('Type')) {
        $typeOptions = @(
            [pscustomobject]@{ Label = 'Microsoft 365'; Description = 'Type 0'; Value = 0 }
            [pscustomobject]@{ Label = 'Salesforce'; Description = 'Type 1'; Value = 1 }
            [pscustomobject]@{ Label = 'Google'; Description = 'Type 2'; Value = 2 }
            [pscustomobject]@{ Label = 'Dynamics 365'; Description = 'Type 3'; Value = 3 }
        )
        $Type = Read-AvptChoice -Title 'Choose a tenant type:' -Options $typeOptions -Prompt 'Tenant type number'
    }

    $path = "/partner/external/v3/general/customers/$CustomerId/3rd-party-products/type/$Type/tenants/batch"
    $items = Invoke-AvptPagedOperation -Method Post -Path $path -Body @{
        tenantIds = $TenantId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.TenantSeat' -EnumMap @{
            Type = $maps.TenantType
        }
    }
}
