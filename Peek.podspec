Pod::Spec.new do |s|
  s.name             = "Peek"
  s.version          = "4.0.1"
  s.summary          = "Take a Peek at your application. App inspection at runtime."
  s.homepage         = "https://152percent.com/blog/2016/4/14/introducing-peek-20"
  s.screenshots      = "https://github.com/shaps80/Peek/raw/swift4/shot.jpg"
  s.license          = 'MIT'
  s.author           = { "Shaps Mohsenin" => "shapsuk@me.com" }
  s.source           = { :git => "https://github.com/shaps80/Peek.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*.{swift,h,m}'
  s.dependency         'GraphicsRenderer', '1.2.0'
end
