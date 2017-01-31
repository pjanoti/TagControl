#
#  Be sure to run `pod spec lint TagControl.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TagControl"
  s.version      = "0.0.1"
  s.summary      = "It is a custom tag view. It can add and delete tags from view."
  s.description  = "It is a custom tag view. It can add and delete tags from view. you can set the different properties of TagControl like `backGroundColor`, `separatorView.backGroundColor etc if you need to customize it otherwise it will take default values."

  s.homepage     = "https://github.com/pjanoti/TagControl"
  #s.screenshot   = "https://github.com/pjanoti/TagControl/img.png"

  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  
  s.author             = { "pjanoti@altimetrik.com" => "pjanoti@altimetrik.com" }

  s.platform     = :ios
  s.ios.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/pjanoti/TagControl.git", :branch => "master", :tag => s.version }

  #  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.source_files = "Classes/**/*.{swift}"
  
  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "img.png"
  # s.resources = "Resources/*.png"
   s.resources = "Classes/**/*.{xib}"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
   s.frameworks  = "Foundation", "UIKit"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
