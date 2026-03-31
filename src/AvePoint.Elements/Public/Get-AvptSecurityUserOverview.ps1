function Get-AvptSecurityUserOverview {
    <#
    .SYNOPSIS
    Retrieves security-focused user overview records for a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [int[]] $Status,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $query = @{}
    if ($PSBoundParameters.ContainsKey('Status')) {
        $query.status = ($Status -join ',')
    }

    $path = "/partner/external/v3/um/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/overview/security/users"
    $items = Invoke-AvptPagedOperation -Method Get -Path $path -Query $query -PageSize $PageSize -All:$All -ScopeBundle 'User'

    if ($Raw) { return $items }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        $user = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.SecurityUserOverview'
        $statusValues = @($item.status)
        $statusNames = @($statusValues | ForEach-Object {
            if ($maps.UserStatus.ContainsKey([int] $_)) { $maps.UserStatus[[int] $_] } else { 'Unknown' }
        })

        $user | Add-Member -NotePropertyName StatusCodes -NotePropertyValue $statusValues
        $user | Add-Member -NotePropertyName StatusNames -NotePropertyValue ($statusNames -join ', ')
        $user | Add-Member -NotePropertyName StatusCount -NotePropertyValue $statusValues.Count
        $user
    }
}
