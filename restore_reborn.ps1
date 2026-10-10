$src = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-innova-reborn.jpg"
$dst = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-innova-reborn.jpg"

Copy-Item $src $dst -Force

$item = Get-Item $dst
Write-Output "Restored toyota-innova-reborn.jpg: $($item.Length) bytes, LastWriteTime: $($item.LastWriteTime)"
