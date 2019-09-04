Pod::Spec.new do |s|

  s.name         = "YSColorPicker"
  s.version      = "1.1"
  s.summary      = "YSColorPicker."
  s.homepage     = "https://github.com/sekies/YSColorPicker"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Yosuke Seki" => "y.sekies@gmail.com" }
  s.source       = { :git => "https://github.com/sekies/YSColorPicker.git", :tag => "#{s.version}" }
  s.platform     = :ios, '10.0'
  s.source_files  = "YSColorPicker/**/*.{h,m,swift}"
  s.swift_versions = "5"

end
