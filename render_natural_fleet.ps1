Add-Type -AssemblyName System.Drawing

$width = 1400
$height = 680
$bmp = New-Object System.Drawing.Bitmap($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. LUXURY WARM AMBER-PEACH STUDIO BACKGROUND (Matching user reference)
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
$pathGlow1.AddEllipse(120, 20, 1160, 480)
$pbg1 = New-Object System.Drawing.Drawing2D.PathGradientBrush($pathGlow1)
$pbg1.CenterColor = [System.Drawing.Color]::FromArgb(150, 255, 252, 242)
$pbg1.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 236, 172, 120))
$g.FillPath($pbg1, $pathGlow1)
$pbg1.Dispose()
$pathGlow1.Dispose()

# Vertical Soft Architectural Light Pillars (matching reference style)
$beam1 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35, 255, 255, 255))
$g.FillRectangle($beam1, 230, 0, 24, 460)
$g.FillRectangle($beam1, 560, 0, 20, 460)
$g.FillRectangle($beam1, 840, 0, 26, 460)
$g.FillRectangle($beam1, 1170, 0, 22, 460)
$beam1.Dispose()

# Floor: Clean Luxury Showroom Floor (Y: 450 to 680)
$floorRect = New-Object System.Drawing.Rectangle(0, 450, $width, 230)
$floorBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $floorRect,
    [System.Drawing.Color]::FromArgb(255, 254, 251, 248),
    [System.Drawing.Color]::FromArgb(255, 238, 224, 212),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$g.FillRectangle($floorBrush, $floorRect)
$floorBrush.Dispose()

# Horizon subtle highlight line
$horizPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(90, 255, 255, 255), 2.0)
$g.DrawLine($horizPen, 0, 450, $width, 450)
$horizPen.Dispose()

# Floor Horizon Warm Reflection
$floorGlow = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(0, 450, $width, 50)),
    [System.Drawing.Color]::FromArgb(50, 236, 172, 120),
    [System.Drawing.Color]::FromArgb(0, 236, 172, 120),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$g.FillRectangle($floorGlow, 0, 450, $width, 50)
$floorGlow.Dispose()

# Load the 4 contrasting cars:
# 1. Hiace (Silver/White)
# 2. Reborn (Attitude Black)
# 3. Agya (Sporty Red Mica Metallic)
# 4. Avanza FWD (Dark Modern Metallic Grey)
$hiace = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-hiace.png")
$reborn = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-reborn-black.png")
$agya = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-agya-red.png")
$avanza = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-avanza.png")

# --- LAYER 1 (BACK LEFT): TOYOTA HIACE PREMIO LUXURY (Silver/White) ---
$hiW = 600
$hiH = [int]($hiace.Height * ($hiW / $hiace.Width))
$hiX = 30
$hiY = 512 - $hiH
$g.DrawImage($hiace, $hiX, $hiY, $hiW, $hiH)

# --- LAYER 2 (BACK RIGHT): TOYOTA INNOVA REBORN (Attitude Black) ---
$rebW = 640
$rebH = [int]($reborn.Height * ($rebW / $reborn.Width))
$rebX = 720
$rebY = 530 - $rebH
$g.DrawImage($reborn, $rebX, $rebY, $rebW, $rebH)

# --- LAYER 3 (FRONT LEFT): TOYOTA NEW AGYA GR SPORT (Red Mica Metallic) ---
$agW = 445
$agH = [int]($agya.Height * ($agW / $agya.Width))
$agX = 180
$agY = 600 - $agH
$g.DrawImage($agya, $agX, $agY, $agW, $agH)

# --- LAYER 4 (FRONT CENTER-RIGHT HERO): ALL NEW AVANZA FWD (Modern Grey Metallic) ---
$avW = 710
$avH = [int]($avanza.Height * ($avW / $avanza.Width))
$avX = 415
$avY = 625 - $avH
$g.DrawImage($avanza, $avX, $avY, $avW, $avH)

# Ambient Studio Vignette at horizontal edges
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

Write-Host "SUCCESS: Generated natural multi-color fleet banner at $outFile"
