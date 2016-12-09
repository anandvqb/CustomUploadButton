#
# Be sure to run `pod lib lint CustomUploadButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CustomUploadButton'
  s.version          = '0.1.0'
  s.summary          = 'Custom upload button based on design from UIMovement.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a cocoapod for creating a custom upload button based on a design from UIMovement (https://uimovement.com/ui/2472/upload-button/).
                       DESC

  s.homepage         = 'https://github.com/anandvqb/CustomUploadButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'anandvqb' => 'anandv@qburst.com' }
  s.source           = { :git => 'https://github.com/anandvqb/CustomUploadButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CustomUploadButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CustomUploadButton' => ['CustomUploadButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
