function Get-AvptBaselineTenant {
    [CmdletBinding()]
    param(
        [string[]] $TenantId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $items = Invoke-AvptPagedOperation -Method Post -Path '/partner/external/v3/bm/tenants/batch' -Body @{
        tenantIds = $TenantId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Baseline'

    if ($Raw) { return $items }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        $tenant = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.BaselineTenant' -EnumMap @{
            Status        = $maps.BaselineTenantStatus
            AutoAlignment = $maps.AutoAlignment
        }
        $tenant | Add-Member -NotePropertyName AppliedBaselineCount -NotePropertyValue @($item.appliedBaselines).Count
        $tenant.appliedBaselines = @($item.appliedBaselines | ForEach-Object { ConvertTo-AvptNestedObject -InputObject $_ -TypeName 'AvePoint.Elements.AppliedBaseline' })
        $tenant
    }
}

