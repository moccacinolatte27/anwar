Add-Type -AssemblyName System.Web

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

$queries = @(
    "Tugu Yogyakarta siang hari landscape",
    "Tugu Jogja pedestrian plaza foto",
    "Tugu Pal Putih Yogyakarta siang hari wallpaper"
)

foreach ($q in $queries) {
    try {
        $encoded = [System.Web.HttpUtility]::UrlEncode($q)
        $search = "https://www.bing.com/images/search?q=" + $encoded + "&qft=+filterui:imagesize-large&form=IRFLTR&first=1"
        $html = $wc.DownloadString($search)
        $m = [regex]::Matches($html, 'murl&quot;:&quot;(https?://[^&]+?\.(jpg|jpeg|png))&quot;')
        Write-Host "For $q, found $($m.Count) images:"
        foreach ($match in $m | Select-Object -First 3) {
            Write-Host "   -> $($match.Groups[1].Value)"
        }
    } catch {
        Write-Host "Error: $_"
    }
}
