#
#  Be sure to run `pod spec lint XWZNumberBoxView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "XWZNumberBoxView"
  s.version      = "0.0.1"
  s.summary      = "A easy way of making character box view."
  # s.description  = <<-DESC

  s.homepage     = "http://EXAMPLE/XWZNumberBoxView"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Boat" => "xinyiheng518@163.com" }

  # s.platform     = :ios
  s.platform     = :ios, "6.0"
  s.source       = { :git => "http://github.com/XWZNumberBoxView.git", :tag => "{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  # s.resource     = 'resources/XWZNumberBoxView.bundle'
  s.requires_arc = true

end
