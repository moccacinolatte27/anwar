Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")
$bg = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/toyota-innova-reborn.jpg")

Write-Host "Processing Reborn Cutout and Composite..."

# In media_1791354183988.jpg:
# Dimensions: 1024 x 768
# Let's create an alpha mask for the car body
$mask = New-Object System.Drawing.Bitmap($src.Width, $src.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gMask = [System.Drawing.Graphics]::FromImage($mask)
$gMask.Clear([System.Drawing.Color]::Transparent)

# Let's inspect the precise polygon of the car body in user image
# Key landmark points of the car in media_1791354183988.jpg:
# Roof: from (X: 250, Y: 270) to (X: 620, Y: 270)
# A-pillar left: down to (X: 190, Y: 360)
# Left mirror: (X: 165, Y: 380) to (X: 240, Y: 410)
# Rear side / left fender: (X: 165, Y: 400) to (X: 175, Y: 640)
# Left rear tire: (X: 175, Y: 550) to (X: 210, Y: 640)
# Front left tire: (X: 235, Y: 590) to (X: 295, Y: 870)
# Front bumper bottom: (X: 300, Y: 820) across to (X: 770, Y: 720)
# Right front bumper / fog: (X: 750, Y: 600)
# Right headlight: (X: 740, Y: 480)
# Hood edge right: (X: 730, Y: 440)
# Windshield right / A-pillar: (X: 620, Y: 270)

# Let's create a clean cutout mask with anti-aliasing
$path = New-Object System.Drawing.Drawing2D.GraphicsPath

# Poly points around car outline:
$pts = @(
    New-Object System.Drawing.Point(235, 275),  # Roof top left
    New-Object System.Drawing.Point(360, 270),  # Roof peak
    New-Object System.Drawing.Point(520, 290),  # Roof right
    New-Object System.Drawing.Point(630, 360),  # Right A-pillar top
    New-Object System.Drawing.Point(685, 420),  # Right windshield base
    New-Object System.Drawing.Point(732, 450),  # Right hood corner
    New-Object System.Drawing.Point(760, 480),  # Right headlight outer tip
    New-Object System.Drawing.Point(778, 545),  # Right bumper side
    New-Object System.Drawing.Point(780, 600),  # Right bumper bottom side
    New-Object System.Drawing.Point(765, 680),  # Right lower spoiler corner
    New-Object System.Drawing.Point(725, 735),  # Front lower chin right
    New-Object System.Drawing.Point(630, 765),  # Front lower chin center-right
    New-Object System.Drawing.Point(520, 775),  # Front lower chin center
    New-Object System.Drawing.Point(380, 810),  # Front lower chin left
    New-Object System.Drawing.Point(310, 830),  # Left front bumper bottom
    New-Object System.Drawing.Point(285, 870),  # Left front tire bottom
    New-Object System.Drawing.Point(255, 870),  # Left front tire contact patch
    New-Object System.Drawing.Point(238, 770),  # Left front tire front
    New-Object System.Drawing.Point(238, 620),  # Left front fender arch
    New-Object System.Drawing.Point(205, 645),  # Left rear tire bottom
    New-Object System.Drawing.Point(175, 645),  # Left rear tire base
    New-Object System.Drawing.Point(175, 550),  # Left rear wheel well
    New-Object System.Drawing.Point(170, 480),  # Left door lower
    New-Object System.Drawing.Point(165, 415),  # Left mirror base
    New-Object System.Drawing.Point(162, 385),  # Left mirror outer tip
    New-Object System.Drawing.Point(185, 360),  # Left mirror top
    New-Object System.Drawing.Point(230, 370),  # Left A-pillar lower
    New-Object System.Drawing.Point(205, 320)   # Left roof edge
)

$path.AddPolygon($pts)
$gMask.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$gMask.FillPath([System.Drawing.Brushes]::White, $path)

# Apply mask to create isolated car PNG
$carCutout = New-Object System.Drawing.Bitmap($src.Width, $src.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $src.Height; $y++) {
    for ($x = 0; $x -lt $src.Width; $x++) {
        $mCol = $mask.GetPixel($x, $y)
        if ($mCol.A -gt 10) {
            $sCol = $src.GetPixel($x, $y)
            $carCutout.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($mCol.A, $sCol.R, $sCol.G, $sCol.B))
        }
    }
}

$carCutout.Save("$PSScriptRoot/assets/reborn-isolated.png", [System.Drawing.Imaging.ImageFormat]::Png)

$gMask.Dispose()
$mask.Dispose()
$carCutout.Dispose()
$src.Dispose()
$bg.Dispose()

Write-Host "Cutout saved to assets/reborn-isolated.png"
