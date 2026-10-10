Add-Type -AssemblyName System.Drawing

$srcPath = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\reborn-seva-black.png"
$bmp = [System.Drawing.Bitmap]::FromFile($srcPath)

$minX = $bmp.Width; $maxX = 0
$minY = $bmp.Height; $maxY = 0

for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.A -gt 20) {
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

Write-Output "Car bounds: X=$minX..$maxX, Y=$minY..$maxY, W=$($maxX - $minX + 1), H=$($maxY - $minY + 1)"

$w = $maxX - $minX + 1
$h = $maxY - $minY + 1
$cropped = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($cropped)
$g.DrawImage($bmp, 0, 0, (New-Object System.Drawing.Rectangle($minX, $minY, $w, $h)), [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$bmp.Dispose()

$dstPath = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-car-reborn-black.png"
$cropped.Save($dstPath, [System.Drawing.Imaging.ImageFormat]::Png)
$cropped.Dispose()

Write-Output "Saved tightly cropped black reborn to $dstPath"
