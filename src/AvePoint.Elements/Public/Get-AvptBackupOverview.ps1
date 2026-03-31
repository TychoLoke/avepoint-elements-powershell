function Get-AvptBackupOverview {
    <#
    .SYNOPSIS
    Retrieves Cloud Backup for Microsoft 365 overview data for a customer.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,

        [ValidateRange(1, 100)]
        [int] $PageSize = 50,

        [switch] $All,
        [switch] $Raw
    )

    $CustomerId = (Resolve-AvptCustomerSelection -CustomerId $CustomerId).CustomerId
    $path = "/partner/external/v3/general/customers/$CustomerId/cloud-backup-m365/overview"
    $items = Invoke-AvptPagedOperation -Method Get -Path $path -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.BackupOverview'
    }
}
