function Get-AvptCertificate {
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Path')]
        [string] $CertificatePath,

        [Parameter(ParameterSetName = 'Path')]
        [Security.SecureString] $CertificatePassword,

        [Parameter(Mandatory, ParameterSetName = 'Thumbprint')]
        [string] $Thumbprint
    )

    if ($PSCmdlet.ParameterSetName -eq 'Path') {
        if (-not (Test-Path -LiteralPath $CertificatePath)) {
            throw "Certificate path not found: $CertificatePath"
        }

        if ($CertificatePassword) {
            return [System.Security.Cryptography.X509Certificates.X509Certificate2]::new(
                $CertificatePath,
                (ConvertTo-AvptPlainText -SecureString $CertificatePassword),
                [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable
            )
        }

        return [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($CertificatePath)
    }

    $storeLocations = @(
        [System.Security.Cryptography.X509Certificates.StoreLocation]::CurrentUser,
        [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine
    )

    foreach ($location in $storeLocations) {
        $store = [System.Security.Cryptography.X509Certificates.X509Store]::new(
            [System.Security.Cryptography.X509Certificates.StoreName]::My,
            $location
        )

        try {
            $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly)
            $matches = $store.Certificates.Find(
                [System.Security.Cryptography.X509Certificates.X509FindType]::FindByThumbprint,
                $Thumbprint,
                $false
            )

            if ($matches.Count -gt 0) {
                return $matches[0]
            }
        }
        finally {
            $store.Close()
        }
    }

    throw "Certificate with thumbprint '$Thumbprint' was not found in CurrentUser or LocalMachine certificate stores."
}

