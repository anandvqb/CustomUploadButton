Pod::Spec.new do |s|
  s.name             = 'CustomUploadButton'
  s.version          = '0.1.0'
  s.summary          = 'Custom upload button based on design from UIMovement.'

  s.description      = 'This is a cocoapod for creating a custom upload button based on a design from UIMovement (https://uimovement.com/ui/2472/upload-button/).'

  s.homepage         = 'https://github.com/anandvqb/CustomUploadButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anand V' => 'anandv@qburst.com' }
  s.source           = { :git => 'https://github.com/anandvqb/CustomUploadButton.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'CustomUploadButton/Classes/**/*'
  s.resource_bundles = {
     'CustomUploadButton' => ['CustomUploadButton/Assets/**/*']
  }
  s.frameworks = 'UIKit'
end
