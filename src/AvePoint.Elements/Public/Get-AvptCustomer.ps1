function Get-AvptCustomer {
    <#
    .SYNOPSIS
    Retrieves customers managed by the current partner.
    #>
    [CmdletBinding()]
    param(
        [string[]] $CustomerId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $items = Invoke-AvptPagedOperation -Method Post -Path '/partner/external/v3/general/customers/batch' -Body @{
        customerIds = $CustomerId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.Customer' -EnumMap @{
            JobStatus      = $maps.JobStatus
            ManagementMode = $maps.ManagementMode
        }
    }
}

