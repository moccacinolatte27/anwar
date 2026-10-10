Add-Type -AssemblyName System.Drawing

$bg = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg")
$car = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-seva-black.png")

$w = $bg.Width
$h = $bg.Height
Write-Host "BG size: $w x $h"
Write-Host "Car size: $($car.Width) x $($car.Height)"

$finalBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($finalBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. Draw base Tugu Jogja plaza
$g.DrawImage($bg, 0, 0, $w, $h)

# 2. Position the Facelift Reborn over the old car
# The old car is positioned roughly from X ~360 to X ~1050, Y ~450 to Y ~880
# Width = ~820, Height = ~580
$targetW = 860
$targetH = [int]($car.Height * ($targetW / $car.Width))
$posX = 355
$posY = 360

# Add soft contact shadow under tires
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), ($posX + 90), ($posY + $targetH - 35), 230, 28)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), ($posX + 440), ($posY + $targetH - 70), 220, 24)

# Draw the 2021-2024 Facelift Reborn
$g.DrawImage($car, $posX, $posY, $targetW, $targetH)

$g.Dispose()
$bg.Dispose()
$car.Dispose()

$outFile = "$PSScriptRoot/assets/toyota-innova-reborn.jpg"
$finalBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$finalBmp.Dispose()

Write-Host "Updated $outFile"
