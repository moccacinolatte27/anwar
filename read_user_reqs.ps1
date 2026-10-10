$lines = Get-Content 'C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9\.system_generated\logs\transcript.jsonl'
foreach ($line in $lines) {
    if ($line.Contains('"USER_INPUT"')) {
        Write-Output "--- USER INPUT ---"
        Write-Output $line
    }
}
