Add-Type -AssemblyName System.Drawing

$canvasWidth = 1200
$canvasHeight = 560
$bmp = New-Object System.Drawing.Bitmap($canvasWidth, $canvasHeight, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)

# Load the 4 cars
$hiace = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-hiace.png")
$reborn = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-reborn.png")
$avanza = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-avanza.png")
$agya = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-agya.png")

# Draw Ground Soft Shadows
$shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(60, 0, 0, 0))
$g.FillEllipse($shadowBrush, 20, 420, 500, 70)   # Hiace shadow
$g.FillEllipse($shadowBrush, 620, 420, 520, 65)  # Reborn shadow
$g.FillEllipse($shadowBrush, 360, 470, 520, 60)  # Avanza shadow
$g.FillEllipse($shadowBrush, 130, 470, 360, 55)  # Agya shadow

# 1. Back Layer Left: Hiace
# Hiace original aspect ratio:
$hiaceW = 500
$hiaceH = [int]($hiace.Height * ($hiaceW / $hiace.Width))
$g.DrawImage($hiace, 30, 430 - $hiaceH, $hiaceW, $hiaceH)

# 2. Back Layer Right: Reborn
$rebornW = 530
$rebornH = [int]($reborn.Height * ($rebornW / $reborn.Width))
$g.DrawImage($reborn, 630, 435 - $rebornH, $rebornW, $rebornH)

# 3. Front Layer Left: Agya
$agyaW = 390
$agyaH = [int]($agya.Height * ($agyaW / $agya.Width))
$g.DrawImage($agya, 120, 510 - $agyaH, $agyaW, $agyaH)

# 4. Front Layer Center-Right: Avanza FWD
$avanzaW = 530
$avanzaH = [int]($avanza.Height * ($avanzaW / $avanza.Width))
$g.DrawImage($avanza, 390, 515 - $avanzaH, $avanzaW, $agyaW * ($avanza.Height / $avanza.Width) * (530/390))

$g.Dispose()
$hiace.Dispose()
$reborn.Dispose()
$avanza.Dispose()
$agya.Dispose()

$outPath = "$PSScriptRoot/assets/hero-fleet-lineup.png"
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Write-Host "Created $outPath"
