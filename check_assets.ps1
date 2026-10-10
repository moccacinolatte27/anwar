Add-Type -AssemblyName System.Drawing

function CheckBmp($path) {
    if (Test-Path $path) {
        $bmp = [System.Drawing.Bitmap]::FromFile($path)
        Write-Output "$((Get-Item $path).Name) : $($bmp.Width)x$($bmp.Height)"
        $bmp.Dispose()
    }
}

Get-ChildItem "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets" -Filter "*agya*" | ForEach-Object { CheckBmp $_.FullName }
Get-ChildItem "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets" -Filter "*reborn*" | ForEach-Object { CheckBmp $_.FullName }
