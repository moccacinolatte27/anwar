Add-Type -AssemblyName System.Web

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36")

$carsToSearch = @(
    @{ name = "brio"; q = "Honda Brio RS PNG transparent" },
    @{ name = "rush"; q = "Toyota Rush PNG transparent" },
    @{ name = "zenix"; q = "Toyota Innova Zenix PNG transparent" },
    @{ name = "pajero"; q = "Mitsubishi Pajero Sport PNG transparent" },
    @{ name = "fortuner"; q = "Toyota Fortuner GR PNG transparent" },
    @{ name = "alphard"; q = "Toyota Alphard PNG transparent" },
    @{ name = "avanza2016"; q = "Grand New Avanza 2016 PNG transparent" }
)

foreach ($c in $carsToSearch) {
    try {
        $encoded = [System.Web.HttpUtility]::UrlEncode($c.q)
        $search = "https://www.bing.com/images/search?q=" + $encoded + "&qft=+filterui:photo-transparent&form=IRFLTR&first=1"
        $html = $wc.DownloadString($search)
        $m = [regex]::Matches($html, 'murl&quot;:&quot;(https?://[^&]+?\.(png|PNG))&quot;')
        Write-Host "For $($c.name), found $($m.Count) PNGs:"
        foreach ($match in $m | Select-Object -First 2) {
            Write-Host "   -> $($match.Groups[1].Value)"
        }
    } catch {
        Write-Host "Error $($c.name): $_"
    }
}
