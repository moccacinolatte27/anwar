Add-Type -AssemblyName System.Drawing

$src = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg"
$dest = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-innova-reborn.jpg"

$bytes = [System.IO.File]::ReadAllBytes($src)
$ms = New-Object System.IO.MemoryStream(,$bytes)
$bmp = [System.Drawing.Bitmap]::FromStream($ms)

$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# 1. Custom Bi-LED Projector Halo (Outer Shroud Ring)
$cx = 586.0
$cy = 492.0
$rx = 13.5
$ry = 15.0

# Soft cyan halo glow
for ($i = 4; $i -ge 1; $i--) {
    $alpha = [int](35 + (4 - $i) * 20)
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb($alpha, 0, 195, 255), [float]($i * 1.5))
    $g.DrawEllipse($pen, [float]($cx - $rx - $i), [float]($cy - $ry - $i), [float](($rx + $i) * 2), [float](($ry + $i) * 2))
    $pen.Dispose()
}

# Inner bright crystal blue ring
$penSharp = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(235, 180, 240, 255), [float]2.2)
$g.DrawEllipse($penSharp, [float]($cx - $rx), [float]($cy - $ry), [float]($rx * 2), [float]($ry * 2))
$penSharp.Dispose()

# Central Bi-LED laser core glow
$innerPath = New-Object System.Drawing.Drawing2D.GraphicsPath
$innerPath.AddEllipse([float]($cx - 5), [float]($cy - 5), [float]10, [float]10)
$pbg = New-Object System.Drawing.Drawing2D.PathGradientBrush($innerPath)
$pbg.CenterColor = [System.Drawing.Color]::FromArgb(240, 255, 255, 255)
$pbg.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 0, 180, 255))
$g.FillEllipse($pbg, [float]($cx - 5), [float]($cy - 5), [float]10, [float]10)
$pbg.Dispose()
$innerPath.Dispose()

# 2. Secondary Mini Projector (Double Projie Retrofit)
$cx2 = 552.0
$cy2 = 499.0
$rx2 = 9.0
$ry2 = 11.0

$pen2Glow = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(90, 0, 210, 255), [float]3.0)
$g.DrawEllipse($pen2Glow, [float]($cx2 - $rx2 - 1), [float]($cy2 - $ry2 - 1), [float](($rx2 + 1) * 2), [float](($ry2 + 1) * 2))
$pen2Glow.Dispose()

$pen2Sharp = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 200, 245, 255), [float]1.8)
$g.DrawEllipse($pen2Sharp, [float]($cx2 - $rx2), [float]($cy2 - $ry2), [float]($rx2 * 2), [float]($ry2 * 2))
$pen2Sharp.Dispose()

# 3. Modern Audi-style Dynamic DRL Eyebrow Blade along top edge
$p1 = New-Object System.Drawing.PointF(518.0, 481.0)
$p2 = New-Object System.Drawing.PointF(555.0, 473.0)
$p3 = New-Object System.Drawing.PointF(600.0, 464.0)
$p4 = New-Object System.Drawing.PointF(648.0, 453.0)
[System.Drawing.PointF[]]$pts = @($p1, $p2, $p3, $p4)

# Glow
$penDrlGlow = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(90, 0, 180, 255), [float]4.5)
$penDrlGlow.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penDrlGlow.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$g.DrawCurve($penDrlGlow, $pts, [float]0.4)
$penDrlGlow.Dispose()

# Sharp white-blue core DRL line
$penDrlCore = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(240, 220, 245, 255), [float]2.0)
$penDrlCore.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penDrlCore.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$g.DrawCurve($penDrlCore, $pts, [float]0.4)
$penDrlCore.Dispose()

# 4. Far Right Headlight (driver's right side, viewer's left) subtle glow
$penFar = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 0, 200, 255), [float]2.5)
$g.DrawEllipse($penFar, 377, 495, 7, 6)
$penFar.Dispose()
$penFarDrl = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 220, 245, 255), [float]1.5)
$g.DrawLine($penFarDrl, 373, 492, 395, 490)
$penFarDrl.Dispose()

$g.Dispose()

# Save
$bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Dispose()
$ms.Dispose()

Write-Output "Successfully generated custom modified headlamp for Innova Reborn 2024!"
