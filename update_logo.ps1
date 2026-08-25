$files = Get-ChildItem -Filter *.html

$oldHeaderLogo = @'
                <a href="index.html" class="flex items-center gap-2 text-2xl font-bold text-brand-dark">
                    <i class="fas fa-shopping-basket text-brand"></i>
                    <span>ElderBasket</span>
                </a>
'@

$newHeaderLogo = @'
                <a href="index.html" class="flex items-center gap-2 text-2xl font-bold text-brand">
                    <i class="fas fa-shopping-basket"></i>
                    <span>ElderBasket</span>
                </a>
'@

$oldFooterLogo = @'
                    <a href="index.html" class="flex items-center gap-2 text-2xl font-bold text-brand-light mb-4">
                        <i class="fas fa-shopping-basket"></i>
                        <span>ElderBasket</span>
                    </a>
'@

$newFooterLogo = @'
                    <a href="index.html" class="flex items-center gap-2 text-2xl font-bold text-brand mb-4">
                        <i class="fas fa-shopping-basket"></i>
                        <span>ElderBasket</span>
                    </a>
'@

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    $modified = $false
    
    if ($content -match [regex]::Escape($oldHeaderLogo)) {
        $content = $content.Replace($oldHeaderLogo, $newHeaderLogo)
        $modified = $true
    }
    
    if ($content -match [regex]::Escape($oldFooterLogo)) {
        $content = $content.Replace($oldFooterLogo, $newFooterLogo)
        $modified = $true
    }
    
    if ($modified) {
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated logo in "
    }
}
