Add-Type -AssemblyName System.Drawing

function CheckColor($file) {
    $path = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\" + $file
    if (Test-Path $path) {
        $bmp = [System.Drawing.Bitmap]::FromFile($path)
        $r=0; $g=0; $b=0; $cnt=0
        for ($x=0; $x -lt $bmp.Width; $x += 10) {
            for ($y=0; $y -lt $bmp.Height; $y += 10) {
                $c = $bmp.GetPixel($x, $y)
                if ($c.A -gt 150) {
                    $r += $c.R; $g += $c.G; $b += $c.B; $cnt++
                }
            }
        }
        if ($cnt -gt 0) {
            Write-Output "$file : R=$([int]($r/$cnt)), G=$([int]($g/$cnt)), B=$([int]($b/$cnt)) ($cnt pixels)"
        }
        $bmp.Dispose()
    }
}

CheckColor "dl-agya-1.png"
CheckColor "agya-full-body-cutout.png"
CheckColor "agya-kalla.png"
CheckColor "agya-pati.png"
CheckColor "reborn-seva-black.png"
CheckColor "dl-avanza-1.png"
CheckColor "hero-car-avanza.png"
CheckColor "dl-hiace-1.png"
CheckColor "dl-hiace-2.png"
