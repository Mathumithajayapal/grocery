$files = Get-ChildItem -Filter *.html

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
    
    if ($content -match 'navThemeToggle' -and $content -notmatch 'Global Toggles Script') {
        $content = $content -replace '</body>', $scriptHtml
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Injected script into "
    }
}
