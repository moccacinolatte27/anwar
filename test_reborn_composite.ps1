Add-Type -AssemblyName System.Drawing

$carImg = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")
$tuguBase = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/toyota-innova-reborn.jpg")

Write-Host "CarImg: $($carImg.Width) x $($carImg.Height)"
Write-Host "TuguBase: $($tuguBase.Width) x $($tuguBase.Height)"

# We want a 1376 x 768 output matching the aspect ratio of the fleet cards (or 16:9)
$destW = 1376
$destH = 768
$outBmp = New-Object System.Drawing.Bitmap($destW, $destH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($outBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# 1. Base Layer: The Tugu Jogja plaza background from tuguBase
# Draw the background environment (sky, monument, buildings, paving floor)
$g.DrawImage($tuguBase, 0, 0, $destW, $destH)

# 2. Now let's carefully place the user's Reborn car from carImg
# The car in carImg (1024x768) is centered around X ~480, Y ~480
# Scale factor so the car size matches tuguBase perfectly
# Let's scale carImg to width = 1150, height = 862
$cW = 1150
$cH = [int]($carImg.Height * ($cW / $carImg.Width))
$cX = 100
$cY = $destH - $cH + 20

# We extract the car from carImg using an edge-aware mask:
# - Below Y = 320 in carImg is the car body
# - Ground paving blends seamlessly at the wheels
# Let's write pixel-level extraction
$scaledCar = New-Object System.Drawing.Bitmap($cW, $cH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gScale = [System.Drawing.Graphics]::FromImage($scaledCar)
$gScale.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$gScale.DrawImage($carImg, 0, 0, $cW, $cH)
$gScale.Dispose()

# Now draw the scaled car onto outBmp with smooth transition for the background
# Let's test the positioning
$scaledCar.Save("$PSScriptRoot/assets/test_scaled_reborn.png", [System.Drawing.Imaging.ImageFormat]::Png)

$scaledCar.Dispose()
$outBmp.Dispose()
$g.Dispose()
$carImg.Dispose()
$tuguBase.Dispose()

Write-Host "Prepared scaling test."
