function Get-AvptUsers {
    <#
    .SYNOPSIS
    Retrieves one or more users in a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [string[]] $UserId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $path = "/partner/external/v3/um/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/users/batch"
    $body = @{
        userIds = $UserId
    }

    $items = Invoke-AvptPagedOperation -Method Post -Path $path -Body $body -PageSize $PageSize -All:$All -ScopeBundle 'User'

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
