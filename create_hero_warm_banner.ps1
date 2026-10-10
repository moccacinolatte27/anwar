Add-Type -AssemblyName System.Drawing

$width = 1400
$height = 680
$bmp = New-Object System.Drawing.Bitmap($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. LUXURY WARM AMBER-PEACH STUDIO BACKGROUND (Identical to user reference)
$rectBg = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
$linBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $rectBg,
    [System.Drawing.Color]::FromArgb(255, 248, 238, 230), # Soft cream top
    [System.Drawing.Color]::FromArgb(255, 236, 172, 120), # Warm amber horizon
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$g.FillRectangle($linBrush, $rectBg)
$linBrush.Dispose()

# Ambient Golden Center Glow
$pathGlow1 = New-Object System.Drawing.Drawing2D.GraphicsPath
$pathGlow1.AddEllipse(200, 30, 1000, 480)
$pbg1 = New-Object System.Drawing.Drawing2D.PathGradientBrush($pathGlow1)
$pbg1.CenterColor = [System.Drawing.Color]::FromArgb(150, 255, 250, 235)
$pbg1.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 236, 172, 120))
$g.FillPath($pbg1, $pathGlow1)
$pbg1.Dispose()
$pathGlow1.Dispose()

# Vertical Soft Light Flares / Architectural Pillars (matching reference)
$beam1 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35, 255, 255, 255))
$g.FillRectangle($beam1, 260, 0, 24, 480)
$g.FillRectangle($beam1, 600, 0, 18, 480)
$g.FillRectangle($beam1, 860, 0, 26, 480)
$g.FillRectangle($beam1, 1140, 0, 20, 480)
$beam1.Dispose()

# Floor: Clean Pearl-Reflective Surface (Y: 460 to 680)
$floorRect = New-Object System.Drawing.Rectangle(0, 460, $width, 220)
$floorBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $floorRect,
    [System.Drawing.Color]::FromArgb(255, 253, 250, 247),
    [System.Drawing.Color]::FromArgb(255, 240, 228, 216),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$g.FillRectangle($floorBrush, $floorRect)
$floorBrush.Dispose()

# Horizon subtle highlight line
$horizPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 255, 255, 255), 2.0)
$g.DrawLine($horizPen, 0, 460, $width, 460)
$horizPen.Dispose()

# Load Transparent Studio Cars
$hiace = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-hiace.png")
$reborn = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-reborn.png")
$avanza = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-avanza.png")
$agya = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-agya.png")

# --- LAYER 1 (BACK LEFT): TOYOTA HIACE PREMIO LUXURY ---
# Grounded at Y = 510
$hiW = 590
$hiH = [int]($hiace.Height * ($hiW / $hiace.Width))
$hiX = 35
$hiY = 510 - $hiH
$g.DrawImage($hiace, $hiX, $hiY, $hiW, $hiH)

# --- LAYER 2 (BACK RIGHT): TOYOTA INNOVA REBORN ---
# Grounded at Y = 530 (Lowered so perspective aligns naturally with Hiace)
$rebW = 620
$rebH = [int]($reborn.Height * ($rebW / $reborn.Width))
$rebX = 740
$rebY = 530 - $rebH
$g.DrawImage($reborn, $rebX, $rebY, $rebW, $rebH)

# --- LAYER 3 (FRONT LEFT): TOYOTA AGYA GR SPORT ---
# Grounded at Y = 595, positioned nestled between Hiace and Avanza
$agW = 430
$agH = [int]($agya.Height * ($agW / $agya.Width))
$agX = 180
$agY = 595 - $agH
$g.DrawImage($agya, $agX, $agY, $agW, $agH)

# --- LAYER 4 (FRONT CENTER HERO): ALL NEW AVANZA FWD ---
# Front and dominant, grounded at Y = 620
$avW = 690
$avH = [int]($avanza.Height * ($avW / $avanza.Width))
$avX = 400
$avY = 620 - $avH
$g.DrawImage($avanza, $avX, $avY, $avW, $avH)

# Ambient Studio Vignette at corners
$vigLeft = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle 0, 0, 160, $height),
    [System.Drawing.Color]::FromArgb(40, 215, 130, 60),
    [System.Drawing.Color]::FromArgb(0, 215, 130, 60),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($vigLeft, 0, 0, 160, $height)
$vigLeft.Dispose()

$vigRight = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle ($width - 160), 0, 160, $height),
    [System.Drawing.Color]::FromArgb(0, 215, 130, 60),
    [System.Drawing.Color]::FromArgb(40, 215, 130, 60),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($vigRight, ($width - 160), 0, 160, $height)
$vigRight.Dispose()

$g.Dispose()
$hiace.Dispose()
$reborn.Dispose()
$avanza.Dispose()
$agya.Dispose()

$outFile = "$PSScriptRoot/assets/hero-fleet-banner.png"
$bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Write-Host "SUCCESS: Generated perfect $outFile"
