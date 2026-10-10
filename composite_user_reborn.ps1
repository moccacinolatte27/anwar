Add-Type -AssemblyName System.Drawing

$carImg = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")
$bg = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/tugu-wp.jpg")

Write-Host "Car: $($carImg.Width)x$($carImg.Height), BG: $($bg.Width)x$($bg.Height)"

# 1. High precision polygon for user's car (1024x768)
$polyPoints = @(
    (New-Object System.Drawing.Point 230, 275),
    (New-Object System.Drawing.Point 280, 268),
    (New-Object System.Drawing.Point 380, 266),
    (New-Object System.Drawing.Point 500, 276),
    (New-Object System.Drawing.Point 610, 310),
    (New-Object System.Drawing.Point 665, 365),
    (New-Object System.Drawing.Point 710, 420),
    (New-Object System.Drawing.Point 745, 465),
    (New-Object System.Drawing.Point 762, 500),
    (New-Object System.Drawing.Point 778, 550),
    (New-Object System.Drawing.Point 778, 595),
    (New-Object System.Drawing.Point 762, 650),
    (New-Object System.Drawing.Point 740, 710),
    (New-Object System.Drawing.Point 705, 742),
    (New-Object System.Drawing.Point 640, 762),
    (New-Object System.Drawing.Point 540, 775),
    (New-Object System.Drawing.Point 440, 795),
    (New-Object System.Drawing.Point 340, 818),
    (New-Object System.Drawing.Point 295, 845),
    (New-Object System.Drawing.Point 270, 870), # Front tire base
    (New-Object System.Drawing.Point 235, 785),
    (New-Object System.Drawing.Point 235, 660),
    (New-Object System.Drawing.Point 205, 650), # Rear tire base
    (New-Object System.Drawing.Point 175, 640),
    (New-Object System.Drawing.Point 172, 560),
    (New-Object System.Drawing.Point 168, 490),
    (New-Object System.Drawing.Point 165, 410),
    (New-Object System.Drawing.Point 162, 385), # Mirror tip
    (New-Object System.Drawing.Point 185, 360),
    (New-Object System.Drawing.Point 225, 368),
    (New-Object System.Drawing.Point 205, 315)
)

# Create 32bpp cutout of the car
$cutout = New-Object System.Drawing.Bitmap($carImg.Width, $carImg.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gCut = [System.Drawing.Graphics]::FromImage($cutout)
$gCut.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddPolygon($polyPoints)
$gCut.SetClip($path)
$gCut.DrawImage($carImg, 0, 0)
$gCut.Dispose()
$path.Dispose()

# 2. Output composite (1600 x 900 for crystal-clear catalog card)
$outW = 1600
$outH = 900
$finalBmp = New-Object System.Drawing.Bitmap($outW, $outH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gOut = [System.Drawing.Graphics]::FromImage($finalBmp)
$gOut.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$gOut.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Draw background cropped nicely showing Tugu Jogja
# Crop from bg: X: 350, Y: 150, W: 2000, H: 1125
$gOut.DrawImage($bg, (New-Object System.Drawing.Rectangle 0, 0, $outW, $outH), 380, 150, 1900, 1070, [System.Drawing.GraphicsUnit]::Pixel)

# Draw the user's Reborn car in the foreground plaza
# Desired car width = 1100, height = proportional
$carW = 1080
$carH = [int]($cutout.Height * ($carW / $cutout.Width))
$carX = [int](($outW - $carW) / 2) + 20
$carY = $outH - $carH - 10

# Natural multi-layer contact shadow on the stone tiles
$gOut.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(70, 0, 0, 0))), ($carX + 100), ($outH - 75), ($carW - 200), 45)
$gOut.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(140, 0, 0, 0))), ($carX + 160), ($outH - 55), ($carW - 320), 28)

# Draw the cutout car
$gOut.DrawImage($cutout, $carX, $carY, $carW, $carH)

$gOut.Dispose()
$cutout.Dispose()
$carImg.Dispose()
$bg.Dispose()

$outFile = "$PSScriptRoot/assets/toyota-innova-reborn-user.jpg"
$finalBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$finalBmp.Dispose()

Write-Host "Created $outFile successfully!"
