function Resolve-AvptUri {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path,

        [hashtable] $Query
    )

    $state = Get-AvptModuleState
    if (-not $state.Connection) {
        throw 'No AvePoint Elements connection is active. Run Connect-AvptElements first.'
    }

    if ($Path -match '^https?://') {
        return $Path
    }

    $baseUri = $state.Connection.BaseUri.TrimEnd('/')
    $pathValue = $Path.TrimStart('/')
    $builder = [System.UriBuilder]::new("$baseUri/$pathValue")

    if ($Query) {
        $parts = foreach ($key in $Query.Keys) {
            $value = $Query[$key]
            if ($null -eq $value) {
                continue
            }

            $encodedKey = [System.Uri]::EscapeDataString([string] $key)
            $encodedValue = [System.Uri]::EscapeDataString([string] $value)
            '{0}={1}' -f $encodedKey, $encodedValue
        }

        $builder.Query = ($parts -join '&')
    }

    $builder.Uri.AbsoluteUri
}

