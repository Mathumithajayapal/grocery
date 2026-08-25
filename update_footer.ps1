$files = Get-ChildItem -Filter *.html

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    $modified = $false

    if ($content -match '123 Community Lane, Cityville, State 12345') {
        $content = $content -replace '123 Community Lane, Cityville, State 12345', '456 Senior Care Blvd, Austin, TX 78701'
        $modified = $true
    }

    if ($content -match '1-800-ELDER-BASKET') {
        $content = $content -replace '1-800-ELDER-BASKET', '(800) 555-0199'
        $modified = $true
    }

    if ($content -match '2026 ElderBasket') {
        $content = $content -replace '2026 ElderBasket', '2024 ElderBasket'
        $modified = $true
    }

    if ($modified) {
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated footer in "
    }
}
