BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '../src/AvePoint.Elements/AvePoint.Elements.psd1'
    Import-Module $modulePath -Force
}

Describe 'AvePoint.Elements module manifest' {
    It 'imports successfully' {
        Get-Module AvePoint.Elements | Should -Not -BeNullOrEmpty
    }

    It 'starts with no exported functions in scaffold state' {
        (Get-Command -Module AvePoint.Elements).Count | Should -Be 0
    }
}
