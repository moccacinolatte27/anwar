Add-Type -AssemblyName System.Drawing

$refPath = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791345057893.png"
$agyaPath = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\agya-full-body-cutout.png"
$dest = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-lineup-anza.png"

$refBytes = [System.IO.File]::ReadAllBytes($refPath)
$refMs = New-Object System.IO.MemoryStream(,$refBytes)
$refBmp = [System.Drawing.Bitmap]::FromStream($refMs)

$agyaBytes = [System.IO.File]::ReadAllBytes($agyaPath)
$agyaMs = New-Object System.IO.MemoryStream(,$agyaBytes)
$agyaBmp = [System.Drawing.Bitmap]::FromStream($agyaMs)

$canvas = New-Object System.Drawing.Bitmap($refBmp.Width, $refBmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($canvas)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# 1. Draw base reference (Hiace, Avanza, Reborn with background)
$g.DrawImage($refBmp, 0, 0, $refBmp.Width, $refBmp.Height)

# 2. Position Agya between Hiace and Avanza
$agyaW = 210
$agyaH = [int]($agyaW * ($agyaBmp.Height / $agyaBmp.Width))
$agyaX = 185
$agyaY = 160

# 2a. Agya Floor Reflection
$reflH = [int]($agyaH * 0.45)
$reflY = $agyaY + $agyaH - 4
$agyaRefl = New-Object System.Drawing.Bitmap($agyaBmp.Width, $agyaBmp.Height)
$rg = [System.Drawing.Graphics]::FromImage($agyaRefl)
$rg.DrawImage($agyaBmp, 0, 0, $agyaBmp.Width, $agyaBmp.Height)
$rg.Dispose()
$agyaRefl.RotateFlip([System.Drawing.RotateFlipType]::RotateNoneFlipY)

$ia = New-Object System.Drawing.Imaging.ImageAttributes
$cm = New-Object System.Drawing.Imaging.ColorMatrix
$cm.Matrix33 = 0.22 # subtle reflection
$ia.SetColorMatrix($cm)
$reflRect = New-Object System.Drawing.Rectangle($agyaX, $reflY, $agyaW, $reflH)
$g.DrawImage($agyaRefl, $reflRect, 0, 0, $agyaBmp.Width, [int]($agyaBmp.Height * 0.45), [System.Drawing.GraphicsUnit]::Pixel, $ia)
$ia.Dispose()
$agyaRefl.Dispose()

# 2b. Draw Agya Car Body
$g.DrawImage($agyaBmp, $agyaX, $agyaY, $agyaW, $agyaH)

# 3. Restore foreground Avanza overlap
$avanzaW = 190
$avanzaH = 220
$avanzaX = 295
$avanzaY = 120
$avanzaCropRect = New-Object System.Drawing.Rectangle($avanzaX, $avanzaY, $avanzaW, $avanzaH)

$avanzaFg = New-Object System.Drawing.Bitmap($avanzaW, $avanzaH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$fg = [System.Drawing.Graphics]::FromImage($avanzaFg)
$fg.DrawImage($refBmp, (New-Object System.Drawing.Rectangle(0, 0, $avanzaW, $avanzaH)), $avanzaCropRect, [System.Drawing.GraphicsUnit]::Pixel)
$fg.Dispose()

# Mask out orange background from avanzaFg so only Avanza body is overlaid on top of Agya
for ($x = 0; $x -lt $avanzaW; $x++) {
    for ($y = 0; $y -lt $avanzaH; $y++) {
        $origX = $avanzaX + $x
        if ($origX -lt ($agyaX + $agyaW)) {
            $c = $avanzaFg.GetPixel($x, $y)
            $isOrangeBg = ($c.R -gt 160 -and ($c.R - $c.B) -gt 45 -and $c.G -gt 90)
            if ($isOrangeBg) {
                $avanzaFg.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            }
        }
    }
}

$g.DrawImage($avanzaFg, $avanzaX, $avanzaY)
$avanzaFg.Dispose()

$g.Dispose()

$canvas.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
$canvas.Dispose()
$agyaBmp.Dispose()
$refBmp.Dispose()
$agyaMs.Dispose()
$refMs.Dispose()

Write-Output "Successfully composed 4-car hero lineup banner!"
