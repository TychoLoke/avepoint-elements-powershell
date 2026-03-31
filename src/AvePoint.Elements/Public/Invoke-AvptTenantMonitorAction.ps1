function Invoke-AvptTenantMonitorAction {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,
        [Parameter(Mandatory)]
        [string] $TenantId,
        [Parameter(Mandatory)]
        [ValidateSet(1)]
        [int] $ActionType,
        [Parameter(Mandatory)]
        [object[]] $Data
    )

    $path = "/partner/external/v3/bm/customers/$CustomerId/tenants/$TenantId/actions"
    $body = @{
        actionType = $ActionType
        data       = $Data
    }

    if ($PSCmdlet.ShouldProcess($TenantId, 'Invoke AvePoint tenant monitor action')) {
        $response = Invoke-AvptWebRequest -Method Post -Path $path -Body $body -ScopeBundle 'Baseline'
        ConvertTo-AvptFriendlyObject -InputObject $response -TypeName 'AvePoint.Elements.TenantMonitorActionResult'
    }
}
