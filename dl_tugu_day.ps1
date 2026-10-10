$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

$urls = @(
    @{ name = "tugu-kompas"; url = "https://asset.kompas.com/crops/OMWdPdZFS8UpJpupQdojw_07ixk=/0x0:1000x667/1200x800/data/photo/2020/03/10/5e677a1b83e8d.jpg" },
    @{ name = "tugu-wp"; url = "https://wallpapercave.com/wp/wp5036471.jpg" }
)

foreach ($u in $urls) {
    try {
        $out = "assets/$($u.name).jpg"
        Write-Host "Downloading $($u.name)..."
        $wc.DownloadFile($u.url, $out)
        $fi = Get-Item $out
        Write-Host "Downloaded: $out ($($fi.Length) bytes)"
    } catch {
        Write-Host "Failed: $($u.name) - $_"
    }
}
