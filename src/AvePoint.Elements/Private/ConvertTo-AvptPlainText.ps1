function ConvertTo-AvptPlainText {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [Security.SecureString] $SecureString
    )

    $credential = [pscredential]::new('ignored', $SecureString)
    $credential.GetNetworkCredential().Password
}

