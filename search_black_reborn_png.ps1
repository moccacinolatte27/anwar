Add-Type -AssemblyName System.Web

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36")

$queries = @(
    "Innova Reborn hitam PNG transparent",
    "Toyota Innova Reborn facelift hitam png transparan",
    "Innova Reborn black png transparent auto2000"
)

foreach ($q in $queries) {
    try {
        $encoded = [System.Web.HttpUtility]::UrlEncode($q)
        $search = "https://www.bing.com/images/search?q=" + $encoded + "&qft=+filterui:photo-transparent&form=IRFLTR&first=1"
        $html = $wc.DownloadString($search)
        $m = [regex]::Matches($html, 'murl&quot;:&quot;(https?://[^&]+?\.(png|PNG))&quot;')
        Write-Host "For $q, found $($m.Count) PNGs:"
        foreach ($match in $m | Select-Object -First 4) {
            Write-Host "   -> $($match.Groups[1].Value)"
        }
    } catch {
        Write-Host "Error: $_"
    }
}
