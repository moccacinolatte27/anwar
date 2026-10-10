Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::FromFile("c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\reborn-seva-black.png")

# Count non-transparent pixels in 50x50 blocks
for ($y = 0; $y -lt $bmp.Height; $y += 100) {
    $row = ""
    for ($x = 0; $x -lt $bmp.Width; $x += 100) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.A -gt 30) { $row += "#" } else { $row += "." }
    }
    Write-Output $row
}
$bmp.Dispose()
