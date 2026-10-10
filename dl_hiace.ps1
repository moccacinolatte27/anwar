[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://toyotaastrido.co.id/wp-content/uploads/2019/07/toyota-hiace-premio-2020.png"
$output = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets\hero-hiace.png"

try {
    Invoke-WebRequest -Uri $url -OutFile $output -UserAgent "Mozilla/5.0" -TimeoutSec 15
    Write-Output "Downloaded Hiace PNG successfully!"
} catch {
    Write-Output "Download failed: $_"
}
