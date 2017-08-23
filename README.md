![StringKit Logo](Graphics/Logo.png)
[![Version](https://img.shields.io/badge/Version-0.9.0-orange.svg?style=flat)](#StringKit)
[![Build](https://img.shields.io/badge/Build-passing-brightgreen.svg?style=flat)](#StringKit)
[![Swift](https://img.shields.io/badge/Swift-3.1-brightgreen.svg?style=flat)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_macOS_tvOS_watchOS_Linux-brightgreen.svg?style=flat)](https://developer.apple.com)
[![IDE](https://img.shields.io/badge/IDE-Xcode_8.3.3-brightgreen.svg?style=flat)](https://developer.apple.com)
[![Dependencies](https://img.shields.io/badge/Dependencies-0-brightgreen.svg?style=flat)](#StringKit)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat)](/LICENSE.md)

StringKit is a new, simple and fast way to investigate and modify strings in Swift - The next level of string manipulation.

# Installation
## Requirements
+ iOS 9.0+ | macOS 10.11+ | tvOS 9.0+ | watchOS 2.0+ | Linux
+ Xcode 8.1+
+ Swift 3.1+

## Manual
1. Download the ZIP archive.
2. Add the `Source` folder or the `StringKit.framework` file to your project.
3. That's it. :]

## Dependency Managers
[![CocoaPods](https://img.shields.io/badge/CocoaPods-supported-brightgreen.svg?style=flat)](#cocoapods)

[![Carthage](https://img.shields.io/badge/Carthage-supported-brightgreen.svg?style=flat)](#carthage)

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-supported-brightgreen.svg?style=flat)](#swift-package-manager)

### CocoaPods
1. Add `pod 'StringKit', '~> 0.9.0'` to your Podfile.
2. Run `pod update` -> StringKit should be installed now.
3. You are finished! You can work with the new `.workspace` file now. :]

### Carthage
1. Create a Cartfile in your project directory.
2. Add `github "rainerniemann/StringKit" ~> 0.9.0` to your Cartfile.
3. Go to your project directory and run `carthage update --platform iOS` in your terminal (for iOS).
4. Open the output folder with `open carthage` and drag and drop the StringKit.swift file into your project.
5. You are done. :]

### Swift Package Manager
1. Create a Package.swift file in your project directory.
2. Add the following or just the dependency to your Package.swift file.
```swift
import PackageDescription

let package = Package(name: "YOUR_APPLICATIONS_NAME", targets: [], dependencies: 
[
  .Package(url: "https://github.com/rainerniemann/StringKit.git",
                 versions: Version(0,9,0) ... Version(0,9,0))
])
```
3. Run `swift build`.
4. Every time you want to debug the programm, run `swift build -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.11"`.

## Import
```swift
import StringKit
```

# Authors
Rainer Niemann, rainerniemann@icloud.com<br>
Andreas Niemann, andreasniemann1999@icloud.com

# License
This project is licensed under the MIT License. See the [LICENSE.md](/LICENSE.md) file for details.
