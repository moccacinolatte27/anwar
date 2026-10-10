Add-Type -AssemblyName System.Drawing
$ref = [System.Drawing.Bitmap]::FromFile("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-lineup-ref.png")
Write-Output "hero-lineup-ref: $($ref.Width) x $($ref.Height)"

# Let's crop 4 sections to see what each car is
# 1. Left car (Hiace)
# 2. Middle-right car (Reborn)
# 3. Middle-front car (Avanza)
$ref.Dispose()
