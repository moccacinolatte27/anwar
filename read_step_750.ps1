$lines = Get-Content 'C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.system_generated\logs\transcript.jsonl'
for ($i = 750; $i -lt 850; $i++) {
    if ($i -lt $lines.Count) {
        $l = $lines[$i]
        if ($l.Contains("heroTab") -or $l.Contains("hero-car") -or $l.Contains("hero-lineup") -or $l.Contains("setHeroCar")) {
            Write-Output "Line $i :"
            $obj = $l | ConvertFrom-Json
            Write-Output $obj.content
        }
    }
}
