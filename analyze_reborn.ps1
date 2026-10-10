Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Image]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")
Write-Host "Reborn Dimensions: $($img.Width) x $($img.Height)"
$img.Dispose()
