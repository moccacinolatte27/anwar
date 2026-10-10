Add-Type -AssemblyName System.Drawing

$src = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\agya-crop.jpg"
$dest = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\agya-full-body-cutout.png"

$bytes = [System.IO.File]::ReadAllBytes($src)
$ms = New-Object System.IO.MemoryStream(,$bytes)
$bmp = [System.Drawing.Bitmap]::FromStream($ms)

$outBmp = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($outBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

[System.Drawing.PointF[]]$polyPts = @(
    [System.Drawing.PointF]::new(38.0, 260.0),
    [System.Drawing.PointF]::new(46.0, 215.0),
    [System.Drawing.PointF]::new(58.0, 155.0),
    [System.Drawing.PointF]::new(75.0, 110.0),
    [System.Drawing.PointF]::new(92.0, 92.0),     # spoiler tip
    [System.Drawing.PointF]::new(115.0, 88.0),
    [System.Drawing.PointF]::new(180.0, 72.0),
    [System.Drawing.PointF]::new(260.0, 58.0),
    [System.Drawing.PointF]::new(330.0, 48.0),    # top of windshield
    [System.Drawing.PointF]::new(400.0, 85.0),
    [System.Drawing.PointF]::new(470.0, 125.0),   # base of windshield
    [System.Drawing.PointF]::new(540.0, 160.0),   # hood curve
    [System.Drawing.PointF]::new(620.0, 195.0),   # headlight
    [System.Drawing.PointF]::new(680.0, 220.0),
    [System.Drawing.PointF]::new(735.0, 245.0),
    [System.Drawing.PointF]::new(770.0, 275.0),   # front bumper curve
    [System.Drawing.PointF]::new(785.0, 310.0),   # front nose extreme right
    [System.Drawing.PointF]::new(782.0, 335.0),   # front lower splitter tip
    [System.Drawing.PointF]::new(740.0, 350.0),   # lower front lip
    [System.Drawing.PointF]::new(665.0, 350.0),
    [System.Drawing.PointF]::new(650.0, 330.0),
    [System.Drawing.PointF]::new(635.0, 355.0),   # front tire front edge
    [System.Drawing.PointF]::new(615.0, 375.0),
    [System.Drawing.PointF]::new(565.0, 380.0),   # bottom of front tire
    [System.Drawing.PointF]::new(525.0, 368.0),   # rear of front tire
    [System.Drawing.PointF]::new(515.0, 325.0),   # bottom skirt connection
    [System.Drawing.PointF]::new(450.0, 318.0),   # side skirt line
    [System.Drawing.PointF]::new(350.0, 308.0),
    [System.Drawing.PointF]::new(250.0, 300.0),
    [System.Drawing.PointF]::new(185.0, 292.0),
    [System.Drawing.PointF]::new(178.0, 320.0),   # rear wheel arch
    [System.Drawing.PointF]::new(158.0, 338.0),
    [System.Drawing.PointF]::new(115.0, 336.0),   # bottom of rear tire
    [System.Drawing.PointF]::new(75.0, 318.0),    # rear tire rear edge
    [System.Drawing.PointF]::new(55.0, 280.0)     # lower rear bumper
)

$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddPolygon($polyPts)

$g.SetClip($path)
$g.DrawImage($bmp, 0, 0, $bmp.Width, $bmp.Height)
$g.ResetClip()

$path.Dispose()
$g.Dispose()

$outBmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
$outBmp.Dispose()
$bmp.Dispose()
$ms.Dispose()

Write-Output "Full nose Agya cutout generated!"
