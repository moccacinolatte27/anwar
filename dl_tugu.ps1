$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

$urls = @(
    @{ name = "tugu-blogger"; url = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjwrfCjGaS0_qcdE-n8TFmUCBgAAhuMwNfVQtyHd9-quxfb40BADt83itUxGCp2BGFsYz-2K5kxaMMxhIV2pRvIG5SFaFKS5lj_6N9fQ76bDTK1lpPG_4fsKfLVYQY5o-0IvUsJ4V_PilSKNPQd4sk07Qyk0mgrKqUcYNypQRohu3lecsCxpPYhP0dWvFsl/s4254/Tugu_Yogyakarta_di_Siang_Hari.jpg" },
    @{ name = "tugu-travel"; url = "https://travelspromo.com/wp-content/uploads/2019/12/Tugu-Jogja-Simbol-Kota-Jogja-Meltyan-Photography.jpg" }
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
