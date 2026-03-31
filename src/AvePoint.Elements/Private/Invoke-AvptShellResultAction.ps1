function Invoke-AvptShellResultAction {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $InputObject,

        [string] $Title = 'Result',

        [switch] $AsList
    )

    while ($true) {
        Clear-Host
        Show-AvptBanner
        Show-AvptShellResult -InputObject $InputObject -Title $Title -AsList:$AsList
        Write-Host ''

        $action = Read-AvptChoice -Title 'Choose a result action:' -Options @(
            [pscustomobject]@{
                Label = 'Return to dashboard'
                Description = 'Go back to the main application screen.'
                Value = 'Return'
            }
            [pscustomobject]@{
                Label = 'Export as CSV'
                Description = 'Write the current result to a CSV file.'
                Value = 'Csv'
            }
            [pscustomobject]@{
                Label = 'Export as JSON'
                Description = 'Write the current result to a JSON file.'
                Value = 'Json'
            }
        ) -Prompt 'Result action'

        switch ($action) {
            'Return' { return }
            'Csv' { Export-AvptShellData -InputObject $InputObject -Format Csv }
            'Json' { Export-AvptShellData -InputObject $InputObject -Format Json }
        }

        Wait-AvptShellContinue -Message 'Press Enter to return to the result view'
    }
}
