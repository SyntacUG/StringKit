![StringKit Logo](Graphics/Logo.png)
[![Version](https://img.shields.io/badge/Version-0.9.0-orange.svg?style=flat)](#StringKit)
[![Build](https://img.shields.io/badge/Build-passing-orange.svg?style=flat)](#StringKit)
[![Swift](https://img.shields.io/badge/Swift-3.1-brightgreen.svg?style=flat)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS|macOS|tvOS|watchOS-brightgreen.svg?style=flat)](https://developer.apple.com)
[![IDE](https://img.shields.io/badge/IDE-Xcode_8.3.3-brightgreen.svg?style=flat)](https://developer.apple.com)
[![Dependencies](https://img.shields.io/badge/Dependencies-0-brightgreen.svg?style=flat)](#StringKit)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat)](/LICENSE.md)

StringKit is a new, simple and fast way to investigate and modify strings in Swift - The next level of string manipulation.

### Warning: This framework is still in development. Accordingly, the stability changes frequently.

# Installation
## Requirements
+ iOS 8.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+ | Linux
+ Xcode 8.1+
+ Swift 3.1+

## Manual
1. Download the ZIP archive.
2. Add the ```Source``` folder or the StringKit.framework file to your project.
3. That's it. :]

## Dependency Managers
[![CocoaPods](https://img.shields.io/badge/CocoaPods-supported-brightgreen.svg?style=flat)](#cocoapods)

[![Carthage](https://img.shields.io/badge/Carthage-supported-brightgreen.svg?style=flat)](#carthage)

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-supported-brightgreen.svg?style=flat)](#swift-package-manager)

### CocoaPods
1. Add ```pod 'StringKit', '~> 0.9.0'``` to your Podfile.
2. Run ```pod update``` -> StringKit should be installed now.
3. You are finished! You can work with the new .workspace file now. :]

### Carthage
1. Create a Cartfile in your project directory.
2. Add ```github "rainerniemann/StringKit" ~> 0.9.0``` to your Cartfile.
3. Go to your project directory and run ```carthage update --platform iOS``` in your terminal. (for iOS)
4. Open the output folder with ```open carthage``` and drag and drop the StringKit.swift file into your project.
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
3. Run ```swift build```.
4. Every time you want to debug the programm, run ```swift build -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.11"```.

## Import
```swift
import StringKit
```

# List of Extensions (still in progress)
## Investigation
+ **`characterArray`**
+ **`length`**
+ **`lastIndex`**
+ **`isNumeric`**
+ **`isAlphabetic`**
+ **`isAlphaNumeric`**
+ **`isLowerCase`**
+ **`isUpperCase`**
+ **`isLowerCase`**
+ **`isValidPalindrom`**
+ **`isValidUrl`**
+ **`isValidSchemedUrl`**
+ **`isValidHttpUrl`**
+ **`isValidHttpsUrl`**
+ **`isValidFileUrl`**
+ **`containsNumber`**
+ **`containsLetter`**
+ **`containsPunctuation`**
+ **`containsEmoji`**
+ **`startsWithNumber`**
+ **`startsWithLetter`**
+ **`startsWithPunctuation`**
+ **`startsWithEmoji`**
+ **`startsLowerCase`**
+ **`startsUpperCase`**
+ **`endsWithNumber`**
+ **`endsWithLetter`**
+ **`endsWithPunctuation`**
+ **`endsWithEmoji`**
+ **`endsLowerCase`**
+ **`endsUpperCase`**
+ **`firstCharacter`**
+ **`lastCharacter`**
+ **`initials`**
+ **`lines`**
+ **`mostCommonCharacter(caseSensitive: Bool = true)`**
+ **`containsRepetitiveCharacter(caseSensitive: Bool = true)`**
+ **`contains(substring: String, caseSensitive: Bool = true)`**
+ **`startsWith(substring: String, caseSensitive: Bool = true)`**
+ **`endsWith(substring: String, caseSensitive: Bool = true)`**
+ **`character(atIndex index: Int, infinite: Bool = false)`**
+ **`characterFromLeft(atIndex index: Int = 0, infinite: Bool = false)`**
+ **`characterFromRight(atIndex index: Int = 0, infinite: Bool = false)`**
+ **`substringFromLeft(toIndex index: Int = 0, infinite: Bool = false)`**
+ **`substringFromRight(steps: Int = 0, infinite: Bool = false)`**
+ **`substring(inRange range: CountableRange<Int>, infinite: Bool = false)`**
+ **`substring(inRange range: CountableClosedRange<Int>, infinite: Bool = false)`**
+ **`substrings(ofLength length: Int)`**
+ **`substrings(ofLength length: Int, inRange range: CountableRange<Int>)`** // error
+ **`substrings(ofLength length: Int, inRange range: CountableClosedRange<Int>)`** // error
+ **`count(substring: String, withOverlap overlap: Bool = true, caseSensitive: Bool = true)`**
+ **`indexesOf(substring: String, withOverlap overlapBool: Bool = true, caseSensitive: Bool = true)`**
+ **`between(left: String, right: String, inclusive: Bool = false, closedBlocks: Bool = false)`** // error
+ **`matchesPattern(_ pattern: String)`** // changes in 0.9.0
+ **`subscript(index: Int)`**
+ **`subscript(index: Int, infinite: Bool)`**
+ **`subscript(range: CountableRange<Int>)`**
+ **`subscript(range: CountableClosedRange<Int>)`**
+ **`subscript(range: CountableRange<Int>, infinite: Bool)`**
+ **`subscript(range: CountableClosedRange<Int>, infinite: Bool)`**

## Modification
Currently no overview

## Conversion
Currently no overview

## Creation
+ **`init?(ascii: Array<Int>, ignoreNonValidValues: Bool = false)`**
+ **`init?(base64: String)`** // changes in 0.9.0
+ **`init(randomOfLength length: Int)`**
+ **`static random(ofLength length: Int)`**

# Authors
Rainer Niemann, rainerniemann@icloud.com
Andreas Niemann, andreasniemann1999@icloud.com

# License
This project is licensed under the MIT License. See the [LICENSE.md](/LICENSE.md) file for details.
