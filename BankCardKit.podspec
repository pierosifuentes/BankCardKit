#
# Be sure to run `pod lib lint BankCardKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BankCardKit'
  s.version          = '0.1.0'
  s.summary          = 'Credit and Debit Card framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
BankCardKit is an iOS framework which gives the right tools for handle work with Debit and Credit Bank Cards safety.
                       DESC

  s.homepage         = 'https://github.com/piero9212/BankCardKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'piero9212@gmail.com' => 'piero9212@gmail.com' }
  s.source           = { :git => 'https://github.com/piero9212/BankCardKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/piero_sifuentes'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BankCardKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BankCardKit' => ['BankCardKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
