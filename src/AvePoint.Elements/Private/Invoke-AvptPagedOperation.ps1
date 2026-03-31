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

        [string] $ScopeBundle
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
        foreach ($item in @($response.data)) {
            $results.Add($item)
        }

        if (-not $All) {
            break
        }

        $metadata = $response.metadata
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
