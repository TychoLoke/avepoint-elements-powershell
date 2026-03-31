function New-AvptBaseline {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory)]
        [string] $Name,
        [Parameter(Mandatory)]
        [ValidateRange(0, 21)]
        [int] $Color,
        [Parameter(Mandatory)]
        [string] $CustomerId,
        [Parameter(Mandatory)]
        [string] $TenantId,
        [string] $Description
    )

    $body = @{
        name       = $Name
        color      = $Color
        customerId = $CustomerId
        tenantId   = $TenantId
    }
    if ($PSBoundParameters.ContainsKey('Description')) { $body.description = $Description }

    if ($PSCmdlet.ShouldProcess($Name, 'Create AvePoint baseline')) {
        $response = Invoke-AvptWebRequest -Method Post -Path '/partner/external/v3/bm/baselines' -Body $body -ScopeBundle 'Baseline'
        ConvertTo-AvptFriendlyObject -InputObject $response -TypeName 'AvePoint.Elements.NewBaselineResult'
    }
}

