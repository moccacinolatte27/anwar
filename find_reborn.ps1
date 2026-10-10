Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem -Path "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\*.jpg", "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.tempmediaStorage\*.jpg"

foreach ($f in $files) {
    if ($f.Name -like "*reborn*" -or $f.Length -gt 800000) {
        Write-Output "$($f.FullName) - Size: $($f.Length)"
    }
}
