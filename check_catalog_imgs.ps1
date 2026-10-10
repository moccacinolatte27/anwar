Add-Type -AssemblyName System.Drawing

function CheckImg($name, $file) {
    if (Test-Path $file) {
        $bmp = [System.Drawing.Bitmap]::FromFile($file)
        $r=0; $g=0; $b=0; $cnt=0
        for ($x=0; $x -lt $bmp.Width; $x += 20) {
            for ($y=0; $y -lt $bmp.Height; $y += 20) {
                $c = $bmp.GetPixel($x, $y)
                $r += $c.R; $g += $c.G; $b += $c.B; $cnt++
            }
        }
        Write-Output "$name ($($bmp.Width)x$($bmp.Height)) : Avg RGB ($([int]($r/$cnt)), $([int]($g/$cnt)), $([int]($b/$cnt)))"
        $bmp.Dispose()
    }
}

CheckImg "hero-innova-reborn.jpg" "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-innova-reborn.jpg"
CheckImg "toyota-innova-reborn.jpg" "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-innova-reborn.jpg"
CheckImg "toyota-agya.jpg" "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-agya.jpg"
CheckImg "honda-brio-rs.jpg" "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\honda-brio-rs.jpg"
CheckImg "toyota-avanza.jpg" "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\toyota-avanza.jpg"
