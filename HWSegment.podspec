#
# Be sure to run `pod lib lint HWSegment.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HWSegment'
  s.version          = '0.1.0'
  s.summary          = '选项卡'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '分为选项卡视图和选项卡容器控制器，可拆分单独使用'

  s.homepage         = 'https://github.com/RedGerrard/HWSegment'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RedGerrard' => '417705652@qq.com' }
  s.source           = { :git => 'https://github.com/RedGerrard/HWSegment.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HWSegment/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HWSegment' => ['HWSegment/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
