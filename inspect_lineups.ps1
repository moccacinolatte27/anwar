Add-Type -AssemblyName System.Drawing

$img1 = [System.Drawing.Bitmap]::FromFile("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-lineup-ref.png")
Write-Output "hero-lineup-ref: $($img1.Width)x$($img1.Height)"
$img1.Dispose()

$img2 = [System.Drawing.Bitmap]::FromFile("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-lineup-anza.png")
Write-Output "hero-lineup-anza: $($img2.Width)x$($img2.Height)"
$img2.Dispose()

$img3 = [System.Drawing.Bitmap]::FromFile("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-fleet-lineup.png")
Write-Output "hero-fleet-lineup: $($img3.Width)x$($img3.Height)"
$img3.Dispose()
