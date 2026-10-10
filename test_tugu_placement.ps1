Add-Type -AssemblyName System.Drawing

$tuguPlaza = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/toyota-innova-reborn.jpg")
$hiacePng = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-hiace.png")

$w = $tuguPlaza.Width
$h = $tuguPlaza.Height
$testBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($testBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# 1. Base Tugu Plaza (clear sky, Tugu Jogja in center)
$g.DrawImage($tuguPlaza, 0, 0, $w, $h)

# 2. Cover the old Reborn with the clean plaza paving / clone texture from left & right
# Or use the clean Tugu monument background
# Let's test placing Hiace right in the center foreground
$targetW = [int]($w * 0.72)
$targetH = [int]($hiacePng.Height * ($targetW / $hiacePng.Width))
$posX = [int](($w - $targetW) / 2)
$posY = [int]($h - $targetH - 30)

# Soft realistic shadow
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 0, 0, 0))), ($posX + 40), ($posY + $targetH - 40), ($targetW - 80), 38)
$g.DrawImage($hiacePng, $posX, $posY, $targetW, $targetH)

$g.Dispose()
$testBmp.Save("$PSScriptRoot/assets/test_tugu_hiace.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)
$testBmp.Dispose()
$tuguPlaza.Dispose()
$hiacePng.Dispose()

Write-Host "Created test_tugu_hiace.jpg"
