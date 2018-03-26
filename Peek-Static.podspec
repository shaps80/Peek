Pod::Spec.new do |s|
  s.name             = "Peek-Static"
  s.version          = "5.0.0"
  s.summary          = "All new design. Inspect your iOS application at runtime."
  s.homepage         = "https://shaps.me/peek"
  s.screenshots      = "https://github.com/shaps80/Peek/raw/master/shot.jpg"
  s.license          = 'MIT'
  s.author           = { "Shaps Mohsenin" => "shapsuk@me.com" }
  s.source           = { :git => "https://github.com/shaps80/Peek.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*.{swift,h,m}'
  s.static_framework = true
end
