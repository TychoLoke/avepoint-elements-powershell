function Get-AvptModuleState {
    [CmdletBinding()]
    param()

    if (-not $script:AvptState) {
        $script:AvptState = @{
            Connection = $null
            Token      = $null
            TokenCache = @{}
        }
    }

    $script:AvptState
}
