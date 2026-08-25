$files = Get-ChildItem -Filter *.html

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    # Replace header text-brand-dark with text-brand and remove text-brand from icon
    $content = $content -replace 'text-2xl font-bold text-brand-dark', 'text-2xl font-bold text-brand'
    $content = $content -replace '<i class="fas fa-shopping-basket text-brand"></i>', '<i class="fas fa-shopping-basket"></i>'
    
    # Replace footer text-brand-light with text-brand
    $content = $content -replace 'text-2xl font-bold text-brand-light mb-4', 'text-2xl font-bold text-brand mb-4'
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
    Write-Host "Updated "
}
