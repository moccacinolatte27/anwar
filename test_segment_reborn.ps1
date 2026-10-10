Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")
$w = $src.Width
$h = $src.Height

Write-Host "Reborn Source: $w x $h"

# Let's inspect brightness across columns at Y = 280 (roof area), Y = 400 (hood area), Y = 600 (bumper)
for ($y = 200; $y -lt 700; $y += 50) {
    $minX = -1; $maxX = -1
    for ($x = 100; $x -lt 900; $x += 5) {
        $pixel = $src.GetPixel($x, $y)
        # Check if pixel is part of black car body (dark, R,G,B < 90)
        # Trees have high green (G > R and G > B + 15)
        # Sky has high brightness (R > 140, G > 140, B > 140)
        $isSky = ($pixel.R -gt 130 -and $pixel.G -gt 140 -and $pixel.B -gt 140)
        $isGreen = ($pixel.G -gt ($pixel.R + 10) -and $pixel.G -gt ($pixel.B + 10) -and $pixel.G -gt 60)
        $isCar = (-not $isSky) -and (-not $isGreen)
        if ($isCar) {
            if ($minX -eq -1) { $minX = $x }
            $maxX = $x
        }
    }
    Write-Host "Y=$y : car roughly between X=$minX and X=$maxX"
}
$src.Dispose()
