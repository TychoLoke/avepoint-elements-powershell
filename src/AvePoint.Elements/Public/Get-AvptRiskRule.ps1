function Get-AvptRiskRule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,
        [Parameter(Mandatory)]
        [string] $TenantId,
        [int[]] $DataSource,
        [ValidateSet(0,1)]
        [int] $Status,
        [switch] $Raw
    )

    $query = @{}
    if ($PSBoundParameters.ContainsKey('DataSource')) { $query.dataSources = ($DataSource -join ',') }
    if ($PSBoundParameters.ContainsKey('Status')) { $query.status = $Status }

    $path = "/partner/external/v3/rm/customers/$CustomerId/tenants/$TenantId/detection/rules"
    $response = Invoke-AvptWebRequest -Method Get -Path $path -Query $query -ScopeBundle 'Risk'
    $items = @($response.result)

    if ($Raw) { return $items }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.RiskRule' -EnumMap @{
            DataSource = $maps.RiskDataSource
        }
    }
}

