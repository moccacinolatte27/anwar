$cars = @(
    'honda-brio-rs.jpg',
    'toyota-agya.jpg',
    'toyota-avanza-2016.jpg',
    'toyota-avanza.jpg',
    'toyota-rush.jpg',
    'toyota-innova-reborn.jpg',
    'toyota-innova-zenix.jpg',
    'mitsubishi-pajero-sport.jpg',
    'toyota-fortuner.jpg',
    'toyota-alphard.jpg',
    'toyota-hiace-premio.jpg'
)

foreach ($c in $cars) {
    $path = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\$c"
    if (Test-Path $path) {
        $item = Get-Item $path
        Write-Output "$c : $($item.Length) bytes, $($item.LastWriteTime)"
    }
}
