function Resolve-AvptScopeBundle {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]] $Name
    )

    $catalog = Get-AvptScopeBundleCatalog
    $resolved = foreach ($bundleName in $Name) {
        $match = $catalog | Where-Object Name -eq $bundleName
        if (-not $match) {
            throw "Unknown AvePoint scope bundle '$bundleName'."
        }

        $match
    }

    @($resolved)
}

