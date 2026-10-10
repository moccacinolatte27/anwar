Add-Type -AssemblyName System.Drawing

$src = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\agya-crop.jpg"
$bmp = [System.Drawing.Bitmap]::FromFile($src)
Write-Output "agya-crop: $($bmp.Width) x $($bmp.Height)"
$bmp.Dispose()
