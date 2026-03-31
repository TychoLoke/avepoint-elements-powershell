function New-AvptCustomer {
    <#
    .SYNOPSIS
    Onboards a new customer to the current partner.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory)]
        [string] $FirstName,
        [Parameter(Mandatory)]
        [string] $LastName,
        [Parameter(Mandatory)]
        [string] $OrganizationName,
        [Parameter(Mandatory)]
        [Alias('OwnerEmail')]
        [string] $RegistrationAccount,
        [Parameter(Mandatory)]
        [string] $Password,
        [Parameter(Mandatory)]
        [ValidatePattern('^[A-Z]{2}$')]
        [string] $CountryCode,
        [string] $TelephoneNumber,
        [string] $DataCenterId,
        [string[]] $Tag,
        [bool] $ManagementMode = $true
    )

    $state = Get-AvptModuleState
    $environment = if ($state.Connection) { $state.Connection.Environment } else { 'Commercial' }
    $DataCenterId = Resolve-AvptDataCenterSelection -DataCenterId $DataCenterId -Environment $environment

    $body = @{
        firstName           = $FirstName
        lastName            = $LastName
        organizationName    = $OrganizationName
        registrationAccount = $RegistrationAccount
        password            = $Password
        countryCode         = $CountryCode.ToUpperInvariant()
        dataCenter          = $DataCenterId
        managementMode      = $ManagementMode
    }
    if ($PSBoundParameters.ContainsKey('TelephoneNumber')) { $body.telephoneNumber = $TelephoneNumber }
    if ($PSBoundParameters.ContainsKey('Tag')) { $body.tags = $Tag }

    if ($PSCmdlet.ShouldProcess($OrganizationName, 'Onboard AvePoint customer')) {
        $response = Invoke-AvptWebRequest -Method Post -Path '/partner/external/v3/general/customers' -Body $body -ScopeBundle 'Common'
        $maps = Get-AvptEnumMap
        $result = ConvertTo-AvptFriendlyObject -InputObject $response -TypeName 'AvePoint.Elements.NewCustomerResult' -EnumMap @{ status = $maps.CustomerOnboardingStatus }
        $result | Add-Member -NotePropertyName OrganizationName -NotePropertyValue $OrganizationName
        $result | Add-Member -NotePropertyName RegistrationAccount -NotePropertyValue $RegistrationAccount
        $result
    }
}
