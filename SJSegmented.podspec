#
# Be sure to run `pod lib lint SJSegmented.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SJSegmented'
  s.version          = '0.1.0'
  s.summary          = 'Simple segmented control with basic customization'

  s.description      = <<-DESC
  Simple segmented control with basic customization for font, colors and easy to use.
                       DESC

  s.homepage         = 'https://github.com/dimacheverda/SJSegmented'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dmytro Cheverda' => 'cheverda@sjinnovation.com' }
  s.source           = { :git => 'https://github.com/dimacheverda/SJSegmented.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/cheverda'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  
  s.source_files = 'SJSegmented/Classes/**/*'
  s.frameworks = 'UIKit'

end
