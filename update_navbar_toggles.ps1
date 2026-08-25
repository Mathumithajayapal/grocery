$files = Get-ChildItem -Filter *.html

$oldTogglesHtml = @'
                    <button onclick="toggleDarkMode()" class="w-10 h-10 rounded-full flex items-center justify-center border-2 border-gray-200 text-gray-600 hover:text-brand hover:border-brand transition-colors focus:outline-none dark:border-gray-600 dark:text-gray-300 dark:hover:text-brand" id="navThemeToggle" title="Toggle Dark Mode">
                        <i class="fas fa-moon"></i>
                    </button>
                    <button onclick="toggleRTL()" class="w-10 h-10 rounded-full flex items-center justify-center border-2 border-gray-200 text-gray-600 hover:text-brand hover:border-brand transition-colors focus:outline-none font-bold text-sm dark:border-gray-600 dark:text-gray-300 dark:hover:text-brand" id="navRtlToggle" title="Toggle RTL">
                        EN
                    </button>
'@

$newTogglesHtml = @'
                    <button onclick="toggleDarkMode()" class="w-10 h-10 rounded-full flex items-center justify-center bg-white border-2 border-black text-brand hover:bg-gray-100 transition-colors focus:outline-none dark:bg-gray-800 dark:border-gray-600 dark:text-brand shadow-sm" id="navThemeToggle" title="Toggle Dark Mode">
                        <i class="fas fa-moon text-lg"></i>
                    </button>
                    <button onclick="toggleRTL()" class="w-10 h-10 rounded-full flex items-center justify-center bg-white border-2 border-black text-brand hover:bg-gray-100 transition-colors focus:outline-none font-bold text-sm dark:bg-gray-800 dark:border-gray-600 dark:text-brand shadow-sm" id="navRtlToggle" title="Toggle RTL">
                        EN
                    </button>
'@

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    if ($content -match 'navThemeToggle') {
        $content = $content.Replace($oldTogglesHtml, $newTogglesHtml)
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated "
    }
}
