Add-Type -AssemblyName System.Drawing

$bg = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/tugu-wp.jpg")
Write-Host "Tugu WP: $($bg.Width) x $($bg.Height)"

# In tugu-wp.jpg (2560 x 1500 approx):
# Tugu peak is around Y ~150
# Tugu base with black-and-white curb is around Y ~1250-1350
# Wide stone pavement is at Y ~1200 to 1500 across the entire bottom!
# So if we place the car on the stone pavement at the bottom:
# Car top: Y ~900
# Car bottom: Y ~1420
# Car is on the paved ground, and the whole Tugu Jogja monument is majestically visible in the background!

$car = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/reborn-tight.png")
$out = New-Object System.Drawing.Bitmap($bg.Width, $bg.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($out)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Draw full Tugu WP background
$g.DrawImage($bg, 0, 0, $bg.Width, $bg.Height)

# Position car on the stone paving in foreground
# Desired car width = 1600 (out of 2560)
$carW = 1600
$carH = [int]($car.Height * ($carW / $car.Width))
$carX = [int](($bg.Width - $carW) / 2) - 50
$carY = $bg.Height - $carH - 60

# Add soft natural contact shadow
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 0, 0, 0))), ($carX + 100), ($bg.Height - 120), ($carW - 200), 65)

$g.DrawImage($car, $carX, $carY, $carW, $carH)

$g.Dispose()
$out.Save("$PSScriptRoot/assets/reborn-tugu-full.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)
$out.Dispose()
$bg.Dispose()
$car.Dispose()

Write-Host "Created reborn-tugu-full.jpg"
