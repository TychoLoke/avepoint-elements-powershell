function Get-AvptScopeBundle {
    <#
    .SYNOPSIS
    Lists the built-in AvePoint Elements scope bundles.

    .DESCRIPTION
    Returns the named scope bundles used to split Elements tokens across
    Common, Baseline, User, Risk, and Workspace endpoint families.

    .EXAMPLE
    Get-AvptScopeBundle
    #>
    [CmdletBinding()]
    param()

    Get-AvptScopeBundleCatalog | Sort-Object Name
}

