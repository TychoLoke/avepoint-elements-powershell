function Get-AvptUser {
    <#
    .SYNOPSIS
    Retrieves a specific user in a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [string] $UserId,
        [switch] $Raw
    )

    $context = Resolve-AvptUserSelection -CustomerId $CustomerId -TenantId $TenantId -UserId $UserId
    $path = "/partner/external/v3/um/customers/$($context.CustomerId)/tenants/$($context.TenantId)/users/$($context.UserId)"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'User'

    if ($Raw) { return $item }

    $maps = Get-AvptEnumMap
    $user = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.User'
    $statusValues = @($item.status)
    $statusNames = @($statusValues | ForEach-Object {
        if ($maps.UserStatus.ContainsKey([int] $_)) { $maps.UserStatus[[int] $_] } else { 'Unknown' }
    })

    $user | Add-Member -NotePropertyName StatusCodes -NotePropertyValue $statusValues
    $user | Add-Member -NotePropertyName StatusNames -NotePropertyValue ($statusNames -join ', ')
    $user | Add-Member -NotePropertyName AlternateEmailCount -NotePropertyValue @($item.alternateEmailAddress).Count
    $user | Add-Member -NotePropertyName AlternateEmailAddressList -NotePropertyValue (@($item.alternateEmailAddress) -join ', ')
    $user
}
