$files = @("user.html", "admin.html")

$oldCss = @'
            border: 1px solid var(--border-light);
            background: var(--card-bg);
            color: var(--text-muted);
'@

$newCss = @'
            border: 2px solid #000;
            background: #fff;
            color: var(--pool-primary);
'@

foreach ($f in $files) {
    if (Test-Path $f) {
        $content = Get-Content $f -Raw
        $content = $content.Replace($oldCss, $newCss)
        Set-Content -Path $f -Value $content -Encoding UTF8
        Write-Host "Updated $f"
    }
}
