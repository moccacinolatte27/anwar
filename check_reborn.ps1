Add-Type -AssemblyName System.Drawing

$src = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\innova_reborn_tugu_jogja_1791344715443.jpg"
$bmp = [System.Drawing.Bitmap]::FromFile($src)
Write-Output "Dimensions: $($bmp.Width) x $($bmp.Height)"
$bmp.Dispose()
