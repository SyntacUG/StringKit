//
//  StringExtensions.swift
//  StringKit 0.7.0
//
//  Versions:
//  0.0.1:  290 lines - 28.05.2017
//  0.1.0:  472 lines - 30.05.2017
//  0.2.0:  701 lines - 15.06.2017
//  0.3.0:  811 lines - 15.06.2017
//  0.4.0:  946 lines - 15.06.2017
//  0.5.0: 1278 lines - 21.06.2017
//  0.6.0: 1615 lines - 25.06.2017
//  0.7.0:
//
//  Legend:
//  if applicable:		Nil values are possible.
//  safely:				Errors can't happen.
//  possible:			Discardable result.
//  optional:			Parameter not required.
//
//  Created by Rainer Niemann
//  Copyright © 2017 Syntac. All rights reserved.

//  MARK: Imports - TESTED
import UIKit

//  MARK: String-Documentation-Extension - NOT TESTED
public extension String
{
	/// StringKit: Documentation categories.
	public enum SKStringDocumentationOption: Int
	{
		case all = 0
		case investigation = 1
		case modification = 2
		case conversion = 3
	}
	
	/// StringKit: Returns available properties and methods. 
	///
	/// - Parameters:
	///		- option: Provides the possibility to categorize the result. (standard: SKStringDocumentationOption.all)
	public static func documentation(option: SKStringDocumentationOption = SKStringDocumentationOption.all) -> String
	{
		var documentationText: String = String()
		var sectionText: String = String()
		var sections: Array<Int> = Array<Int>()
		
		let fileName: String = "SKDocumentation"
		let fileExtension: String = "txt"
		
		for bundle in Bundle.allBundles
		{
			if let resourcePath: String = bundle.path(forResource: fileName, ofType: fileExtension)
			{
				documentationText = try! String.init(contentsOf: URL(fileURLWithPath: resourcePath))
				break
			}
		}
		
		if option == SKStringDocumentationOption.all
		{
			documentationText.removeSubstring("#")
			print(documentationText)
			return documentationText
		}
		else
		{
			sections = documentationText.indexesOfSubstring("#")
			sectionText = "---------------------------------------------\n\nAvailable Properties and Methods in StringKit\n\n\n"
			if option == SKStringDocumentationOption.investigation
			{
				sectionText += documentationText[sections[SKStringDocumentationOption.investigation.rawValue] + 1 ... sections[SKStringDocumentationOption.investigation.rawValue + 1] - 1]
			}
			else if option == SKStringDocumentationOption.modification
			{
				sectionText += documentationText[sections[SKStringDocumentationOption.modification.rawValue] + 1 ... sections[SKStringDocumentationOption.modification.rawValue + 1] - 1]
			}
			else if option == SKStringDocumentationOption.conversion
			{
				sectionText += documentationText[sections[SKStringDocumentationOption.conversion.rawValue] + 1 ... sections[SKStringDocumentationOption.modification.rawValue + 1] - 1]
			}
			sectionText.removeSubstring("#")
			sectionText += "---------------------------------------------"
			print(sectionText)
			return sectionText
		}
	}
}

//  MARK: String-Investigation-Extension - TESTING
public extension String
{
	//  MARK: Properties
	/// StringKit: Returns an array containing the single characters of a string.
	public var charactersArray: Array<String>
	{
		guard !self.isEmpty
			else { return Array<String>() }
		return self.characters.map({ String($0) })
	}
	
	/// StringKit: Returns the number of characters in a string.
	public var length: Int
	{
		guard !self.isEmpty
			else { return 0 }
		return self.characters.count
	}
	
	/// StringKit: Returns the range of a string.
	public var range: ClosedRange<String.Index>
	{
		return self.startIndex ... self.endIndex
	}
	
	/// StringKit: Returns the last index of a string (if applicable).
	public var lastIndex: Int?
	{
		guard !self.isEmpty
			else { return nil }
		return self.length - 1
	}
	
	/// StringKit: Checks if a string is empty.
	public var isEmpty: Bool
	{
		return self.characters.count < 1 ? true : false
	}
	
	/// StringKit: Checks if a string is numeric.
	public var isNumeric: Bool
	{
		guard !self.isEmpty &&
			!self.containsLetters &&
			self.containsNumbers
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is alphabetic.
	public var isAlphabetic: Bool
	{
		guard !self.isEmpty &&
			self.containsLetters &&
			!self.containsNumbers
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is alphanumeric.
	public var isAlphaNumeric: Bool
	{
		guard !self.isEmpty &&
			self.containsLetters ||
			self.containsNumbers
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is lower case.
	public var isLowerCase: Bool
	{
		guard !self.isEmpty &&
			self == self.lowercased()
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is upper case.
	public var isUpperCase: Bool
	{
		guard !self.isEmpty &&
			self == self.uppercased()
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a palindrom.
	public var isPalindrom: Bool
	{
		guard !self.isEmpty &&
			isAlphaNumeric &&
			self.lowercased() == String(self.characters.reversed())
			else { return false }
		return true
	}
	
	// -----------------------------------------
	
	/// StringKit: Checks if a string is a valid E-Mail.
	public var isEmail: Bool
	{
		guard !self.isEmpty &&
		self.matchesPattern("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
		else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid URL.
	public var isValidURL: Bool
	{
		guard !self.isEmpty else { return false }
		return URL(string: self) != nil
	}
	
	/// StringKit: Checks if a string is a valid schemed URL.
	public var isValidSchemedURL: Bool
	{
		guard !self.isEmpty, let url: URL = URL(string: self) else { return false }
		return url.scheme != nil
	}
	
	/// StringKit: Checks if a string is a valid http URL.
	public var isValidHttpURL: Bool
	{
		guard !self.isEmpty, let url: URL = URL(string: self) else { return false }
		return url.scheme == "http"
	}
	
	/// StringKit: Checks if a string is a valid https URL.
	public var isValidHttpsURL: Bool
	{
		guard !self.isEmpty, let url: URL = URL(string: self) else { return false }
		return url.scheme == "https"
	}
	
	/// StringKit: Checks if a string is a valid file URL.
	public var isValidFileURL: Bool
	{
		guard !self.isEmpty
			else { return false }
		return URL(string: self)?.isFileURL ?? false
	}
	
	/// StringKit: Checks if a string starts lower case.
	public var startsLowerCase: Bool
	{
		guard !self.isEmpty &&
			self.firstCharacter ?? "" == self.firstCharacter ?? " ".lowercased()
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends lower case.
	public var endsLowerCase: Bool
	{
		guard !self.isEmpty &&
			self.lastCharacter ?? "" == self.lastCharacter ?? " ".lowercased()
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts upper case.
	public var startsUpperCase: Bool
	{
		guard !self.isEmpty &&
			self.firstCharacter ?? "" == self.firstCharacter ?? " ".uppercased()
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends upper case.
	public var endsUpperCase: Bool
	{
		guard !self.isEmpty &&
			self.lastCharacter ?? "" == self.lastCharacter ?? " ".uppercased()
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string contains numbers.
	public var containsNumbers: Bool
	{
		guard !self.isEmpty &&
			self.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string contains letters.
	public var containsLetters: Bool
	{
		guard !self.isEmpty &&
			self.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
			else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is only consists of one repeating character.
	public var containsOnlyOneRepeatingCharacter: Bool
	{
		guard !self.isEmpty, let firstCharacter: String = self.firstCharacter else { return false }
		return self.indexesOfSubstring(firstCharacter).count == self.length ? true : false
	}
	
	/// StringKit: Checks if a string contains emojis.
	public var containsEmoji: Bool
	{
		guard !self.isEmpty else { return false }
		for scalar in unicodeScalars
		{
			switch scalar.value
			{
			case 0x3030, 0x00AE, 0x00A9,	// Special Characters
			0x1D000 ... 0x1F77F,			// Emoticons
			0x2100 ... 0x27BF,				// Misc symbols and Dingbats
			0xFE00 ... 0xFE0F,				// Variation Selectors
			0x1F900 ... 0x1F9FF:			// Supplemental Symbols and Pictographs
				return true
			default:
				continue
			}
		}
		return false
	}
	
	/// StringKit: Checks if a string contains one or more instance of a substring.
	///
	/// - Parameters:
	///   - substring: The substring to search for.
	///   - caseSensitive: The possibility to search case sensitive (default: true).
	public func contains(substring: String, caseSensitive: Bool = true) -> Bool
	{
		guard !self.isEmpty
		else { return false }
		
		if !caseSensitive
		{
			return range(of: substring, options: .caseInsensitive) != nil
		}
		return range(of: substring) != nil
	}
	
	/// StringKit: Returns the first character of a string of type string.
	public var firstCharacter: String?
	{
		guard !self.isEmpty else { return nil }
		return self.characterFromLeft()
	}
	
	/// StringKit: Returns the last character of a string of type string.
	public var lastCharacter: String?
	{
		guard !self.isEmpty else { return nil }
		return self.characterFromRight()
	}
	
	/// StringKit: Returns an array of the initials of all words in a string.
	public var initials: Array<String>
	{
		guard !self.isEmpty else { return Array<String>() }
		var resultArray: Array<String> = Array<String>()
		self.uppercased().components(separatedBy: " ").forEach({ resultArray.append($0[0]) })
		return resultArray
	}
	
	/// StringKit: Returns the most common character in a string.
	public var mostCommonCharacter: String
	{
		let mostCommon: Character? = self.removedSpacesAndNewLines().characters.reduce([Character: Int]())
		{
			var counts = $0
			counts[$1] = ($0[$1] ?? 0) + 1
			return counts
		}.max(by: { $0.1 < $1.1 })?.0
		return String(describing: mostCommon)
	}
	
	/// StringKit: Returns an array of strings separated by new lines.
	public var lines: Array<String>
	{
		var result: Array<String> = Array<String>()
		enumerateLines
		{ line, _ in
			result.append(line)
		}
		return result
	}
	
	//  MARK: Methods
	/// StringKit: Checks if a string starts with a given substring.
	///
	/// - Parameters:
	///		- substring: The substring the string should starts with.
	public func isStartingWithSubstring(_ substring: String) -> Bool
	{
		guard !self.isEmpty || substring.isEmpty else { return false }
		if self[0 ... substring.lastIndex!] == substring
		{
			return true
		}
		return false
	}
	
	/// StringKit: Checks if a string ends of a given substring.
	///
	/// - Parameters:
	///		- substring: The substring the string should ends with.
	public func isEndingOfSubstring(_ substring: String) -> Bool
	{
		guard !self.isEmpty || substring.isEmpty else { return false }
		if self[self.lastIndex! - substring.length ... self.lastIndex!] == substring
		{
			return true
		}
		return false
	}
	
	/// StringKit: Returns the i-th character of a string beginning from the left side.
	///
	/// - Parameters:
	///		- i: The index of the character which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity. (standard: false)
	public func characterFromLeft(_ i: Int = 0, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self[i]
		}
		else
		{
			guard self.range ~= self.index(self.startIndex, offsetBy: i) else { return String() }
			return self[i]
		}
	}
	
	/// StringKit: Returns the i-th character of a string beginning from the right side.
	///
	/// - Parameters:
	///		- i: The index of the character which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity. (standard: false)
	public func characterFromRight(_ i: Int = 0, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self[i]
		}
		else
		{
			guard self.range ~= self.index(self.endIndex, offsetBy: i) else { return String() }
			return self[i]
		}
	}
	
	/// StringKit: Returns a substring with n - 1 characters of a string beginning from the left side.
	///
	/// - Parameters:
	///		- n: The ending index of the substring which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity. (standard: false)
	public func substringFromLeft(_ n: Int, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self[0 ... n]
		}
		else
		{
			guard self.range ~= self.index(self.startIndex, offsetBy: n) else { return String() }
			return self[0 ... n]
		}
	}
	
	/// StringKit: Returns a substring with n - 1 characters of a string beginning from the right side.
	///
	/// - Parameters:
	///		- n: The starting index of the substring which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity. (standard: false)
	public func substringFromRight(_ n: Int, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self[self.lastIndex! - n ... self.lastIndex!]
		}
		else
		{
			guard self.range ~= self.index(self.endIndex, offsetBy: n) else { return String() }
			return self[self.lastIndex! - n ... self.lastIndex!]
		}
	}
	
	/// StringKit: Returns the i-th character of a string of type string.
	///
	/// - Parameters:
	///		- i: The index of the character which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity. (standard: false)
	public func characterAtIndex(i: Int, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self[i]
		}
		else
		{
			guard self.range ~= self.index(self.startIndex, offsetBy: i) else { return String() }
			return self[i]
		}
	}
	
	/// StringKit: Returns a substring in range of a string. (All directions possible: +, +; -, -; -, +; Reversing is also provided.
	///
	/// - Parameters:
	///		- range: The range of the substring which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity.
	public func substringInRange(_ range: CountableClosedRange<Int>, infinite: Bool = false) -> String
	{
		var i1 = self.distance(from: self.startIndex, to: self.index(self.startIndex, offsetBy: range.lowerBound))
		var i2 = self.distance(from: self.startIndex, to: self.index(self.startIndex, offsetBy: range.upperBound))
		
		if i1 < 0 && infinite
		{
			let cor = self.length * Int(ceil(abs(Double(i1)) / Double(self.length)))
			i1 = i1 + cor
			i2 = i2 + cor
		}
		
		if i1 < i2
		{
			var res = ""
			if i2 >= self.length && infinite
			{
				res += self[self.index(self.startIndex, offsetBy: i1) ... self.index(self.startIndex, offsetBy: self.length - 1)]
				i2 = i2 - self.length
				let counter = Int(Double(i2) / Double(self.length))
				res += String(repeating: self, count: counter)
				i2 = i2 - (self.length * counter)
				res += self[0 ... i2]
			}
			else
			{
				res += self[self.index(self.startIndex, offsetBy: i1) ... self.index(self.startIndex, offsetBy: i2)]
			}
			
			return res
		}
		else if i1 > i2
		{
			return String(self[i2 ... i1].characters.reversed())
		}
		return self[self.index(self.startIndex, offsetBy: i1) ... self.index(self.startIndex, offsetBy: i1)]
	}
	
	/// StringKit: Returns a substring in range of a string. (All directions possible: +, +; -, -; -, +; Reversing is also provided.
	///
	/// - Parameters:
	///		- range: The range of the substring which is tried to be accessed.
	///		- invinite: Provides the possibility to move over the string until infinity.
	public func substringInRange(_ range: CountableRange<Int>, infinite: Bool = false) -> String
	{
		var i1 = self.distance(from: self.startIndex, to: self.index(self.startIndex, offsetBy: range.lowerBound))
		var i2 = self.distance(from: self.startIndex, to: self.index(self.startIndex, offsetBy: range.upperBound))
		
		if i1 < 0 && infinite
		{
			let cor = self.length * Int(ceil(abs(Double(i1)) / Double(self.length)))
			i1 = i1 + cor
			i2 = i2 + cor
		}
		
		if i1 < i2
		{
			var res = ""
			if i2 >= self.length && infinite
			{
				res += self[self.index(self.startIndex, offsetBy: i1) ... self.index(self.startIndex, offsetBy: self.length - 1)]
				i2 = i2 - self.length
				let counter = Int(Double(i2) / Double(self.length))
				res += String(repeating: self, count: counter)
				i2 = i2 - (self.length * counter)
				res += self[0 ... i2]
			}
			else
			{
				res += self[self.index(self.startIndex, offsetBy: i1) ... self.index(self.startIndex, offsetBy: i2)]
			}
			
			return res
		}
		else if i1 > i2
		{
			return String(self[i2 ... i1].characters.reversed())
		}
		return self[self.index(self.startIndex, offsetBy: i1) ... self.index(self.startIndex, offsetBy: i1)]
	}
	
	/// StringKit: Splits a string into substrings of equal length and returns a result array.
	///
	/// - Parameters:
	///		- length: The length of the splitted substrings.
	public func substringsOfLength(_ length: Int) -> Array<String>
	{
		guard !self.isEmpty || length > 0 else { return Array<String>() }
		return stride(from: 0, to: self.characters.count, by: length).map({ index -> String in
			let startIndex: String.Index = self.index(self.startIndex, offsetBy: index)
			let endIndex: String.Index = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
			return self[startIndex ..< endIndex]
		})
	}
	
	/// StringKit: Splits a string into substrings of equal length and returns a result array.
	///
	/// - Parameters:
	///		- length: The length of the splitted substrings.
	///		- range: The range of the substring to split.
	public func substringsOfLength(_ length: Int, inRange range: CountableRange<Int>) -> Array<String>
	{
		guard !self.isEmpty || length > 0 else { return Array<String>() }
		return stride(from: range.lowerBound, to: range.upperBound, by: length).map({ index -> String in
			let startIndex: String.Index = self.index(self.startIndex, offsetBy: index)
			let endIndex: String.Index = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
			return self[startIndex ..< endIndex]
		})
	}
	
	/// StringKit: Splits a string into substrings of equal length and returns a result array.
	///
	/// - Parameters:
	///		- length: The length of the splitted substrings.
	///		- range: The range of the substring to split.
	public func substringsOfLength(_ length: Int, inRange range: CountableClosedRange<Int>) -> Array<String>
	{
		guard !self.isEmpty || length > 0 else { return Array<String>() }
		return stride(from: range.lowerBound, to: range.upperBound, by: length).map({ index -> String in
			let startIndex: String.Index = self.index(self.startIndex, offsetBy: index)
			let endIndex: String.Index = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
			return self[startIndex ..< endIndex]
		})
	}
	
	/// StringKit: Returns the number of occurrences matching with a given pattern.
	///
	/// - Parameters:
	///		- pattern: The pattern the count is searched for.
	///		- caseSensitive: The possibility to search case sensitive (default is true).
	public func countSubstring(_ substring: String, caseSensitive: Bool = true) -> Int
	{
		guard !self.isEmpty else { return 0 }
		if !caseSensitive
		{
			return lowercased().components(separatedBy: substring.lowercased()).count - 1
		}
		return components(separatedBy: substring).count - 1
	}
	
	func indexesOfSubstring(_ substring: String, repeatingTimes: Int = 1, caseSensitive: Bool = true) -> Array<Int>
	{
		guard !substring.isEmpty && !self.isEmpty else { return Array<Int>() }
		guard substring != self else { return [0] }
		
		var resultArray: Array<Int> = Array()
		var preprocessedIndexes: Array<Int> = Array()
		
		func calculateOverlap() -> Int
		{
			var i: Int = 0
			while substring[i] == substring[substring.lastIndex! - i] { i += 1 }
			return i
		}
		
		var i: Int = 0
		if substring.length == 1
		{
			for (index, character) in self.characters.enumerated()
			{
				guard substring[0] == String(character) else { continue }
				resultArray.append(index)
			}
		}
		else if substring.length == 2 && self.length > 1
		{
			while i < self.lastIndex!
			{
				if substring == self[i ... i + 1] { resultArray.append(i) }
				i += 1
			}
		}
		else
		{
			let left: String = substring.firstCharacter!
			let right: String = substring.lastCharacter!
			let counter: Int = repeatingTimes
			let overlap: Int = calculateOverlap()
			
			while i <= self.length - substring.length
			{
				if left == self[i] && right == self[i + substring.lastIndex!] && substring == self[i ... i + substring.lastIndex!]
				{
					resultArray.append(i)
					i += substring.length - overlap
				}
				else { i += 1 }
			}
			
			if counter > 1 { for _ in 1 ... counter { resultArray.remove(at: resultArray.count - counter - 1) } }
		}
		
		return resultArray
	}
	
	public func between(left: String, right: String, inclusive: Bool = false, closedBlocks: Bool = false) -> Array<String>
	{
		let leftOccurrences: Array<Int> = self.indexesOfSubstring(left)
		var rightOccurences: Array<Int> = Array<Int>()
		if left == right { rightOccurences = leftOccurrences } else { rightOccurences = self.indexesOfSubstring(right) }
		guard leftOccurrences.count > 0 && rightOccurences.count > 0 else { return Array() }
		var resutArray: Array<String> = Array()
		
		if left == right
		{
			
		}
		else
		{
			if closedBlocks
			{
			
			}
			else
			{
				for l in leftOccurrences
				{
					for r in rightOccurences where r >= l
					{
						var substring: String = l + 1 == r ? "" : self[l + 1 ... r - 1]
						if inclusive
						{
							substring = left + substring
							substring += right
						}
						resutArray.append(substring)
					}
				}
			}
		}
		
		return resutArray
	}
	
	/// StringKit: Checks if a string matches a regex pattern.
	///
	/// - Parameters:
	///		- pattern: The pattern to verify.
	func matchesPattern(_ pattern: String) -> Bool
	{
		return self.range(of: pattern, options: String.CompareOptions.regularExpression, range: nil, locale: nil) != nil
	}
	
	//  MARK: Subscripts
	/// StringKit: Returns the i-th character of a string of type string.
	///
	/// - Parameters:
	///		- index: The index of the character which is tried to be accessed.
	public subscript(index: Int) -> String
	{
		get
		{
			return self.characterAtIndex(i: index)
		}
		set
		{
			self.replaceSubstringInRange(index ... index, withString: newValue)
		}
	}
	
	/// StringKit: Returns the i-th character of a string of type string.
	///
	/// - Parameters:
	///		- index: The index of the character which is tried to be accessed.
	///		- infinite: Provides the possibility to move over the string until infinity.
	public subscript(index: Int, infinite: Bool) -> String
	{
		get
		{
			return self.characterAtIndex(i: index, infinite: true)
		}
		set
		{
			guard !self.isEmpty else { return }
			let i1: Int = index <= 0 ? index : 0
			let i2: Int = index > self.lastIndex! ? index : self.lastIndex!
			self = self[i1 ... i2]
			self.replaceSubstringInRange(index ... index, withString: newValue)
		}
	}
	
	/// StringKit: 
	///	- get: Returns a substring of a string in a specific range. (All directions possible: + ... +; - ... -; - ... +; + ... -; Reversing is also provided.
	/// - set: Replaces a substring in a specific range with a new string.
	///
	/// - Parameters:
	///		- range: The range of the substring which is tried to be accessed.
	public subscript(range: CountableClosedRange<Int>) -> String
	{
		get
		{
			return self.substringInRange(range)
		}
		set
		{
			self.replaceSubstringInRange(range, withString: newValue)
		}
	}
	
	/// StringKit: Returns a substring in range of a string. (All directions possible: +, +; -, -; -, +; Reversing is also provided.
	///
	/// - Parameters:
	///		- range: The range of the substring which is tried to be accessed.
	///		- infinite: Provides the possibility to move over the string until infinity.
	public subscript(range: CountableClosedRange<Int>, infinite: Bool) -> String
	{
		get
		{
			return self.substringInRange(range, infinite: infinite)
		}
		set
		{
			guard !self.isEmpty else { return }
			let i1: Int = range.lowerBound <= 0 ? range.lowerBound : 0
			let i2: Int = range.upperBound > self.lastIndex! ? range.upperBound : self.lastIndex!
			self = self[i1 ... i2]
			self.replaceSubstringInRange(range, withString: newValue)
		}
	}
}

//  MARK: String-Modification-Extension
public extension String
{
	//  MARK: Methods
	/// StringKit: Appends a string on the left side and returns the result.
	///
	/// - Parameters:
	///		- string: The string to append.
	public func appendedLeft(_ string: String) -> String
	{
		return string + self
	}
	
	/// StringKit: Appends a string on the left side.
	///
	/// - Parameters:
	///		- string: The string to append.
	@discardableResult public mutating func appendLeft(_ string: String) -> String
	{
		self = string + self
		return self
	}
	
	/// StringKit: Appends a string on the right side and returns the result.
	///
	/// - Parameters:
	///		- string: The string to append.
	public func appendedRight(_ string: String) -> String
	{
		return self + string
	}
	
	/// StringKit: Appends a string on the right side.
	///
	/// - Parameters:
	///		- string: The string to append.
	@discardableResult public mutating func appendRight(_ string: String) -> String
	{
		self = self + string
		return self
	}
	
	/// StringKit: Appends a string on the left and on the right side and returns the result.
	///
	/// - Parameters:
	///		- string: The string to append.
	public func appendedLeftAndRight(_ string: String) -> String
	{
		var tmp: String = self
		tmp = self.appendedLeft(string)
		tmp = tmp.appendedRight(string)
		return tmp
	}
	
	/// StringKit: Appends a string on the left and on the right side.
	///
	/// - Parameters:
	///		- string: The string to append.
	@discardableResult public mutating func appendLeftAndRight(_ string: String) -> String
	{
		self.appendLeft(string)
		self.appendRight(string)
		return self
	}
	
	/// StringKit: Replaces a character at a specific index with a new string and returns the result.
	///
	/// - Parameters:
	///		- index: The index of the character to replace.
	///		- string: The new string.
	public func replacedCharacterAtIndex(_ index: Int, withString string: String) -> String
	{
		guard !self.isEmpty && self.range ~= self.index(self.startIndex, offsetBy: index) else { return self }
		var tmp: String = self
		tmp.replaceSubrange(ClosedRange<String.Index>.init(uncheckedBounds: (lower: self.index(self.startIndex, offsetBy: index), upper: self.index(self.startIndex, offsetBy: index))), with: string)
		return tmp
	}
	
	/// StringKit: Replaces a character at a specific index with a new string.
	///
	/// - Parameters:
	///		- index: The index of the character to replace.
	///		- string: The new string.
	@discardableResult public func replaceCharacterAtIndex(_ index: Int, withString string: String) -> String
	{
		guard !self.isEmpty && self.range ~= self.index(self.startIndex, offsetBy: index) else { return self }
		var tmp: String = self
		tmp.replaceSubrange(ClosedRange<String.Index>.init(uncheckedBounds: (lower: self.index(self.startIndex, offsetBy: index), upper: self.index(self.startIndex, offsetBy: index))), with: string)
		return tmp
	}
	
	/// StringKit: Replaces a substring in a specific range with a new string and returns the result.
	///
	/// - Parameters:
	///		- range: The range of the substring to replace.
	///		- string: The new string.
	public func replacedSubstringInRange(_ range: CountableClosedRange<Int>, withString string: String) -> String
	{
		guard !self.isEmpty else { return String() }
		
		var i1: Int = Int()
		var i2: Int = Int()
		
		i1 = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
		i2 = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
		i1 = i1 < 0 ? 0 : i1
		i2 = i2 > self.lastIndex! ? self.lastIndex! : i2
		
		var tmp: String = self
		tmp.replaceSubrange(ClosedRange<String.Index>.init(uncheckedBounds: (lower: self.index(self.startIndex, offsetBy: range.lowerBound), upper: self.index(self.startIndex, offsetBy: range.upperBound))), with: string)
		return tmp
	}
	
	/// StringKit: Replaces a substring in a specific range with a new string.
	///
	/// - Parameters:
	///		- range: The range of the substring to replace.
	///		- string: The new string.
	@discardableResult public mutating func replaceSubstringInRange(_ range: CountableClosedRange<Int>, withString string: String) -> String
	{
		guard !self.isEmpty else { return String() }
		
		var i1: Int = Int()
		var i2: Int = Int()
		
		i1 = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
		i2 = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
		i1 = i1 < 0 ? 0 : i1
		i2 = i2 > self.lastIndex! ? self.lastIndex! : i2
		
		self.replaceSubrange(ClosedRange<String.Index>.init(uncheckedBounds: (lower: self.index(self.startIndex, offsetBy: range.lowerBound), upper: self.index(self.startIndex, offsetBy: range.upperBound))), with: string)
		return self
	}
	
	/// StringKit: Replaces a substring in the entire string with a new string and returns the result.
	///
	/// - Parameters:
	///		- substring: The substring to replace.
	///		- string: The new string.
	///		- range: The range to look substrings to replace.
	public func replacedSubstring(_ substring: String, withString string: String, inRange range: CountableClosedRange<Int> = -1 ... -1) -> String
	{
		guard !self.isEmpty else { return String() }
		
		var i1: Int = Int()
		var i2: Int = Int()
		
		if range.lowerBound != -1 && range.upperBound != -1
		{
			i1 = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
			i2 = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
			i1 = i1 < 0 ? 0 : i1
			i2 = i2 > self.lastIndex! ? self.lastIndex! : i2
		}
		else
		{
			i1 = 0
			i2 = self.lastIndex!
		}

		let tmp: String = self
		return tmp.replacingOccurrences(of: substring, with: string, options: String.CompareOptions.caseInsensitive, range: Range<String.Index>(self.index(self.startIndex, offsetBy: i1) ..< self.index(self.startIndex, offsetBy: i2 + 1)))
	}
	
	/// StringKit: Replaces a substring in the entire string with a new string.
	///
	/// - Parameters:
	///		- substring: The substring to replace.
	///		- string: The new string.
	///		- range: The range to look substrings to replace.
	@discardableResult public mutating func replaceSubstring(_ substring: String, withString string: String, inRange range: CountableClosedRange<Int> = -1 ... -1) -> String
	{
		guard !self.isEmpty else { return self }
		
		var i1: Int = Int()
		var i2: Int = Int()
		
		if range.lowerBound != -1 && range.upperBound != -1
		{
			i1 = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
			i2 = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
			i1 = i1 < 0 ? 0 : i1
			i2 = i2 > self.lastIndex! ? self.lastIndex! : i2
		}
		else
		{
			i1 = 0
			i2 = self.lastIndex!
		}

		self = self.replacingOccurrences(of: substring, with: string, options: String.CompareOptions.caseInsensitive, range: Range<String.Index>(self.index(self.startIndex, offsetBy: i1) ..< self.index(self.startIndex, offsetBy: i2 + 1)))
		return self
	}
	
	public func moved(substringInRange range: CountableClosedRange<Int>, toIndex index: Int) -> String
	{
		guard !self.isEmpty else { return self }

		var lowerBound: Int = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
		var upperBound: Int = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
		lowerBound = lowerBound < 0 ? 0 : lowerBound
		upperBound = upperBound > self.lastIndex! ? self.lastIndex! : upperBound
		
		var index: Int = index < 0 ? 0 : index
		index = index > self.lastIndex! ? self.lastIndex! : index
		
		return self[0 ... Int(UInt(lowerBound - 1))] + self[upperBound + 1 ... index - 1] + self[lowerBound ... upperBound] + self[index ... self.lastIndex!]
	}
	
	/*public func swaped(range range1: CountableClosedRange<Int>, withRange range2: CountableClosedRange<Int>) -> String
	{
		let range1: CountableClosedRange =
		return
	}*/
	
	
	
	/// StringKit: Inserts a character at a specific index and returns a transient result.
	///
	/// - Parameters:
	///		- character: The character to insert.
	///		- index: The target index of the character to insert.
	public func insertedCharacter(_ character: String, atIndex index: Int) -> String
	{
		guard !self.isEmpty && !character.isEmpty else { return self }
		var tmp: String = self
		tmp.insert(Character(character), at: self.index(self.startIndex, offsetBy: index))
		return tmp
	}
	
	/// StringKit: Inserts a character at a specific index.
	///
	/// - Parameters:
	///		- character: The character to insert.
	///		- index: The target index of the character to insert.
	@discardableResult public mutating func insertCharacter(_ character: String, atIndex index: Int) -> String
	{
		guard !self.isEmpty && !character.isEmpty else { return self }
		self.insert(Character(character), at: self.index(self.startIndex, offsetBy: index))
		return self
	}
	
	/// StringKit: Inserts a substring at a specific index and returns a transient result.
	///
	/// - Parameters:
	///		- substring: The substring to insert.
	///		- index: The target index of the substring to insert.
	public func insertedSubstring(_ substring: String, atIndex index: Int) -> String
	{
		guard !self.isEmpty && !substring.isEmpty else { return self }
		var tmp: String = self
		tmp.insert(contentsOf: substring.characters, at: self.index(self.startIndex, offsetBy: index))
		return tmp
	}
	
	/// StringKit: Inserts a substring at a specific index.
	///
	/// - Parameters:
	///		- substring: The substring to insert.
	///		- index: The target index of the substring to insert.
	@discardableResult public mutating func insertSubstring(_ substring: String, atIndex index: Int) -> String
	{
		guard !self.isEmpty && !substring.isEmpty else { return self }
		self.insert(contentsOf: substring.characters, at: self.index(self.startIndex, offsetBy: index))
		return self
	}

	/// StringKit: Removes a character at a specific index and returns the result.
	///
	/// - Parameters:
	///		- i: The index of the character to remove.
	public func removedCharacterAtIndex(_ i: Int) -> String
	{
		guard !self.isEmpty && 0 ... self.lastIndex! ~= i else { return self }
		var tmp: String = self
		tmp.remove(at: String.Index.init(self.utf16.startIndex + i, within: self)!)
		return tmp
	}
	
	/// StringKit: Removes a character at a specific index.
	///
	/// - Parameters:
	///		- i: The index of the character to remove.
	@discardableResult public mutating func removeCharacterAtIndex(_ i: Int) -> String
	{
		guard !self.isEmpty && 0 ... self.lastIndex! ~= i else { return self }
		self.replaceCharacterAtIndex(i, withString: "")
		return self
	}
	
	/// StringKit: Removes a substring beginning from the left side and returns a transient result.
	/// 
	/// - Parameters:
	///		- index: The end index of the substring to remove.
	public func removedFromLeftToIndex(_ index: Int) -> String
	{
		guard !self.isEmpty else { return self }
		return self.removedSubstringInRange(0 ... index)
	}
	
	/// StringKit: Removes a substring beginning from the left side and returns a result (possible).
	///
	/// - Parameters:
	///		- index: The end index of the substring to remove.
	@discardableResult public mutating func removeFromLeftToIndex(_ index: Int) -> String
	{
		guard !self.isEmpty else { return self }
		return self.removeSubstringInRange(0 ... index)
	}
	
	/// StringKit: Removes a substring beginning from the right side and returns a transient result.
	///
	/// - Parameters:
	///		- index: The end index of the substring to remove.
	public func removedFromRightToIndex(_ index: Int) -> String
	{
		guard !self.isEmpty else { return self }
		return self.removedSubstringInRange(self.lastIndex! - index ... self.lastIndex!)
	}
	
	/// StringKit: Removes a substring beginning from the right side and returns a result (possible).
	///
	/// - Parameters:
	///		- index: The end index of the substring to remove.
	@discardableResult public mutating func removeFromRightToIndex(_ index: Int) -> String
	{
		guard !self.isEmpty else { return self }
		return self.removeSubstringInRange(self.lastIndex! - index ... self.lastIndex!)
	}
	
	/// StringKit: Removes a substring in a specific range and returns the result.
	///
	/// - Parameters:
	///		- range: The range of the substring to remove.
	public func removedSubstringInRange(_ range: CountableClosedRange<Int>) -> String
	{
		guard !self.isEmpty else { return self }
		var tmp: String = self
		tmp.replaceSubstringInRange(range, withString: "")
		return tmp
	}
	
	/// StringKit: Removes a substring in a specific range.
	///
	/// - Parameters:
	///		- range: The range of the substring to remove.
	@discardableResult public mutating func removeSubstringInRange(_ range: CountableClosedRange<Int>) -> String
	{
		guard !self.isEmpty else { return self }
		
		var i1: Int = Int()
		var i2: Int = Int()
		
		i1 = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
		i2 = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
		i1 = i1 < 0 ? 0 : i1
		i2 = i2 > self.lastIndex! ? self.lastIndex! : i2
		
		self.removeSubrange(String.Index.init(self.utf16.startIndex + i1, within: self)! ... String.Index.init(self.utf16.startIndex + i2, within: self)!)
		return self
	}
	
	/// StringKit: Removes a substring in the entire string and returns the result.
	///
	/// - Parameters:
	///		- range: The range of the substring to remove.
	public func removedSubstring(_ string: String) -> String
	{
		guard !self.isEmpty && !string.isEmpty else { return self }
		var tmp: String = self
		while self.contains(string)
		{
			let index: Int = self.indexesOfSubstring(string)[0]
			tmp.removeSubstringInRange(index ... index + string.lastIndex!)
		}
		return tmp
	}
	
	/// StringKit: Removes a substring in the entire string.
	///
	/// - Parameters:
	///		- range: The range of the substring to remove.
	@discardableResult public mutating func removeSubstring(_ string: String) -> String
	{
		guard !self.isEmpty && !string.isEmpty else { return self }
		while self.contains(string)
		{
			let index: Int = self.indexesOfSubstring(string)[0]
			self.removeSubstringInRange(index ... index + string.lastIndex!)
		}
		return self
	}
	
	/// StringKit: Removes all whitespaces and new lines and returns a transient result string.
	public func removedSpacesAndNewLines() -> String
	{
		return self.replacedSubstring(" ", withString: "").replacedSubstring("\n", withString: "")
	}
	
	/// StringKit: Removes all whitespaces and new lines and returns a result string (possible).
	@discardableResult public mutating func removeSpacesAndNewLines() -> String
	{
		self = self.replacedSubstring(" ", withString: "").replacedSubstring("\n", withString: "")
		return self
	}
	
	public func removedPunctuation() -> String
	{
		return self.components(separatedBy: .punctuationCharacters)
			.joined()
			.components(separatedBy: .whitespaces)
			.filter({ !$0.isEmpty })
			.joined(separator: " ")
	}
	
	@discardableResult public mutating func removePunctuation() -> String
	{
		self = self.components(separatedBy: .punctuationCharacters)
			.joined()
			.components(separatedBy: .whitespaces)
			.filter({ !$0.isEmpty })
			.joined(separator: " ")
		return self
	}
	
	public mutating func reverse()
	{
		self = String(self.characters.reversed())
	}
	
	public func reversed() -> String
	{
		return String(self.characters.reversed())
	}
	
	public func paddedLeft(string: String, times: Int = 1) -> String
	{
		return times * string + self
	}
	
	@discardableResult public mutating func padLeft(string: String, times: Int = 1) -> String
	{
		self = times * string + self
		return self
	}
	
	public func paddedRight(string: String, times: Int = 1) -> String
	{
		return self + times * string
	}
	
	@discardableResult public mutating func padRight(string: String, times: Int = 1) -> String
	{
		self = self + times * string
		return self
	}
	
	public func padded(string: String, times: Int = 1) -> String
	{
		return times * string + self + times * string
	}
	
	@discardableResult public mutating func pad(string: String, times: Int = 1) -> String
	{
		self = times * string + self + times * string
		return self
	}
	
	public mutating func trim() -> String
	{
		self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return self
	}
	
	public var trimmed: String
	{
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	public mutating func trimLeft() -> String
	{
		guard !self.isEmpty else { return String() }
		while CharacterSet.whitespacesAndNewlines.contains(UnicodeScalar.init(self[0])!) && self.length > 0 { self.removeCharacterAtIndex(0) }
		return self
	}
	
	public var trimmedLeft: String
	{
		guard !self.isEmpty else { return String() }
		var resultString: String = self
		while CharacterSet.whitespacesAndNewlines.contains(UnicodeScalar.init(resultString[0])!) && resultString.length > 0 { resultString.removeCharacterAtIndex(0) }
		return resultString
	}
	
	public mutating func trimRight() -> String
	{
		guard !self.isEmpty else { return String() }
		while CharacterSet.whitespacesAndNewlines.contains(UnicodeScalar.init(self[self.lastIndex!])!) && self.length > 0 { self.removeCharacterAtIndex(self.lastIndex!) }
		return self
	}
	
	public var trimmedRight: String
	{
		guard !self.isEmpty else { return String() }
		var resultString: String = self
		while CharacterSet.whitespacesAndNewlines.contains(UnicodeScalar.init(resultString[resultString.lastIndex!])!) && resultString.length > 0 { resultString.removeCharacterAtIndex(resultString.lastIndex!) }
		return resultString
	}
	
	public mutating func truncateLeft(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOfSubstring(string).contains(0) else { return self }
		self = self[string.length ... self.lastIndex!]
		return self
	}
	
	public func truncatedLeft(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOfSubstring(string).contains(0) else { return self }
		return self[string.length ... self.lastIndex!]
	}
	
	public mutating func truncateRight(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOfSubstring(string).contains(self.length - string.length) else { return self }
		self = self[string.length ... self.lastIndex!]
		return self
	}
	
	public func truncatedRight(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOfSubstring(string).contains(self.length - string.length) else { return self }
		return self[string.length ... self.lastIndex!]
	}
	
	public mutating func ensureLeft(_ string: String) -> String
	{
		guard !self.hasPrefix(string) else { return String() }
		return self.appendLeft(string)
	}
	
	public mutating func ensureRight(_ string: String) -> String
	{
		guard !self.hasSuffix(string) else { return String() }
		return self.appendRight(string)
	}
	
	public mutating func repeateSelf(times: Int = 2) -> String
	{
		self = String(repeating: self, count: times)
		return self
	}
	
	public mutating func repeatedSelf(times: Int = 2) -> String
	{
		return String(repeating: self, count: times)
	}
	
	public mutating func capitalize() -> String
	{
		guard !self.isEmpty else { return String() }
		self = self.capitalized
		return self
	}
	
	public mutating func lowerCase() -> String
	{
		guard !self.isEmpty else { return String() }
		self = self.lowercased()
		return self
	}
	
	public mutating func upperCase() -> String
	{
		guard !self.isEmpty else { return String() }
		self = self.uppercased()
		return self
	}
	
	/// Returns a camelcased string.
	public mutating func camelCased() -> String
	{
		guard !self.isEmpty else { return self }
		var splittedString: Array<String> = self.capitalized.components(separatedBy: " ")
		splittedString[0] = splittedString[0].lowercased()
		self = splittedString.joined(separator: "")
		return self
	}
	
	/// Camelcase a string.
	public var camelCase: String
	{
		guard !self.isEmpty else { return self }
		var splittedString: Array<String> = self.capitalized.components(separatedBy: " ")
		splittedString[0] = splittedString[0].lowercased()
		return splittedString.joined(separator: "")
	}
	
	public mutating func pascalize() -> String
	{
		guard !self.isEmpty else { return self }
		self = self.capitalized.components(separatedBy: " ").joined(separator: "")
		return self
	}
	
	public var pascalized: String
	{
		guard !self.isEmpty else { return self }
		return self.capitalized.components(separatedBy: " ").joined(separator: "")
	}
	
	/// SwifterSwift: Latinized string.
	public var latinized: String {
		return folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	
	/// StringKit: Returns a slugified String.
	public func slugified() -> String?
	{
		guard !self.isEmpty else { return self }
		let allowedCharacters: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
		if self.applyingTransform(StringTransform.toLatin, reverse: false) != nil && self.applyingTransform(StringTransform.stripCombiningMarks, reverse: false) != nil
		{
			var result: String = self.applyingTransform(StringTransform.toLatin, reverse: false)!
			result = result.applyingTransform(StringTransform.stripCombiningMarks, reverse: false)!
			return result
				.components(separatedBy: allowedCharacters.inverted)
				.filter({ $0 != "" })
				.joined(separator: "-")
		}
		return self
	}
	
	/// StringKit: Returns a slugified String.
	@discardableResult public mutating func slugify() -> String?
	{
		guard !self.isEmpty else { return self }
		let allowedCharacters: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
		if self.applyingTransform(StringTransform.toLatin, reverse: false) != nil && self.applyingTransform(StringTransform.stripCombiningMarks, reverse: false) != nil
		{
			self = self.applyingTransform(StringTransform.toLatin, reverse: false)!
			self = self.applyingTransform(StringTransform.stripCombiningMarks, reverse: false)!
			return self
				.components(separatedBy: allowedCharacters.inverted)
				.filter({ $0 != "" })
				.joined(separator: "-")
		}
		return self
	}
	
	//  MARK: Operators
	
	/// StringKit: Repeats a given string multiple times and returns the result.
	///
	/// - Parameters:
	///		- string: The string to repeat.
	///		- count: The number of times to repeat the given string.
	public static func *(string: String, count: Int) -> String
	{
		guard count > 0 else { return String() }
		return String(repeating: string, count: count)
	}
	
	/// StringKit: Repeats a given string multiple times and returns the result.
	///
	/// - Parameters:
	///		- count: The number of times to repeat the given string.
	///		- string: The string to repeat.
	public static func *(count: Int, string: String) -> String
	{
		guard count > 0 else { return String() }
		return String(repeating: string, count: count)
	}
}

//  MARK: String-Conversion-Extension
public extension String
{
	/// StringKit: Joins the elements of an array with a given string and returns a transient result.
	///
	/// - Parameters:
	///		- elements: The elements to join with the given string.
	public func joined<T: Collection>(_ elements: T) -> String
	{
		return elements.map({ String(describing: $0) }).joined(separator: self)
	}
	
	/// StringKit: Joins the elements of an array with a given string and returns the result.
	///
	/// - Parameters:
	///		- elements: The elements to join with the given string.
	@discardableResult public mutating func join<T: Collection>(_ elements: T) -> String
	{
		self = elements.map({ String(describing: $0) }).joined(separator: self)
		return self
	}
	
	/// StringKit: Returns an array with the ASCII values for any character in a string.
	public var ASCIIArray: Array<Int>
	{
		guard !self.isEmpty else { return Array<Int>() }
		return unicodeScalars.filter({ $0.isASCII }).map({ Int($0.value) })
	}
	
	/// StringKit: Returns an array with the unicode scalars for any character in a string.
	public var unicodeArray: Array<Int>
	{
		guard !self.isEmpty else { return Array<Int>() }
		return unicodeScalars.map({ $0.hashValue} )
	}
	
	/// StringKit: Returns a string encoded in base64.
	public func base64Encoded() -> String?
	{
		guard !self.isEmpty else { return nil }
		return data(using: .utf8)?.base64EncodedString()
	}
	
	/// StringKit: Encodes a string in base64.
	@discardableResult public mutating func base64Encode() -> String?
	{
		guard !self.isEmpty, let base64: String = self.data(using: .utf8)?.base64EncodedString() else { return nil }
		self = base64
		return self
	}
	
	/// StringKit: Returns a string decoded from base64.
	public func base64Decoded() -> String?
	{
		guard !self.isEmpty, let decodedData: Data = Data(base64Encoded: self) else { return nil }
		return String(data: decodedData, encoding: .utf8)
	}
	
	/// StringKit: Decodes a string from base64.
	@discardableResult public mutating func base64Decode() -> String?
	{
		guard !self.isEmpty, let decodedData: Data = Data(base64Encoded: self), let result = String(data: decodedData, encoding: .utf8) else { return nil }
		self = result
		return self
	}
	
	/// StringKit: Encodes a string in URL format (if applicable) and returns a transient result.
	public func urlEncoded() -> String?
	{
		guard !self.isEmpty else { return nil }
		return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
	}
	
	/// StringKit: Encodes a string in URL format (if applicable) and returns the result (possible).
	@discardableResult public mutating func urlEncode() -> String?
	{
		guard !self.isEmpty, let encodedData: String = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
		self = encodedData
		return self
	}

	/// StringKit: Decodes a string from URL format and returns a transient result.
	public func urlDecoded() -> String?
	{
		guard !self.isEmpty else { return nil }
		return self.removingPercentEncoding
	}

	/// StringKit: Decodes a string from URL format (if applicable) and returns the result.
	@discardableResult public mutating func urlDecode() -> String?
	{
		guard !self.isEmpty, let decodedData: String = self.removingPercentEncoding else { return nil }
		self = decodedData
		return self
	}
	
	/// StringKit: Returns the Bool value of string.
	public var boolValue: Bool?
	{
		let selfLowercased: String = self.trimmed.lowercased()
		if selfLowercased == "true" || selfLowercased == "1" || selfLowercased == "right"
		{
			return true
		}
		else if selfLowercased == "false" || selfLowercased == "0" || selfLowercased == "wrong"
		{
			return false
		}
		return nil
	}
	
	/// StringKit: Returns a Date object in format of "yyyy-MM-dd".
	public var dateValue: Date?
	{
		let selfLowerCased: String = self.trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: selfLowerCased)
	}
	
	/// StringKit: Returns a Date object in format of "yyyy-MM-dd HH:mm:ss".
	public var dateTimeValue: Date?
	{
		let selfLowerCased: String = self.trimmed.lowercased()
		let formatter: DateFormatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter.date(from: selfLowerCased)
	}
	
	/// StringKit: Converts a string of date format to a date object (if applicable) and returns the result.
	///
	/// - Parameters:
	///		- format: The format of the target date object.
	public func dateWithFormat(_ format: String) -> Date?
	{
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: self)
	}
	
	/// StringKit: Returns the Double value from a string.
	public var doubleValue: Double?
	{
		let formatter: NumberFormatter = NumberFormatter()
		return formatter.number(from: self) as? Double
	}
	
	/// StringKit: Returns the Float value from a string.
	public var floatValue: Float?
	{
		let formatter: NumberFormatter = NumberFormatter()
		return formatter.number(from: self) as? Float
	}
	
	/// StringKit: Returns the Float32 value from a string.
	public var float32Value: Float32?
	{
		let formatter: NumberFormatter = NumberFormatter()
		return formatter.number(from: self) as? Float32
	}
	
	/// StringKit: Returns the Float64 value from a string.
	public var float64Value: Float64?
	{
		let formatter: NumberFormatter = NumberFormatter()
		return formatter.number(from: self) as? Float64
	}
	
	/// StringKit: Returns the Decimal value from a string.
	public var decimalValue: Decimal?
	{
		let formatter: NumberFormatter = NumberFormatter()
		return formatter.number(from: self) as? Decimal
	}
	
	/// StringKit: Returns the UInt value from a string.
	public var UIntValue: UInt?
	{
		return UInt(self)
	}
	
	/// StringKit: Returns the UInt8 value from a string.
	public var UInt8Value: UInt8?
	{
		return UInt8(self)
	}
	
	/// StringKit: Returns the UInt16 value from a string.
	public var UInt16Value: UInt16?
	{
		return UInt16(self)
	}
	
	/// StringKit: Returns the UInt32 value from a string.
	public var UInt32Value: UInt32?
	{
		return UInt32(self)
	}
	
	/// StringKit: Returns the UInt64 value from a string.
	public var UInt64Value: UInt64?
	{
		return UInt64(self)
	}
	
	/// StringKit: Returns the Int value from a string.
	public var intValue: Int?
	{
		return Int(self)
	}
	
	/// StringKit: Returns the Int8 value from a string.
	public var int8Value: Int8?
	{
		return Int8(self)
	}
	
	/// StringKit: Returns the Int16 value from a string.
	public var int16Value: Int16?
	{
		return Int16(self)
	}
	
	/// StringKit: Returns the Int32 value from a string.
	public var int32Value: Int32?
	{
		return Int32(self)
	}
	
	/// StringKit: Returns the Int64 value from a string.
	public var int64Value: Int64?
	{
		return Int64(self)
	}
	
	/// StringKit: Returns the URL value from a string.
	public var urlValue: URL?
	{
		return URL(string: self)
	}
}

//  MARK: String-Creation-Extension
public extension String
{
	//  MARK: Initializers
	
	/// StringKit: Creates a new string from a base64 string (if applicable).
	///
	/// - Parameters: 
	///		- base64: The base64 string.
	public init?(base64: String)
	{
		guard let string: String = base64.base64Decoded() else { return nil }
		self.init(string)
	}
	
	/// StringKit: Creates a new, random string of a given length.
	///
	/// - Parameters: 
	///		- length: The number of characters in the target string.
	public init(randomOfLength length: Int)
	{
		self = String.random(ofLength: length)
	}
	
	//  MARK: Methods
	
	/// StringKit: Creates a string of a given length and returns the result.
	///
	/// - Parameters:
	///		- length: The number of characters in the string.
	public static func random(ofLength length: Int) -> String
	{
		guard length > 0 else { return String() }
		let base: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		return (0 ..< length).reduce(String())
		{
			let randomIndex: UInt32 = arc4random_uniform(UInt32(base.characters.count))
			let randomCharacter: String = "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
			return $0.0 + randomCharacter
		}
	}
}

//  MARK: String-Functionality-Extension
public extension String
{
	#if os(iOS) || os(macOS)
	/// StringKit: Copies a string to the global pasteboard.
	public func copyToPasteboard()
	{
		#if os(iOS)
			UIPasteboard.general.string = self
		#elseif os(macOS)
			NSPasteboard.general().clearContents()
			NSPasteboard.general().setString(self, forType: NSPasteboardTypeString)
		#endif
	}
	#endif
}

//  MARK: Supporting-Int-Extension
public extension Int
{
	public static func ...(left: Int, right: Int) -> CountableClosedRange<Int>
	{
		return CountableClosedRange<Int>.init(uncheckedBounds: (lower: left, upper: right))
	}
	
	public static func ..<(left: Int, right: Int) -> CountableRange<Int>
	{
		return CountableRange<Int>.init(uncheckedBounds: (lower: left, upper: right))
	}
}


/*
move

swap

indexesOf

between

startsLowerCase
startsUpperCase
endsLowerCase
endsUpperCase
*/
