function Invoke-AvptWebRequest {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Get', 'Post', 'Put', 'Patch', 'Delete')]
        [string] $Method,

        [Parameter(Mandatory)]
        [string] $Path,

        [hashtable] $Query,

        [object] $Body,

        [hashtable] $Headers,

        [int] $MaxRetryCount = 3,

        [string] $ScopeBundle,

        [switch] $Raw,

        [switch] $AsJson
    )

    $uri = Resolve-AvptUri -Path $Path -Query $Query
    $attempt = 0
    $lastError = $null

    while ($attempt -le $MaxRetryCount) {
        $attempt++
        $token = Get-AvptAccessToken -BundleName $ScopeBundle -ForceRefresh:($attempt -gt 1 -and $lastError -and $lastError.StatusCode -eq 401)

        $requestHeaders = @{
            Authorization = "Bearer $token"
            Accept        = 'application/json'
        }

        if ($Headers) {
            foreach ($key in $Headers.Keys) {
                $requestHeaders[$key] = $Headers[$key]
            }
        }

        $requestSplat = @{
            Uri                = $uri
            Method             = $Method
            Headers            = $requestHeaders
            SkipHttpErrorCheck = $true
        }

        if ($PSBoundParameters.ContainsKey('Body')) {
            if ($Body -is [string]) {
                $requestSplat.Body = $Body
                $requestSplat.ContentType = 'application/json'
            }
            else {
                $requestSplat.Body = ($Body | ConvertTo-Json -Depth 10)
                $requestSplat.ContentType = 'application/json'
            }
        }

        try {
            Write-Debug "$Method $uri"
            $response = Invoke-WebRequest @requestSplat
        }
        catch {
            $lastError = [pscustomobject]@{
                StatusCode = $null
                Message    = $_.Exception.Message
            }

            if ($attempt -gt $MaxRetryCount) {
                throw
            }

            Start-Sleep -Seconds ([math]::Min([math]::Pow(2, $attempt), 8))
            continue
        }

        $content = $response.Content
        $parsed = $null

        if ($content) {
            try {
                $parsed = $content | ConvertFrom-Json -Depth 20
            }
            catch {
                $parsed = $content
            }
        }

        if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 300) {
            if ($Raw) {
                return $response
            }

            if ($AsJson) {
                return $content
            }

            return $parsed
        }

        $lastError = [pscustomobject]@{
            StatusCode = [int] $response.StatusCode
            Message    = if ($parsed.message) { $parsed.message } elseif ($content) { $content } else { $response.StatusDescription }
        }

        $retryAfter = $response.Headers['Retry-After']
        $isTransient = $response.StatusCode -in 408, 429, 500, 502, 503, 504
        $shouldRetry = $attempt -le $MaxRetryCount -and ($isTransient -or $response.StatusCode -eq 401)

        if ($shouldRetry) {
            $delaySeconds = if ($retryAfter) { [int] $retryAfter[0] } else { [math]::Min([math]::Pow(2, $attempt), 8) }
            Start-Sleep -Seconds $delaySeconds
            continue
        }

        $permissionHint = if ($response.StatusCode -eq 403) {
            ' Verify that the app registration includes the required Elements API permission for this endpoint.'
        }
        else {
            ''
        }

        throw "AvePoint Elements API request failed with status $($response.StatusCode) for '$uri'. $($lastError.Message)$permissionHint"
    }

    throw "AvePoint Elements API request failed for '$uri'. $($lastError.Message)"
}
