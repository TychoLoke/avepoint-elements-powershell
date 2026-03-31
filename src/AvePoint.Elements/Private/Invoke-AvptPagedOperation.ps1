function Invoke-AvptPagedOperation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Get', 'Post')]
        [string] $Method,

        [Parameter(Mandatory)]
        [string] $Path,

        [hashtable] $Query,

        [object] $Body,

        [ValidateRange(1, 100)]
        [int] $PageSize = 50,

        [switch] $All,

        [string] $ScopeBundle,

        [string] $DataProperty = 'data',

        [string] $MetadataProperty = 'metadata'
    )

    $results = [System.Collections.Generic.List[object]]::new()
    $pageIndex = 1

    while ($true) {
        $queryWithPaging = @{}
        if ($Query) {
            foreach ($key in $Query.Keys) {
                $queryWithPaging[$key] = $Query[$key]
            }
        }

        $queryWithPaging.pageIndex = $pageIndex
        $queryWithPaging.pageSize = $PageSize

        $response = Invoke-AvptWebRequest -Method $Method -Path $Path -Query $queryWithPaging -Body $Body -ScopeBundle $ScopeBundle
        $pageItems = $response.$DataProperty
        foreach ($item in @($pageItems)) {
            $results.Add($item)
        }

        if (-not $All) {
            break
        }

        $metadata = $response.$MetadataProperty
        if (-not $metadata) {
            break
        }

        if ($results.Count -ge [int] $metadata.totalCount) {
            break
        }

        $pageIndex++
    }

    $results.ToArray()
}
