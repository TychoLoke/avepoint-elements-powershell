function Invoke-AvptPagedRequest {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Get', 'Post')]
        [string] $Method,

        [Parameter(Mandatory)]
        [string] $Path,

        [hashtable] $Query,

        [object] $Body,

        [switch] $All,

        [scriptblock] $RequestScript
    )

    $results = [System.Collections.Generic.List[object]]::new()
    $nextPath = $Path
    $nextQuery = $Query
    $nextBody = $Body
    $firstRequest = $true

    do {
        $request = @{
            Method = $Method
            Path   = $nextPath
            Query  = $nextQuery
            Body   = $nextBody
        }

        $response = if ($RequestScript) {
            & $RequestScript $request
        }
        else {
            Invoke-AvptWebRequest @request
        }

        if ($null -ne $response.value) {
            foreach ($item in @($response.value)) {
                $results.Add($item)
            }
        }
        elseif ($null -ne $response.values) {
            foreach ($item in @($response.values)) {
                $results.Add($item)
            }
        }
        elseif ($response -is [System.Collections.IEnumerable] -and $response -isnot [string]) {
            foreach ($item in $response) {
                $results.Add($item)
            }
        }
        elseif ($null -ne $response) {
            $results.Add($response)
        }

        if (-not $All) {
            break
        }

        $nextLink = $null
        if ($null -ne $response.'@odata.nextLink') {
            $nextLink = $response.'@odata.nextLink'
        }
        elseif ($null -ne $response.nextLink) {
            $nextLink = $response.nextLink
        }

        $nextPath = $nextLink
        $nextQuery = $null
        $nextBody = if ($firstRequest) { $Body } else { $null }
        $firstRequest = $false
    } while ($nextPath)

    $results.ToArray()
}
