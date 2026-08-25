$files = Get-ChildItem -Filter *.html

$oldStyle = @'
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
'@

$newStyle = @'
<style>
  html.dark { color-scheme: dark; }
  html.dark body { background-color: #111827 !important; color: #e5e7eb !important; }
  
  /* Backgrounds */
  html.dark .bg-white, html.dark .bg-gray-50 { background-color: #1f2937 !important; }
  html.dark .bg-gray-100, html.dark .bg-gray-200 { background-color: #374151 !important; }
  html.dark .bg-brand-light { background-color: rgba(22, 163, 74, 0.15) !important; border-color: rgba(22, 163, 74, 0.3) !important; }
  html.dark .hover\:bg-brand-light:hover { background-color: rgba(22, 163, 74, 0.25) !important; }
  html.dark .bg-yellow-100 { background-color: rgba(234, 179, 8, 0.15) !important; }
  html.dark .bg-blue-100 { background-color: rgba(59, 130, 246, 0.15) !important; }
  html.dark .bg-red-100 { background-color: rgba(239, 68, 68, 0.15) !important; }

  /* Texts */
  html.dark .text-gray-900, html.dark .text-gray-800, html.dark .text-gray-700 { color: #f3f4f6 !important; }
  html.dark .text-gray-600 { color: #d1d5db !important; }
  html.dark .text-gray-500, html.dark .text-gray-400 { color: #9ca3af !important; }
  html.dark .text-brand-dark { color: #4ade80 !important; }

  /* Borders */
  html.dark .border-gray-100 { border-color: #374151 !important; }
  html.dark .border-gray-200 { border-color: #4b5563 !important; }
  html.dark .border-gray-300 { border-color: #6b7280 !important; }
  html.dark .border-white { border-color: #1f2937 !important; }

  /* Shadows */
  html.dark .shadow-sm { box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.5) !important; }
  html.dark .shadow { box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.5), 0 1px 2px -1px rgba(0, 0, 0, 0.5) !important; }
  html.dark .shadow-md { box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5), 0 2px 4px -2px rgba(0, 0, 0, 0.5) !important; }
  html.dark .shadow-lg { box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5), 0 4px 6px -4px rgba(0, 0, 0, 0.5) !important; }
  html.dark .shadow-xl, html.dark .shadow-2xl { box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 8px 10px -6px rgba(0, 0, 0, 0.5) !important; }

  /* Specific Components */
  html.dark header, html.dark header.bg-white { background-color: #111827 !important; border-bottom: 1px solid #374151 !important; }
  html.dark footer { background-color: #111827 !important; border-top: 1px solid #374151 !important; }
  html.dark input, html.dark textarea, html.dark select { background-color: #374151 !important; color: #f3f4f6 !important; border-color: #4b5563 !important; }
</style>
'@

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    if ($content -match 'html\.dark header\.bg-white') {
        $content = $content.Replace($oldStyle, $newStyle)
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated "
    }
}
