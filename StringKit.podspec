Pod::Spec.new do |spec|
	spec.name						= "StringKit"
	spec.version					= "0.9.0"
	spec.summary					= "StringKit is a new, simple and fast way to investigate and modify strings in Swift - The next level of string manipulation."
	spec.description				= "StringKit is a new, simple and fast way to investigate and modify strings in Swift - The next level of string manipulation."
	spec.license					= { :type => "MIT", :file => "LICENSE.md" }
	spec.homepage					= "https://github.com/rainerniemann/StringKit"
	spec.author						= { "Rainer Niemann" => "rainerniemann@icloud.com" }
	spec.social_media_url			= "https://twitter.com/NiemannRainer"
	spec.documentation_url			= "https://github.com/rainerniemann/StringKit"

	spec.ios.deployment_target		= "8.0"
	spec.osx.deployment_target		= "10.10"
	spec.tvos.deployment_target		= "9.0"
	spec.watchos.deployment_target	= "2.0"

	spec.source						= { :git => "https://github.com/rainerniemann/StringKit.git", :tag => "0.9.0" }
	spec.source_files				= "Sources/*.swift"

	spec.ios.vendored_frameworks	= "Frameworks/iOS/StringKit.framework"

	spec.requires_arc				= true
	spec.pod_target_xcconfig		= { "SWIFT_VERSION" => "3.1" }
end
