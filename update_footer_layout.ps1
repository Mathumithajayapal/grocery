$files = Get-ChildItem -Filter *.html

$newFooter = @"
    <footer class="bg-gray-900 text-white pt-16 pb-8 border-t-4 border-brand">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">
                
                <!-- Brand Info -->
                <div>
                    <a href="index.html" class="flex items-center gap-2 text-2xl font-bold text-brand mb-4">
                        <i class="fas fa-shopping-basket"></i>
                        <span>ElderBasket</span>
                    </a>
                    <p class="text-gray-400 text-base leading-relaxed mb-6">
                        Providing safe, reliable, and friendly grocery delivery services to ensure the senior members of our community are well cared for.
                    </p>
                    <div class="flex gap-4">
                        <a href="#" class="w-10 h-10 rounded-full bg-gray-800 flex items-center justify-center hover:bg-brand transition-colors"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="w-10 h-10 rounded-full bg-gray-800 flex items-center justify-center hover:bg-brand transition-colors"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="w-10 h-10 rounded-full bg-gray-800 flex items-center justify-center hover:bg-brand transition-colors"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>

                <!-- Quick Links & Resources -->
                <div>
                    <h4 class="text-lg font-bold mb-4 border-b-2 border-brand pb-2 inline-block">Explore</h4>
                    <ul class="space-y-3 text-gray-400">
                        <li><a href="about.html" class="hover:text-brand-light transition-colors"><i class="fas fa-angle-right mr-2"></i>About Us</a></li>
                        <li><a href="service.html" class="hover:text-brand-light transition-colors"><i class="fas fa-angle-right mr-2"></i>Our Services</a></li>
                        <li><a href="faq.html" class="hover:text-brand-light transition-colors"><i class="fas fa-angle-right mr-2"></i>FAQ & Support</a></li>
                        <li><a href="blog.html" class="hover:text-brand-light transition-colors"><i class="fas fa-angle-right mr-2"></i>Senior Health Blog</a></li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div>
                    <h4 class="text-lg font-bold mb-4 border-b-2 border-brand pb-2 inline-block">Contact</h4>
                    <ul class="space-y-4 text-gray-400">
                        <li class="flex items-start gap-3">
                            <i class="fas fa-map-marker-alt mt-1 text-brand"></i>
                            <span>456 Senior Care Blvd, Austin, TX 78701</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fas fa-phone mt-1 text-brand"></i>
                            <span>(800) 555-0199</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fas fa-envelope mt-1 text-brand"></i>
                            <span>hello@elderbasket.com</span>
                        </li>
                    </ul>
                </div>

                <!-- Newsletter -->
                <div>
                    <h4 class="text-lg font-bold mb-4 border-b-2 border-brand pb-2 inline-block">Newsletter</h4>
                    <p class="text-gray-400 text-sm mb-4">Subscribe for weekly fresh deals, seasonal produce updates, and senior health tips.</p>
                    <form class="flex flex-col gap-3">
                        <input type="email" placeholder="Enter your email address" class="w-full px-4 py-3 rounded-lg bg-gray-800 border border-gray-700 text-white focus:outline-none focus:border-brand transition-colors" required>
                        <button type="button" class="w-full bg-brand text-white font-bold py-3 rounded-lg hover:bg-brand-dark transition-colors flex justify-center items-center gap-2">
                            <span>Subscribe</span> <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>

            <!-- Bottom Copyright -->
            <div class="border-t border-gray-800 pt-8 text-center text-gray-500 text-sm flex flex-col md:flex-row justify-between items-center">
                <p>&copy; 2024 ElderBasket. All rights reserved.</p>
                <div class="flex gap-4 mt-4 md:mt-0 text-gray-400">
                    <a href="#" class="hover:text-white transition-colors">Privacy Policy</a>
                    <span>|</span>
                    <a href="#" class="hover:text-white transition-colors">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>
"@

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    
    # regex to match from <footer class="bg-gray-900... to </footer>
    if ($content -match '(?s)<footer class="bg-gray-900 text-white pt-16 pb-8 border-t-4 border-brand">.*?</footer>') {
        $content = $content -replace '(?s)<footer class="bg-gray-900 text-white pt-16 pb-8 border-t-4 border-brand">.*?</footer>', $newFooter
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
        Write-Host "Updated footer layout in $($f.Name)"
    }
}
