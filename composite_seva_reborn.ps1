Add-Type -AssemblyName System.Drawing

$carPng = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-seva-black.png")
$bg = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/tugu-wp.jpg")

# Desired output: 1600 x 900 (16:9 widescreen matching fleet catalog card ratio)
$outW = 1600
$outH = 900
$finalBmp = New-Object System.Drawing.Bitmap($outW, $outH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($finalBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. Base Layer: Tugu Jogja monument centered in the background
# Crop area from bg (5597 x 3326):
# Monument base is around X=2400-3100, Y=300-2800
$cropX = 900
$cropY = 320
$cropW = 3800
$cropH = 2138
$g.DrawImage($bg, (New-Object System.Drawing.Rectangle 0, 0, $outW, $outH), $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel)

# 2. Ground Contact Shadow for the car on the paving tiles
$carW = 1180
$carH = [int]($carPng.Height * ($carW / $carPng.Width))
$carX = [int](($outW - $carW) / 2) + 15
$carY = $outH - $carH - 25

# Multi-layer natural ground shadow
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40, 0, 0, 0))), ($carX + 40), ($outH - 70), ($carW - 80), 42)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(90, 0, 0, 0))), ($carX + 110), ($outH - 52), ($carW - 220), 28)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 0, 0, 0))), ($carX + 180), ($outH - 40), ($carW - 360), 16)

# 3. Draw the Black Facelift Reborn Studio Car
$g.DrawImage($carPng, $carX, $carY, $carW, $carH)

# 4. Subtle atmospheric lighting blend on top of car
# Soft warm sunlight highlight from upper-right matching the sky
$sunBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(15, 255, 245, 220))
$g.FillRectangle($sunBrush, 0, 0, $outW, $outH)
$sunBrush.Dispose()

$g.Dispose()
$carPng.Dispose()
$bg.Dispose()

$outFile = "$PSScriptRoot/assets/toyota-innova-reborn.jpg"
$finalBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$finalBmp.Dispose()

Write-Host "Created $outFile"
