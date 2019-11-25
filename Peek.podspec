Pod::Spec.new do |s|
  s.name             = "Peek"
  s.version          = "5.3.0"
  s.swift_versions   = ['5.1']
  s.summary          = "All new design. Inspect your iOS application at runtime."
  s.homepage         = "https://152percent.com/peek"
  s.screenshots      = "https://images.squarespace-cdn.com/content/v1/58d1c3c1b3db2b27db51464f/1521730411276-S3UCD05HTDG34PWBGM4N/ke17ZwdGBToddI8pDm48kEWP3-hvREnweJ050wvhyvB7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdrULnJwJtUwRUNy9fIMUJZw9x8WqpJ4rfPF_qYxQ1vxK19DM50qGfsFZg32uC5Iyw/Peek+Promo+%E2%80%93+No+Logo.jpg?format=2500w"
  s.license          = 'MIT'
  s.author           = { "Shaps Benkau" => "shapsuk@me.com" }
  s.source           = { :git => "https://github.com/shaps80/Peek.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*.{swift,h,m}'
end
