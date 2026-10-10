Add-Type -AssemblyName System.Drawing

$files = @('dl-agya-1.png', 'reborn-seva-black.png', 'dl-hiace-1.png', 'dl-hiace-2.png', 'dl-avanza-1.png', 'agya-full-body-cutout.png')
foreach ($f in $files) {
    $p = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\" + $f
    if (Test-Path $p) {
        $bmp = [System.Drawing.Bitmap]::FromFile($p)
        Write-Output "$f : $($bmp.Width)x$($bmp.Height)"
        $bmp.Dispose()
    }
}
