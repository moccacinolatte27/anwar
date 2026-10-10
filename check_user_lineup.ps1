Add-Type -AssemblyName System.Drawing
$ref = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791345057893.png")

Write-Output "Size: $($ref.Width)x$($ref.Height)"

# Let's save a copy to assets if needed
$ref.Save("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\ref_user_lineup.png")
$ref.Dispose()
Write-Output "Saved ref copy"
