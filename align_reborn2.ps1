Add-Type -AssemblyName System.Drawing

$bg = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg")
$car = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-seva-black.png")

$w = $bg.Width
$h = $bg.Height

$finalBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($finalBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. Base Plaza
$g.DrawImage($bg, 0, 0, $w, $h)

# 2. Cover any remaining edges of the old car using texture cloning from surrounding plaza
# Left plaza paving: X: 150-320, Y: 500-750
# Right plaza paving: X: 800-1100, Y: 500-750
# Clone a small patch to cover old car's roof and rear
$g.DrawImage($bg, (New-Object System.Drawing.Rectangle 580, 420, 200, 160), 180, 520, 200, 160, [System.Drawing.GraphicsUnit]::Pixel)

# In reborn-seva-black.png (1280x960):
# The car itself is inside the image with margins:
# Actual car in reborn-seva-black.png:
# Left tire to right bumper: X: ~50 to ~1240 (Width ~1190)
# Top of roof to bottom tire: Y: ~140 to ~860 (Height ~720)

# To cover old car from X: ~310 to ~880, Y: ~420 to ~840:
# Old car width = ~570, height = ~420
# Let's position and scale:
$targetW = 1040
$targetH = [int]($car.Height * ($targetW / $car.Width))
$posX = 260
$posY = 360

# Draw dark contact shadow on paving stones
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), 460, 810, 220, 26) # Front tire
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 0, 0, 0))), 800, 700, 190, 22) # Rear tire

# Draw the 2024 Facelift Reborn
$g.DrawImage($car, $posX, $posY, $targetW, $targetH)

$g.Dispose()
$bg.Dispose()
$car.Dispose()

$outFile = "$PSScriptRoot/assets/toyota-innova-reborn.jpg"
$finalBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$finalBmp.Dispose()

Write-Host "Generated $outFile"
