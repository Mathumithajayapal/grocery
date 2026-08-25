$files = Get-ChildItem -Filter *.html

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    $modified = $false

    # Update FontAwesome to version 6.5.1 to support the X logo
    if ($content -match '6\.0\.0-beta3') {
        $content = $content -replace '6\.0\.0-beta3', '6.5.1'
        $modified = $true
    }

    # Replace Twitter classes with X classes
    if ($content -match 'fa-twitter') {
        # Both "fab fa-twitter" and just "fa-twitter" might exist
        $content = $content -replace 'fab fa-twitter', 'fa-brands fa-x-twitter'
        $content = $content -replace 'fa-twitter', 'fa-x-twitter'
        $modified = $true
    }

    if ($modified) {
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated Twitter to X in "
    }
}
