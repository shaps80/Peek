Pod::Spec.new do |s|
  s.name             = "Peek"
  s.version          = "2.0.1"
  s.summary          = "Take a Peek at your application."
  s.homepage         = "http://shaps.me/blog/peek-2/"
  s.screenshots      = "http://shaps.me/assets/img/blog/peek.png"
  s.license          = 'MIT'
  s.author           = { "Shaps Mohsenin" => "shapsuk@me.com" }
  s.source           = { :git => "https://github.com/shaps80/Peek.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.platform         = :ios, '8.2'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*'
  s.dependency         'SwiftLayout'
  s.dependency         'InkKit'
end
