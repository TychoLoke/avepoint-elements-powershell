function Get-AvptBackupJob {
    <#
    .SYNOPSIS
    Retrieves backup job details for a customer.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,

        [int] $JobType,
        [int] $JobModule,

        [ValidateRange(1, 100)]
        [int] $PageSize = 50,

        [switch] $All,
        [switch] $Raw
    )

    $CustomerId = (Resolve-AvptCustomerSelection -CustomerId $CustomerId).CustomerId
    $path = "/partner/external/v3/general/customers/$CustomerId/avpt-products/jobs/batch"
    $body = @{}
    if ($PSBoundParameters.ContainsKey('JobType')) { $body.jobType = $JobType }
    if ($PSBoundParameters.ContainsKey('JobModule')) { $body.jobModule = $JobModule }

    $items = Invoke-AvptPagedOperation -Method Post -Path $path -Body $body -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.BackupJob' -EnumMap @{
            JobType = $maps.JobType
            Status  = $maps.Status
        }
    }
}
