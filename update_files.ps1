$files = Get-ChildItem -Filter *.html

$togglesHtml = @'
<!-- Actions / Login -->
                <div class="hidden xl:flex items-center gap-4">
                    <!-- Toggles -->
                    <button onclick="toggleDarkMode()" class="w-10 h-10 rounded-full flex items-center justify-center border-2 border-gray-200 text-gray-600 hover:text-brand hover:border-brand transition-colors focus:outline-none dark:border-gray-600 dark:text-gray-300 dark:hover:text-brand" id="navThemeToggle" title="Toggle Dark Mode">
                        <i class="fas fa-moon"></i>
                    </button>
                    <button onclick="toggleRTL()" class="w-10 h-10 rounded-full flex items-center justify-center border-2 border-gray-200 text-gray-600 hover:text-brand hover:border-brand transition-colors focus:outline-none font-bold text-sm dark:border-gray-600 dark:text-gray-300 dark:hover:text-brand" id="navRtlToggle" title="Toggle RTL">
                        EN
                    </button>
'@

$scriptHtml = @'
<!-- Global Toggles Script & Styles -->
<style>
  html.dark body { background-color: #111827 !important; color: #f3f4f6 !important; }
  html.dark .bg-white { background-color: #1f2937 !important; }
  html.dark .bg-gray-50 { background-color: #111827 !important; }
  html.dark .bg-gray-100 { background-color: #374151 !important; }
  html.dark .text-gray-800 { color: #f3f4f6 !important; }
  html.dark .text-gray-700 { color: #e5e7eb !important; }
  html.dark .text-gray-600 { color: #9ca3af !important; }
  html.dark .text-gray-500 { color: #9ca3af !important; }
  html.dark .border-gray-200 { border-color: #374151 !important; }
  html.dark .border-gray-100 { border-color: #1f2937 !important; }
  html.dark header.bg-white { background-color: #1f2937 !important; }
</style>
<script>
  function toggleDarkMode() {
    document.documentElement.classList.toggle("dark");
    const icon = document.querySelector("#navThemeToggle i");
    if (icon) {
      if (document.documentElement.classList.contains("dark")) {
        icon.className = "fas fa-sun";
      } else {
        icon.className = "fas fa-moon";
      }
    }
  }

  function toggleRTL() {
    const html = document.documentElement;
    const currentDir = html.getAttribute("dir") || "ltr";
    const newDir = currentDir === "rtl" ? "ltr" : "rtl";
    html.setAttribute("dir", newDir);
    
    const btn = document.querySelector("#navRtlToggle");
    if (btn) {
      if (newDir === "rtl") {
        btn.innerText = "LTR";
      } else {
        btn.innerText = "RTL";
      }
    }
  }
</script>
</body>
'@

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    if ($content -match '(?s)<!-- Actions / Login -->\s*<div class="hidden xl:flex items-center gap-4">') {
        $content = $content -replace '(?s)<!-- Actions / Login -->\s*<div class="hidden xl:flex items-center gap-4">', $togglesHtml
        
        if ($content -notmatch 'toggleDarkMode\(\)') {
            $content = $content -replace '</body>', $scriptHtml
        }
        
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated "
    }
}
