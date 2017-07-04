#
# Be sure to run `pod lib lint StringKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	s.name             = 'StringKit'
	s.version          = '0.6.0'
	s.summary          = 'A short description of StringKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

	s.description      = "Description"
	s.homepage         = 'https://github.com/rainerniemann/StringKit'
	s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
	s.author           = { 'rainerniemann' => 'rainerniemann@icloud.com' }
	s.source           = { :git => 'https://github.com/rainerniemann/StringKit.git', :tag => s.version.to_s }
	# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
	s.ios.deployment_target = '9.0'
	s.vendored_frameworks = 'StringKit.framework'
	# s.source_files = 'StringKit_iOS.framework/Modules/StringKit_iOS.swiftmodule/StringExtensions.swift'
	# s.resource_bundles = {
	#   'StringKit' => ['StringKit/Assets/*.png']
	# }
	# s.public_header_files = 'Pod/Classes/**/*.h'
	# s.frameworks = 'UIKit', 'MapKit'
	# s.dependency 'AFNetworking', '~> 2.3'
	s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.1' }
end