Add-Type -AssemblyName System.Drawing

$src = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.tempmediaStorage\media_1791345844129.jpg"
$dest = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-innova-reborn.jpg"

$bytes = [System.IO.File]::ReadAllBytes($src)
$ms = New-Object System.IO.MemoryStream(,$bytes)
$bmp = [System.Drawing.Bitmap]::FromStream($ms)

# Identify artificial blue strokes (R < 90, G in [120, 220], B > 210) on the front of the car
# Box: X from 250 to 620, Y from 440 to 520
for ($x = 250; $x -lt 620; $x++) {
    for ($y = 440; $y -lt 520; $y++) {
        $c = $bmp.GetPixel($x, $y)
        # Check if artificial cyan/blue marker
        if ($c.B -gt 190 -and $c.R -lt 110 -and $c.G -gt 100) {
            # Find closest non-marker pixel above or below
            $replacement = $null
            for ($offset = 1; $offset -le 5; $offset++) {
                if ($y - $offset -ge 0) {
                    $cUp = $bmp.GetPixel($x, $y - $offset)
                    if (-not ($cUp.B -gt 190 -and $cUp.R -lt 110 -and $cUp.G -gt 100)) {
                        $replacement = $cUp
                        break
                    }
                }
                if ($y + $offset -lt $bmp.Height) {
                    $cDown = $bmp.GetPixel($x, $y + $offset)
                    if (-not ($cDown.B -gt 190 -and $cDown.R -lt 110 -and $cDown.G -gt 100)) {
                        $replacement = $cDown
                        break
                    }
                }
            }
            if ($replacement -ne $null) {
                $bmp.SetPixel($x, $y, $replacement)
            }
        }
    }
}

# Now add clean, authentic modified Bi-LED projector elements
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

# Double Bi-LED projector lenses:
# Lens 1 (main projector): center (586, 492)
$penRing1 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(210, 160, 225, 255), [float]1.8)
$g.DrawEllipse($penRing1, 574, 480, 24, 25)
$penRing1.Dispose()

# Lens 2 (inner projector): center (554, 498)
$penRing2 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 160, 225, 255), [float]1.6)
$g.DrawEllipse($penRing2, 545, 489, 18, 19)
$penRing2.Dispose()

# Subtle upper DRL light strip along headlight contour
$p1 = New-Object System.Drawing.PointF(540.0, 477.0)
$p2 = New-Object System.Drawing.PointF(575.0, 470.0)
$p3 = New-Object System.Drawing.PointF(612.0, 461.0)
$p4 = New-Object System.Drawing.PointF(648.0, 452.0)
[System.Drawing.PointF[]]$drlPts = @($p1, $p2, $p3, $p4)

$penDrlGlow = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(70, 100, 200, 255), [float]3.0)
$penDrlGlow.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penDrlGlow.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$g.DrawCurve($penDrlGlow, $drlPts, [float]0.3)
$penDrlGlow.Dispose()

$penDrlCore = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(230, 240, 255, 255), [float]1.4)
$penDrlCore.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penDrlCore.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$g.DrawCurve($penDrlCore, $drlPts, [float]0.3)
$penDrlCore.Dispose()

$g.Dispose()

$bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Dispose()
$ms.Dispose()

Write-Output "Innova Reborn cleaned and retrofitted with sleek OEM+ Bi-LED headlamps!"
