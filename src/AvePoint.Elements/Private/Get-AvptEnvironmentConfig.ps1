function Get-AvptEnvironmentConfig {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Commercial', 'Government', 'Aos2', 'FedRAMP')]
        [string] $Environment
    )

    $map = @{
        Commercial = @{
            Name     = 'Commercial'
            BaseUri  = 'https://graph.avepointonlineservices.com'
            TokenUri = 'https://identity.avepointonlineservices.com/connect/token'
        }
        Government = @{
            Name     = 'Government'
            BaseUri  = 'https://graph-gov.avepointonlineservices.com'
            TokenUri = 'https://identity-gov.avepointonlineservices.com/connect/token'
        }
        Aos2 = @{
            Name     = 'Aos2'
            BaseUri  = 'https://graph-aos2.avepointonlineservices.com'
            TokenUri = 'https://identity-aos2.avepointonlineservices.com/connect/token'
        }
        FedRAMP = @{
            Name     = 'FedRAMP'
            BaseUri  = 'https://graphusgovapi.online15.net'
            TokenUri = 'https://identity.online15.net/connect/token'
        }
    }

    [pscustomobject] $map[$Environment]
}

