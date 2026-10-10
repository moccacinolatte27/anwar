Add-Type -AssemblyName System.Drawing
$ref = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791345057893.png")
Write-Output "Ref Image: $($ref.Width) x $($ref.Height)"

# Sample colors at key car positions
# Hiace (left, x=100..200, y=100..250)
# Avanza (center, x=450..550, y=150..300)
# Reborn (right, x=700..800, y=120..260)
$ref.Dispose()
