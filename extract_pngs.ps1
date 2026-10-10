Add-Type -AssemblyName System.Drawing

$src = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791345057893.png"
$assets = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets"

$bytes = [System.IO.File]::ReadAllBytes($src)
$ms = New-Object System.IO.MemoryStream(,$bytes)
$bmp = [System.Drawing.Bitmap]::FromStream($ms)

# Helper function to crop and remove orange background
function Extract-CarPng($cropRect, $outputPath, $orangeThreshold) {
    $crop = New-Object System.Drawing.Bitmap($cropRect.Width, $cropRect.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($crop)
    $g.DrawImage($bmp, 0, 0, $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()

    # Remove the orange background (high R, high G, low B)
    for ($x = 0; $x -lt $crop.Width; $x++) {
        for ($y = 0; $y -lt $crop.Height; $y++) {
            $c = $crop.GetPixel($x, $y)
            # Orange background detection
            if ($c.R -gt 155 -and ($c.R - $c.B) -gt $orangeThreshold -and $c.G -gt 85) {
                $crop.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            }
        }
    }

    $crop.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $crop.Dispose()
}

# 1. Hiace Crop (Left)
$hiaceRect = New-Object System.Drawing.Rectangle(10, 50, 420, 300)
Extract-CarPng $hiaceRect "$assets\hero-car-hiace.png" 40

# 2. Avanza FWD Crop (Center)
$avanzaRect = New-Object System.Drawing.Rectangle(300, 110, 420, 245)
Extract-CarPng $avanzaRect "$assets\hero-car-avanza.png" 45

# 3. Innova Reborn Crop (Right)
$rebornRect = New-Object System.Drawing.Rectangle(530, 55, 380, 295)
Extract-CarPng $rebornRect "$assets\hero-car-reborn.png" 40

$bmp.Dispose()
$ms.Dispose()

Write-Output "Successfully extracted Hiace, Avanza, and Reborn PNGs!"
