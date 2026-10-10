Add-Type -AssemblyName System.Drawing

$src = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg"
$bmp = [System.Drawing.Bitmap]::FromFile($src)
$rect = New-Object System.Drawing.Rectangle(490, 440, 200, 90)
$crop = $bmp.Clone($rect, $bmp.PixelFormat)
$crop.Save("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\headlamp_crop.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)
$crop.Dispose()
$bmp.Dispose()
Write-Output "Cropped headlamp saved"
