[CmdletBinding()]
param(
    [string] $OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath '../app/ElementsShell.ico')
)

$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
$directory = Split-Path -Path $resolvedOutput -Parent
New-Item -Path $directory -ItemType Directory -Force | Out-Null

$width = 32
$height = 32
$bytesPerPixel = 4
$xorStride = $width * $bytesPerPixel
$andStride = [int] ([Math]::Ceiling($width / 32.0) * 4)
$xorSize = $xorStride * $height
$andSize = $andStride * $height

$iconHeader = [byte[]] (
    0,0,
    1,0,
    1,0,
    $width, $height, 0, 0,
    1,0,
    32,0,
    176,4,0,0,
    22,0,0,0
)

$bitmapHeader = [byte[]] (
    40,0,0,0,
    32,0,0,0,
    64,0,0,0,
    1,0,
    32,0,
    0,0,0,0,
    0,4,0,0,
    0,0,0,0,
    0,0,0,0,
    0,0,0,0,
    0,0,0,0
)

$xor = New-Object byte[] $xorSize
for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $offset = (($height - 1 - $y) * $xorStride) + ($x * 4)

        $isBorder = ($x -eq 0 -or $x -eq ($width - 1) -or $y -eq 0 -or $y -eq ($height - 1))
        $isLetterBar = (($x -ge 6 -and $x -le 10) -or ($y -ge 13 -and $y -le 17)) -and ($x -ge 6 -and $x -le 22) -and ($y -ge 7 -and $y -le 25)
        $isAccent = (($x -ge 18 -and $x -le 26) -and ($y -ge 7 -and $y -le 11)) -or (($x -ge 18 -and $x -le 26) -and ($y -ge 21 -and $y -le 25))

        if ($isBorder) {
            $red = 190; $green = 25; $blue = 25
        }
        elseif ($isLetterBar) {
            $red = 255; $green = 255; $blue = 255
        }
        elseif ($isAccent) {
            $red = 40; $green = 90; $blue = 220
        }
        else {
            $red = 12; $green = 28; $blue = 64
        }

        $xor[$offset] = [byte] $blue
        $xor[$offset + 1] = [byte] $green
        $xor[$offset + 2] = [byte] $red
        $xor[$offset + 3] = 255
    }
}

$andMask = New-Object byte[] $andSize

$stream = [System.IO.File]::Open($resolvedOutput, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
try {
    $stream.Write($iconHeader, 0, $iconHeader.Length)
    $stream.Write($bitmapHeader, 0, $bitmapHeader.Length)
    $stream.Write($xor, 0, $xor.Length)
    $stream.Write($andMask, 0, $andMask.Length)
}
finally {
    $stream.Dispose()
}

Write-Host ("Created icon at {0}" -f $resolvedOutput)
