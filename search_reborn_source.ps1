Add-Type -AssemblyName System.Web

# Let's search using keywords from the image: "Innova Reborn 2021 hitam" or similar marketplace listing
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

$queries = @(
    "innova reborn hitam 2021 olx",
    "innova reborn facelift hitam mobil123"
)

foreach ($q in $queries) {
    try {
        $encoded = [System.Web.HttpUtility]::UrlEncode($q)
        $search = "https://www.bing.com/images/search?q=" + $encoded + "&form=HDRSC2&first=1"
        $html = $wc.DownloadString($search)
        $m = [regex]::Matches($html, 'murl&quot;:&quot;(https?://[^&]+?\.(jpg|jpeg|png))&quot;')
        Write-Host "For $q, found $($m.Count) images"
    } catch {
        Write-Host "Error: $_"
    }
}
