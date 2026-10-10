Add-Type -AssemblyName System.Drawing

$src = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.tempmediaStorage\media_1791345844129.jpg"
$dest = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-innova-reborn.jpg"

$bytes = [System.IO.File]::ReadAllBytes($src)
$ms = New-Object System.IO.MemoryStream(,$bytes)
$bmp = [System.Drawing.Bitmap]::FromStream($ms)

$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# 1. Subtle, ultra-clean Bi-LED projector lens glow inside the main glass projector lens
# The projector lens in media_1791345844129.jpg is located at (586, 492)
$cx = 586.0
$cy = 492.0

# Thin, precise optic ring (Angel Eye halo)
$penHalo = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 100, 210, 255), [float]1.6)
$g.DrawEllipse($penHalo, [float]($cx - 13), [float]($cy - 14), [float]26, [float]28)
$penHalo.Dispose()

# Soft glow around the lens
$penGlow = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 0, 180, 255), [float]3.0)
$g.DrawEllipse($penGlow, [float]($cx - 14), [float]($cy - 15), [float]28, [float]30)
$penGlow.Dispose()

# Small crystal laser core specular
$coreBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(210, 240, 255, 255))
$g.FillEllipse($coreBrush, [float]($cx - 3.5), [float]($cy - 3.5), [float]7.0, [float]7.0)
$coreBrush.Dispose()

# 2. Sleek OEM+ LED DRL eyebrow blade along the upper light housing edge
# Follows the exact contour of the headlamp housing
$p1 = New-Object System.Drawing.PointF(535.0, 477.0)
$p2 = New-Object System.Drawing.PointF(570.0, 470.0)
$p3 = New-Object System.Drawing.PointF(610.0, 461.0)
$p4 = New-Object System.Drawing.PointF(648.0, 452.0)
[System.Drawing.PointF[]]$drlPts = @($p1, $p2, $p3, $p4)

# Soft DRL ambient light
$penDrlGlow = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(75, 50, 180, 255), [float]3.5)
$penDrlGlow.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penDrlGlow.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$g.DrawCurve($penDrlGlow, $drlPts, [float]0.35)
$penDrlGlow.Dispose()

# Crisp white-ice DRL light strip
$penDrlSharp = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 235, 250, 255), [float]1.6)
$penDrlSharp.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penDrlSharp.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$g.DrawCurve($penDrlSharp, $drlPts, [float]0.35)
$penDrlSharp.Dispose()

# 3. Far side headlight subtle projector glow
$penFar = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(150, 80, 200, 255), [float]1.8)
$g.DrawEllipse($penFar, 381, 495, 6, 5)
$penFar.Dispose()

$penFarDrl = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 230, 250, 255), [float]1.3)
$g.DrawLine($penFarDrl, 375, 492, 396, 490)
$penFarDrl.Dispose()

$g.Dispose()

# Save
$bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Dispose()
$ms.Dispose()

Write-Output "Successfully generated natural, professional headlamp mod for 2024 Innova Reborn!"
