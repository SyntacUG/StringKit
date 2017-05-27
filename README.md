# StringKit
StringKit is a new, simple and fast way to investigate and modify strings in Swift - The next level of string manipulation.

## Installation
1. Download the dynamic framework.
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

You will get an output in the console inside the debug area.

## Author
Rainer Niemann, rainerniemann@icloud.com

## License
This project is licensed under the MIT License. See the [LICENSE.md](/LICENSE.md) file for details.
