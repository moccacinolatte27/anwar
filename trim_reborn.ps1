Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-seva-black.png")

# Find non-transparent bounds
$minX = $src.Width; $minY = $src.Height; $maxX = 0; $maxY = 0

for ($y = 0; $y -lt $src.Height; $y++) {
    for ($x = 0; $x -lt $src.Width; $x++) {
        if ($src.GetPixel($x, $y).A -gt 15) {
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

$tightW = $maxX - $minX + 1
$tightH = $maxY - $minY + 1
Write-Host "Car bounds in image: X=$minX..$maxX ($tightW), Y=$minY..$maxY ($tightH)"

$tightBmp = New-Object System.Drawing.Bitmap($tightW, $tightH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($tightBmp)
$g.DrawImage($src, 0, 0, (New-Object System.Drawing.Rectangle $minX, $minY, $tightW, $tightH), [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$tightBmp.Save("$PSScriptRoot/assets/reborn-tight.png", [System.Drawing.Imaging.ImageFormat]::Png)
$tightBmp.Dispose()
$src.Dispose()

Write-Host "Saved tight car to assets/reborn-tight.png"
