![StringKit Logo](Graphics/Logo.png)
[![Version](https://img.shields.io/badge/Version-0.8.0-orange.svg?style=flat)](#StringKit)
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
+ iOS 8.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+
+ Xcode 8.1+
+ Swift 3.1+

## Manual
1. Download the ZIP archive.
2. Add StringKit.swift to your project.
3. That's it. :]

## Dependency Managers
[![CocoaPods](https://img.shields.io/badge/CocoaPods-supported-brightgreen.svg?style=flat)](#installation)

[![Carthage](https://img.shields.io/badge/Carthage-supported-brightgreen.svg?style=flat)](#installation)

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-supported-brightgreen.svg?style=flat)](#installation)

### CocoaPods
Add ```pod 'StringKit', '~> 0.8.0'``` to your Podfile.

### Carthage
1. Create a Cartfile in your project directory.
2. Add ```github "rainerniemann/StringKit" ~> 0.8.0``` to your Cartfile.
3. Go to your project directory and run ```carthage update --platform iOS``` in your terminal. (for iOS)
4. Open the output folder with ```open carthage``` and drag and drop the StringKit.swift file into your project.
5. You are done. :]

## Import
```swift
import StringKit
```

# List of Extensions (still in progress)
## Investigation
+ **`charactersArray`**
+ **`length`**
+ **`range`**
+ **`lastIndex`**
+ **`hasLetters`**
+ **`hasNumbers`**
+ **`isEmpty`**
+ **`isNumeric`**
+ **`isAlphabetic`**
+ **`isAlphaNumeric`**
+ **`isConsistsOfOneRepeatingCharacter`**
+ **`isPalindrom`**
+ **`isContainingEmoji`**
+ **`isContaining(_ substring: String, caseSensitive: Bool)`**
+ **`isEmail`**
+ **`isValidURL`**
+ **`isValidSchemedURL`**
+ **`isValidHttpURL`**
+ **`isValidHttpsURL`**
+ **`isValidFileURL`**
+ **`firstCharacter`**
+ **`lastCharacter`**
+ **`initials`**
+ **`mostCommonCharacter`**
+ **`lines`**
+ **`isStartingWithSubstring(_ substring: String)`**

## Modification

## Conversion

## Creation

# Author
Rainer Niemann, rainerniemann@icloud.com

# License
This project is licensed under the MIT License. See the [LICENSE.md](/LICENSE.md) file for details.
