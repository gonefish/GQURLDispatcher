Pod::Spec.new do |s|
  s.name         = "GQURLDispatcher"
  s.version      = "0.4.3"
  s.summary      = "A simple and flexible dispatch action framework based URL for iOS"

  s.description  = <<-DESC
                   GQURLDispatcher是一个简单且灵活的，基于URL的动作分发框架。通过URL和正则表达式来进行响应者Responer的匹配及调用，响应者Responer通常是View Controller的操作或者某个特定的方法，但不限于此。
                   DESC

  s.homepage     = "https://github.com/gonefish/GQURLDispatcher"
  s.license      = "MIT"
  s.author             = { "Q.GuoQiang" => "gonefish@gmail.com" }
  s.social_media_url   = "https://github.com/gonefish"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/gonefish/GQURLDispatcher.git", :tag => s.version.to_s }
  s.source_files  = "GQURLDispatcher/*.{h,m}"
  s.requires_arc = true

end
