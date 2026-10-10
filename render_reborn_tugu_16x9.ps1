Add-Type -AssemblyName System.Drawing

$bg = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/tugu-wp.jpg")
$car = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-tight.png")

# Background is 5597 x 3326
# Let's place the car on the ground paving
$carW = 3400
$carH = [int]($car.Height * ($carW / $car.Width))
$carX = [int](($bg.Width - $carW) / 2) - 100
$carY = $bg.Height - $carH - 120

$g = [System.Drawing.Graphics]::FromImage($bg)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Contact shadow on stone pavement
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), ($carX + 250), ($bg.Height - 240), ($carW - 500), 140)

# Draw car
$g.DrawImage($car, $carX, $carY, $carW, $carH)
$g.Dispose()

# Now crop a crisp 16:9 frame (1920 x 1080)
# We want the crop to capture Tugu Jogja monument (top) down to the car tires (bottom)
# Crop width = 4400, height = 2475 (16:9)
$cropX = [int](($bg.Width - 4400) / 2)
$cropY = 700
$cropW = 4400
$cropH = 2475

$outBmp = New-Object System.Drawing.Bitmap(1600, 900, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gOut = [System.Drawing.Graphics]::FromImage($outBmp)
$gOut.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$gOut.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$gOut.DrawImage($bg, (New-Object System.Drawing.Rectangle 0, 0, 1600, 900), $cropX, $cropY, $cropW, $cropH, [System.Drawing.GraphicsUnit]::Pixel)
$gOut.Dispose()

$outFile = "$PSScriptRoot/assets/toyota-innova-reborn.jpg"
$outBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$outBmp.Dispose()
$bg.Dispose()
$car.Dispose()

Write-Host "Created 16:9 $outFile"
