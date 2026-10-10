Add-Type -AssemblyName System.Drawing

$width = 1400
$height = 750
$bmp = New-Object System.Drawing.Bitmap($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# 1. LUXURY STUDIO GRADIENT BACKGROUND
# Dark slate top to warm amber/bronze studio horizon, matching media_1791345057893.png
$rectBg = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
$linBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $rectBg,
    [System.Drawing.Color]::FromArgb(255, 15, 23, 42), # Slate-900 at top
    [System.Drawing.Color]::FromArgb(255, 30, 27, 24), # Warm dark bronze at bottom
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$g.FillRectangle($linBrush, $rectBg)
$linBrush.Dispose()

# Ambient Golden-Amber Center Glow
$pathGlow = New-Object System.Drawing.Drawing2D.GraphicsPath
$pathGlow.AddEllipse(200, 100, 1000, 450)
$pbg = New-Object System.Drawing.Drawing2D.PathGradientBrush($pathGlow)
$pbg.CenterColor = [System.Drawing.Color]::FromArgb(90, 245, 158, 11) # Amber glow
$pbg.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 15, 23, 42))
$g.FillPath($pbg, $pathGlow)
$pbg.Dispose()
$pathGlow.Dispose()

# Vertical Light Beams (as seen in user's reference)
$beamBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 255, 255, 255))
$g.FillRectangle($beamBrush, 280, 0, 14, 520)
$g.FillRectangle($beamBrush, 520, 0, 10, 520)
$g.FillRectangle($beamBrush, 890, 0, 16, 520)
$g.FillRectangle($beamBrush, 1140, 0, 12, 520)
$beamBrush.Dispose()

# Subtle Jogja Monument / Architectural silhouette in background
# (Soft warm watermarked background pattern)
$jogjaSilhouetteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, 251, 191, 36))
# Stylized Tugu Jogja top spire silhouette in far center background
$tuguPts = @(
    (New-Object System.Drawing.Point 700, 120),
    (New-Object System.Drawing.Point 706, 170),
    (New-Object System.Drawing.Point 718, 260),
    (New-Object System.Drawing.Point 726, 380),
    (New-Object System.Drawing.Point 674, 380),
    (New-Object System.Drawing.Point 682, 260),
    (New-Object System.Drawing.Point 694, 170)
)
$g.FillPolygon($jogjaSilhouetteBrush, $tuguPts)
$jogjaSilhouetteBrush.Dispose()

# Ground Floor Line & Glossy Floor (Y: 480 to 750)
$groundRect = New-Object System.Drawing.Rectangle(0, 480, $width, 270)
$groundBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $groundRect,
    [System.Drawing.Color]::FromArgb(240, 28, 25, 23),
    [System.Drawing.Color]::FromArgb(255, 12, 10, 9),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$g.FillRectangle($groundBrush, $groundRect)
$groundBrush.Dispose()

# Load Transparent Studio Cars
$hiace = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-hiace.png")
$reborn = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-reborn.png")
$avanza = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-avanza.png")
$agya = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/hero-car-agya.png")

# Helper function to draw car with realistic floor reflection and shadow
function Draw-CarWithReflection($graphics, $carImg, $x, $y, $destW, $destH, $shadowY, $shadowW, $shadowH, $hasReflection) {
    # 1. Floor Reflection (flipped vertically, faded)
    if ($hasReflection) {
        $reflH = [int]($destH * 0.45)
        $reflBmp = New-Object System.Drawing.Bitmap($destW, $reflH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $gRefl = [System.Drawing.Graphics]::FromImage($reflBmp)
        $gRefl.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $gRefl.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        
        # Draw flipped bottom portion of car
        $srcCropH = [int]($carImg.Height * 0.45)
        $srcRect = New-Object System.Drawing.Rectangle(0, $carImg.Height - $srcCropH, $carImg.Width, $srcCropH)
        $destRect = New-Object System.Drawing.Rectangle(0, 0, $destW, $reflH)
        $gRefl.DrawImage($carImg, $destRect, 0, $carImg.Height - 1, $carImg.Width, -$srcCropH, [System.Drawing.GraphicsUnit]::Pixel)
        $gRefl.Dispose()
        
        # Apply fading alpha gradient to reflection
        $fadeBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            (New-Object System.Drawing.Rectangle 0, 0, $destW, $reflH),
            [System.Drawing.Color]::FromArgb(70, 0, 0, 0),
            [System.Drawing.Color]::FromArgb(255, 0, 0, 0),
            [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
        )
        $gReflFade = [System.Drawing.Graphics]::FromImage($reflBmp)
        $gReflFade.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
        # Blend faded reflection onto main canvas
        $ia = New-Object System.Drawing.Imaging.ImageAttributes
        $cm = New-Object System.Drawing.Imaging.ColorMatrix
        $cm.Matrix33 = 0.28 # 28% opacity for reflection
        $ia.SetColorMatrix($cm)
        $graphics.DrawImage($reflBmp, (New-Object System.Drawing.Rectangle $x, ($y + $destH - 6), $destW, $reflH), 0, 0, $destW, $reflH, [System.Drawing.GraphicsUnit]::Pixel, $ia)
        $ia.Dispose()
        $reflBmp.Dispose()
    }

    # 2. Ground Contact Shadow
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 0, 0, 0))
    $graphics.FillEllipse($shadowBrush, $x + ($destW - $shadowW)/2, $shadowY, $shadowW, $shadowH)
    $shadowBrush.Dispose()

    # 3. Draw Actual Car Image
    $graphics.DrawImage($carImg, $x, $y, $destW, $destH)
}

# --- DYNAMIC 4-CAR STAGGERED POSITIONING ---
# 1. BACK LAYER LEFT: Toyota Hiace Premio Luxury
# Tall, imposing, angled inward towards center
$hiW = 540
$hiH = [int]($hiace.Height * ($hiW / $hiace.Width))
Draw-CarWithReflection $g $hiace 20 (490 - $hiH) $hiW $hiH 468 490 55 $true

# 2. BACK LAYER RIGHT: Toyota Innova Reborn
# Premium MPV, slightly set back on the right, angled inward
$rebW = 560
$rebH = [int]($reborn.Height * ($rebW / $reborn.Width))
Draw-CarWithReflection $g $reborn 810 (510 - $rebH) $rebW $rebH 485 530 52 $true

# 3. MIDDLE-LEFT ACCENT: Toyota Agya GR Sport
# Compact, modern, positioned nestled in front of Hiace's flank
$agW = 420
$agH = [int]($agya.Height * ($agW / $agya.Width))
Draw-CarWithReflection $g $agya 140 (580 - $agH) $agW $agH 550 400 48 $true

# 4. FOREGROUND CENTER-STAGE: All New Avanza FWD
# Front & center, closest to camera, dynamic overlap, crisp & dominant
$avW = 630
$avH = [int]($avanza.Height * ($avW / $avanza.Width))
Draw-CarWithReflection $g $avanza 420 (600 - $avH) $avW $avH 565 600 55 $true

# --- FINISHING LUXURY LIGHTING ACCENTS ---
# Horizon subtle light line
$horizPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(40, 251, 191, 36), 1.5)
$g.DrawLine($horizPen, 0, 480, $width, 480)
$horizPen.Dispose()

# Vignette Border for dramatic focus
$vigBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle 0, 0, 180, $height),
    [System.Drawing.Color]::FromArgb(180, 15, 23, 42),
    [System.Drawing.Color]::FromArgb(0, 15, 23, 42),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($vigBrush, 0, 0, 180, $height)
$vigBrush.Dispose()

$vigRight = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle ($width - 180), 0, 180, $height),
    [System.Drawing.Color]::FromArgb(0, 15, 23, 42),
    [System.Drawing.Color]::FromArgb(180, 15, 23, 42),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($vigRight, ($width - 180), 0, 180, $height)
$vigRight.Dispose()

$g.Dispose()
$hiace.Dispose()
$reborn.Dispose()
$avanza.Dispose()
$agya.Dispose()

$outFile = "$PSScriptRoot/assets/hero-fleet-showcase.png"
$bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Write-Host "SUCCESS: Created $outFile"
