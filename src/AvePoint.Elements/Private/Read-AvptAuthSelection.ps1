function Read-AvptAuthSelection {
    [CmdletBinding()]
    param()

    $options = @(
        [pscustomobject]@{
            Label       = 'Client secret'
            Value       = 'ClientSecret'
            Description = 'Client ID plus client secret from the Elements app registration.'
        }
        [pscustomobject]@{
            Label       = 'Certificate file'
            Value       = 'CertificatePath'
            Description = 'Client ID plus a local PFX certificate file.'
        }
        [pscustomobject]@{
            Label       = 'Certificate thumbprint'
            Value       = 'CertificateThumbprint'
            Description = 'Client ID plus a certificate already installed in the certificate store.'
        }
    )

    Read-AvptChoice -Title 'Choose the authentication method:' -Options $options -Prompt 'Authentication number'
}

