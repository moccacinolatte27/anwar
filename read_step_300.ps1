$lines = Get-Content 'C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.system_generated\logs\transcript.jsonl'
for ($i = 295; $i -lt 330; $i++) {
    if ($i -lt $lines.Count) {
        $l = $lines[$i]
        if ($l.Contains("media_1791345057893") -or $l.Contains("hero") -or $l.Contains("lineup")) {
            Write-Output "Line $i :"
            $obj = $l | ConvertFrom-Json
            Write-Output $obj.content
        }
    }
}
