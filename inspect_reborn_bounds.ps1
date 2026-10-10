Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")
Write-Host "Width: $($bmp.Width), Height: $($bmp.Height)"

# In this 1024x768 image:
# The car occupies approximately:
# X from ~160 to ~780
# Y from ~220 to ~720 (tires touching ground at ~700-720)
# Top of windshield / roof: Y ~270
# Front bumper: Y ~700-710
# Left side mirror: X ~165, Y ~370
# Right headlight: X ~720-750, Y ~480-550

$bmp.Dispose()
