Add-Type -AssemblyName System.Drawing
$ref = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791345057893.png")

# Let's sample colors in Hiace, Avanza, Reborn
function GetAvgColor($bmp, $x1, $y1, $w, $h) {
    $r = 0; $g = 0; $b = 0; $cnt = 0
    for ($x = $x1; $x -lt ($x1 + $w); $x += 5) {
        for ($y = $y1; $y -lt ($y1 + $h); $y += 5) {
            $c = $bmp.GetPixel($x, $y)
            $r += $c.R; $g += $c.G; $b += $c.B; $cnt++
        }
    }
    return [System.Drawing.Color]::FromArgb([int]($r/$cnt), [int]($g/$cnt), [int]($b/$cnt))
}

$cHiace = GetAvgColor $ref 100 150 100 80
$cAvanza = GetAvgColor $ref 420 180 100 80
$cReborn = GetAvgColor $ref 750 150 100 80

Write-Output "Hiace color: R=$($cHiace.R), G=$($cHiace.G), B=$($cHiace.B)"
Write-Output "Avanza color: R=$($cAvanza.R), G=$($cAvanza.G), B=$($cAvanza.B)"
Write-Output "Reborn color: R=$($cReborn.R), G=$($cReborn.G), B=$($cReborn.B)"
$ref.Dispose()
