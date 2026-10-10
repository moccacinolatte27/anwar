Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::FromFile('C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791345057893.png')
Write-Output "Size: $($bmp.Width) x $($bmp.Height)"
$bmp.Dispose()
