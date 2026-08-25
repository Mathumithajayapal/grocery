$files = @("signin.html", "signup.html")
foreach ($f in $files) {
    $content = Get-Content $f -Raw
    
    $content = $content -replace 'border: 1px solid #e5e7eb;', 'border: 2px solid #000;'
    $content = $content -replace 'color: #111827;', 'color: var(--brand-primary);'
    
    # Optional: Update the dark mode icon to also be green
    $content = $content -replace 'color: #f3f4f6;', 'color: var(--brand-primary);'
    
    Set-Content -Path $f -Value $content -Encoding UTF8
    Write-Host "Updated $f"
}
