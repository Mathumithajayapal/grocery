$files = Get-ChildItem -Filter *.html

$imageIndex = 1
$maxImages = 12

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    # We will use regex replacement with a MatchEvaluator to replace each unsplash URL with a different local image
    $regex = [regex] 'src="https://images\.unsplash\.com[^"]+"'
    
    $evaluator = [System.Text.RegularExpressions.MatchEvaluator] {
        param($match)
        $replacement = 'src="Images/grocery (' + $imageIndex + ').jpg"'
        
        # Increment and wrap around
        $script:imageIndex++
        if ($script:imageIndex -gt $script:maxImages) {
            $script:imageIndex = 1
        }
        
        return $replacement
    }
    
    $newContent = $regex.Replace($content, $evaluator)
    
    if ($content -ne $newContent) {
        Set-Content -Path $f.FullName -Value $newContent -Encoding UTF8
        Write-Host "Updated images in "
    }
}
