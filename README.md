# StringKit
[![Status](https://img.shields.io/badge/Status-unstable-orange.svg?style=flat)]()
[![Swift](https://img.shields.io/badge/Swift-3.1-brightgreen.svg?style=flat)]()
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat)]()
[![Dynamic_Framework](https://img.shields.io/badge/Dynamic_Framework-support-brightgreen.svg?style=flat)]()
[![Cocoa_Pods](https://img.shields.io/badge/Cocoa_Pods-currently_not_supported-red.svg?style=flat)]()
[![Carthage](https://img.shields.io/badge/Carthage-currently_not_supported-red.svg?style=flat)]()

StringKit is a new, simple and fast way to investigate and modify strings in Swift - The next level of string manipulation.

## Installation
1. Download the ZIP-Archive.
2. Add the framework file to the embedded binaries section.
3. That's it. :]

## Import
```swift
import StringKit
```

## Documentation
StringKit provides a documenation, so you have fast access to the entire bunch of methods and properties. It is also possible to categorize.

### Usage
```swift
String.stringKitDocumentation(option: SKStringDocumentationOption)
```

#### Categories:
```swift
public enum SKStringDocumentationOption
{
  case all // standard
  case investigation
  case modification
  case conversion
}
```

You will get an output in the console inside of the debug area.

## Author
Rainer Niemann, rainerniemann@icloud.com

## License
This project is licensed under the MIT License. See the [LICENSE.md](/LICENSE.md) file for details.
