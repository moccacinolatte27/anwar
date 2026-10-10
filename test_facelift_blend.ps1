Add-Type -AssemblyName System.Drawing

$base = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg")
$facelift = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-seva-black.png")

# Flip facelift so front faces left
$facelift.RotateFlip([System.Drawing.RotateFlipType]::RotateNoneFlipX)

$w = $base.Width
$h = $base.Height

$outBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($outBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# 1. Base image
$g.DrawImage($base, 0, 0, $w, $h)

# 2. In base image, the front nose & headlights are at:
# Nose tip: X ~270, Y ~620
# Headlight: X ~360..470, Y ~600..635
# Lower chin: X ~270..360, Y ~700..760
# In flipped facelift:
# Crop the front nose region (grille, headlights, bumper chin)
# In 1280x960 flipped facelift:
# Nose is on the left: X ~50..650, Y ~360..860
$frontCrop = New-Object System.Drawing.Bitmap(600, 500, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gCrop = [System.Drawing.Graphics]::FromImage($frontCrop)
$gCrop.DrawImage($facelift, 0, 0, (New-Object System.Drawing.Rectangle 40, 360, 600, 500), [System.Drawing.GraphicsUnit]::Pixel)
$gCrop.Dispose()

# Feathered alpha mask for seamless blend
$blendW = 380
$blendH = [int]($frontCrop.Height * ($blendW / $frontCrop.Width))
$destX = 220
$destY = 560

$g.DrawImage($frontCrop, $destX, $destY, $blendW, $blendH)

$g.Dispose()
$frontCrop.Dispose()
$base.Dispose()
$facelift.Dispose()

$outFile = "$PSScriptRoot/assets/test_reborn_facelift_blend.jpg"
$outBmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$outBmp.Dispose()

Write-Host "Created test_reborn_facelift_blend.jpg"
