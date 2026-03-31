function Get-AvptPermissionScope {
    <#
    .SYNOPSIS
    Lists the built-in AvePoint Elements permission scopes.

    .DESCRIPTION
    Returns the public permission catalog used by the module for examples and
    interactive scope selection.

    .PARAMETER Category
    Filters permissions by category.

    .PARAMETER AccessLevel
    Filters permissions by access level.

    .EXAMPLE
    Get-AvptPermissionScope

    .EXAMPLE
    Get-AvptPermissionScope -AccessLevel Read
    #>
    [CmdletBinding()]
    param(
        [ValidateSet('Common', 'BaselineManagement', 'RiskManagement', 'UserManagement', 'WorkspaceManagement')]
        [string[]] $Category,

        [ValidateSet('Read', 'ReadWrite')]
        [string[]] $AccessLevel
    )

    $catalog = Get-AvptPermissionCatalog

    if ($Category) {
        $catalog = $catalog | Where-Object Category -in $Category
    }

    if ($AccessLevel) {
        $catalog = $catalog | Where-Object AccessLevel -in $AccessLevel
    }

    $catalog | Sort-Object Category, Scope
}

