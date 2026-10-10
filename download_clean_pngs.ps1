$urls = @(
  @{ name = "hiace"; url = "https://imgcdn.oto.com/large/gallery/color/38/2006/toyota-hiace-premio-color-411252.png" },
  @{ name = "avanza"; url = "https://imgcdn.oto.com/large/gallery/color/38/2042/toyota-all-new-avanza-color-295493.png" },
  @{ name = "agya"; url = "https://imgcdn.oto.com/large/gallery/color/38/2180/toyota-agya-color-790119.png" },
  @{ name = "reborn"; url = "https://imgcdn.oto.com/large/gallery/color/38/1836/toyota-innova-color-748981.png" }
)

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")

foreach ($item in $urls) {
  $target = "assets/clean-png-$($item.name).png"
  try {
    Write-Host "Downloading $($item.name) from $($item.url)..."
    $wc.DownloadFile($item.url, $target)
    $fi = Get-Item $target
    Write-Host "Success: $($target) ($($fi.Length) bytes)"
  } catch {
    Write-Host "Error downloading $($item.name): $_"
  }
}
