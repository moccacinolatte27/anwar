$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")

$urls = @(
    @{ name = "seva-black"; url = "https://images.prod.seva.id/Toyota/New Kijang Innova/main_color/main_banner_toyota_new_innova_attitude_black.png" },
    @{ name = "royal-new-innova"; url = "https://royaltrans.id/wp-content/uploads/2021/01/New-Innova.png" },
    @{ name = "kibris-innova"; url = "https://cdn.kibrispdr.org/data/668/innova-reborn-png-31.png" }
)

foreach ($u in $urls) {
    try {
        $out = "assets/reborn-$($u.name).png"
        Write-Host "Downloading $($u.name)..."
        $wc.DownloadFile($u.url, $out)
        $fi = Get-Item $out
        Write-Host "Success: $out ($($fi.Length) bytes)"
    } catch {
        Write-Host "Failed $($u.name): $_"
    }
}
