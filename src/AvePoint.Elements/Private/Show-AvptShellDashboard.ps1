function Show-AvptShellDashboard {
    [CmdletBinding()]
    param()

    $state = Get-AvptModuleState
    $connected = Test-AvptElementsConnection -Quiet

    $sessionLines = if ($connected -and $state.Connection) {
        @(
            'Status      : Connected'
            ('Environment : {0}' -f $state.Connection.Environment)
            ('Auth Type   : {0}' -f $state.Connection.AuthType)
            ('Label       : {0}' -f $(if ($state.Connection.TenantName) { $state.Connection.TenantName } else { 'Not set' }))
            ('Bundles     : {0}' -f $(if ($state.Connection.ScopeBundle) { ($state.Connection.ScopeBundle -join ', ') } else { 'Direct scope mode' }))
        )
    }
    else {
        @(
            'Status      : Not connected'
            'Environment : N/A'
            'Auth Type   : N/A'
            'Label       : N/A'
            'Bundles     : N/A'
        )
    }

    $workflowLines = @(
        '1. Connect once'
        '2. Pick an operational view'
        '3. Select customer or tenant from live data'
        '4. Work with shaped output instead of raw API payloads'
    )

    Show-AvptShellPanel -Title 'Session' -Lines $sessionLines -AccentColor $(if ($connected) { 'Green' } else { 'DarkRed' })
    Show-AvptShellPanel -Title 'Workflow' -Lines $workflowLines -AccentColor 'Blue'
}
