$brainDir = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9"
$assetsDir = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets"

Write-Output "--- ASSETS CARS ---"
Get-ChildItem $assetsDir -Filter "*.jpg" | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize

Write-Output "--- BRAIN CARS ---"
Get-ChildItem $brainDir -Filter "*.jpg" | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
