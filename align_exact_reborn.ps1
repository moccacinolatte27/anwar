Add-Type -AssemblyName System.Drawing

$bg = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg")
$car = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-tight.png")

$w = $bg.Width
$h = $bg.Height

$finalBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($finalBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. Draw base Tugu Jogja plaza
$g.DrawImage($bg, 0, 0, $w, $h)

# 2. Position the Facelift Reborn to replace the old car with millimeter precision
$targetW = 730
$targetH = [int]($car.Height * ($targetW / $car.Width))
$posX = 350
$posY = 420

# Add soft ground shadow under tires
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), ($posX + 70), ($posY + $targetH - 25), 180, 24)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), ($posX + 350), ($posY + $targetH - 35), 260, 26)

# Draw the 2024 Facelift Reborn
$g.DrawImage($car, $posX, $posY, $targetW, $targetH)

$g.Dispose()
$bg.Dispose()
$car.Dispose()

$outFile = "$PSScriptRoot/assets/toyota-innova-reborn.jpg"
$finalBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$finalBmp.Dispose()

Write-Host "Generated $outFile"
