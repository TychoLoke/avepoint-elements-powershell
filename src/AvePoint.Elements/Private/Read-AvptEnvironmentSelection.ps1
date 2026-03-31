function Read-AvptEnvironmentSelection {
    [CmdletBinding()]
    param()

    $options = @(
        [pscustomobject]@{
            Label       = 'Commercial'
            Value       = 'Commercial'
            Description = 'Default commercial cloud environment.'
        }
        [pscustomobject]@{
            Label       = 'Government'
            Value       = 'Government'
            Description = 'U.S. Government environment.'
        }
        [pscustomobject]@{
            Label       = 'Aos2'
            Value       = 'Aos2'
            Description = 'AOS2 environment.'
        }
        [pscustomobject]@{
            Label       = 'FedRAMP'
            Value       = 'FedRAMP'
            Description = 'FedRAMP cloud environment.'
        }
    )

    Read-AvptChoice -Title 'Choose the AvePoint Elements environment:' -Options $options -Prompt 'Environment number'
}

