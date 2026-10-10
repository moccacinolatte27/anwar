Add-Type -AssemblyName System.Drawing

$tugu = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/assets/toyota-innova-reborn.jpg")
$userCar = [System.Drawing.Bitmap]::FromFile("C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.user_uploaded\media_1791354183988.jpg")

Write-Host "Tugu: $($tugu.Width)x$($tugu.Height)"
Write-Host "UserCar: $($userCar.Width)x$($userCar.Height)"

# In userCar (1024x768):
# Let's crop the car bounding box: X: 160 to 780, Y: 220 to 720
# Width = 620, Height = 500
$cropBmp = New-Object System.Drawing.Bitmap(640, 520)
$g = [System.Drawing.Graphics]::FromImage($cropBmp)
$g.DrawImage($userCar, 0, 0, (New-Object System.Drawing.Rectangle(150, 210, 640, 520)), [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$cropBmp.Save("$PSScriptRoot/assets/user-reborn-crop.png", [System.Drawing.Imaging.ImageFormat]::Png)
$cropBmp.Dispose()
$tugu.Dispose()
$userCar.Dispose()
Write-Host "Saved user-reborn-crop.png"
