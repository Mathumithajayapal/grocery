$files = Get-ChildItem -Filter *.html

$faviconTag = "    <link rel=`"icon`" type=`"image/svg+xml`" href=`"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🛒</text></svg>`">"

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    if ($content -notmatch '<link rel="icon"') {
        $content = $content -replace '(?i)(</title>)', "`${1}`r`n$faviconTag"
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Added favicon to $($f.Name)"
    }
}
