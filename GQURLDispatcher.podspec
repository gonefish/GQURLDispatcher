Pod::Spec.new do |s|
  s.name         = "GQURLDispatcher"
  s.version      = "0.1"
  s.summary      = "A simple and flexible dispatch action framework based URL for iOS"
  s.homepage     = "https://github.com/gonefish/GQURLDispatcher"
  s.license      = "MIT"
  s.author             = { "Q.GuoQiang" => "gonefish@gmail.com" }
  s.social_media_url   = "https://github.com/gonefish"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/gonefish/GQURLDispatcher.git", :tag => s.version.to_s }
  s.source_files  = "GQURLDispatcher/GQURLDispatcher/*.{h,m}"
  s.requires_arc = true

end
