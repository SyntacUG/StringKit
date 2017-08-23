//
//  SKInvestigation.swift
//  StringKit 0.9.0
//
//  Legend:
//  if applicable:		Nil values are possible.
//  safe:				Errors can't happen.
//  discardable:		Discardable result.
//  optional:			Parameter not required.
//  default:			Explains the standard value.
//  like:				Shows a possible example.
//  independet:			The property or method can be used independently from the framework.
//
//  Created by:
//  - Rainer Niemann, rainerniemann@icloud.com 
//  - Andreas Niemann, andreasniemann1999@icloud.com
//
//  This project is licensed under the MIT License. See the LICENSE.md file for details.
//

//  MARK: IMPORTS - TESTED
import Foundation

//  MARK: STRING INVESTIGATION EXTENSION - TESTED
public extension String
{
	/// StringKit: Checks if a string is numeric.
	public var isNumeric: Bool
	{
		guard !self.isEmpty && self.containsNumber && !self.containsLetter else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is alphabetic.
	public var isAlphabetic: Bool
	{
		guard !self.isEmpty && !self.containsNumber && self.containsLetter else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is alphanumeric.
	public var isAlphaNumeric: Bool
	{
		guard !self.isEmpty && self.containsNumber || self.containsLetter else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is lower case.
	public var isLowerCase: Bool
	{
		guard !self.isEmpty && self == self.lowercased() else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is upper case.
	public var isUpperCase: Bool
	{
		guard !self.isEmpty && self == self.uppercased() else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid palindrom.
	public var isValidPalindrom: Bool
	{
		guard !self.isEmpty && isAlphaNumeric && self == String(self.characters.reversed()) else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid e-mail.
	public var isValidEmail: Bool
	{
		guard !self.isEmpty && self.matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}") else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid URL.
	public var isValidUrl: Bool
	{
		guard !self.isEmpty && URL(string: self) != nil else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid schemed URL.
	public var isValidSchemedUrl: Bool
	{
		guard !self.isEmpty && URL(string: self)?.scheme != nil else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid HTTP URL.
	public var isValidHttpUrl: Bool
	{
		guard !self.isEmpty && URL(string: self)?.scheme == "http" else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid HTTPS URL.
	public var isValidHttpsUrl: Bool
	{
		guard !self.isEmpty && URL(string: self)?.scheme == "https" else { return false }
		return true
	}
	
	/// StringKit: Checks if a string is a valid file URL.
	public var isValidFileUrl: Bool
	{
		guard !self.isEmpty && URL(string: self)?.isFileURL ?? false else { return false }
		return true
	}
	
	/// StringKit: Checks if a string contains at least one number.
	public var containsNumber: Bool
	{
		guard !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits, options: CompareOptions.numeric, range: nil) != nil else { return false }
		return true
	}
	
	/// StringKit: Checks if a string contains at least one letter.
	public var containsLetter: Bool
	{
		guard !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.letters, options: CompareOptions.literal, range: nil) != nil else { return false }
		return true
	}
	
	/// StringKit: Checks if a string contains at least one punctuation character.
	public var containsPunctuation: Bool
	{
		guard !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.punctuationCharacters, options: CompareOptions.literal, range: nil) != nil else { return false }
		return true
	}
	
	/// StringKit: Checks if a string contains at least one emoji character.
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
	
	/// StringKit: Checks if a string contains one repetitive character and returns it (if applicable).
	///
	/// - Parameters:
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func containsSameCharacter(caseSensitive: Bool = true) -> String?
	{
		guard !self.isEmpty else { return nil }
		let selfString: String = caseSensitive ? self : self.lowercased()
		let repetitiveCharacter: String = caseSensitive ? self.firstCharacter! : self.firstCharacter!.lowercased()
		guard selfString == String(repeating: repetitiveCharacter, count: self.length) else { return nil }
		return repetitiveCharacter
	}
	
	/// StringKit: Checks if a string contains a repetitive substring and returns it (if applicable).
	///
	/// - Parameters:
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func containsRepetitiveSubstring(caseSensitive: Bool = true) -> String?
	{
		guard !self.isEmpty && self.length > 1 else { return nil }
		
		let length: Int = self.length
		var repetitiveSubstring: String? = nil
		var substringLengths: Array<Int> = findDivisors(number: length).sorted()
		let originalString: String = caseSensitive ? self : self.lowercased()
		
		substringLengths.removeLast()
		
		for substringLength in substringLengths
		{
			let substring = caseSensitive ? self[0 ..< substringLength] : self[0 ..< substringLength].lowercased()
			
			if originalString == String(repeating: substring, count: length / substringLength)
			{
				repetitiveSubstring = caseSensitive ? substring : substring.lowercased()
				break
			}
		}
		
		return repetitiveSubstring
	}
	
	/// StringKit: Checks if a string contains one or more instance of a substring.
	///
	/// - Parameters:
	///   - substring: The substring to search for.
	///   - caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func contains(substring: String, caseSensitive: Bool = true) -> Bool
	{
		guard !self.isEmpty else { return false }
		
		if !caseSensitive
		{
			return range(of: substring, options: .caseInsensitive) != nil
		}
		
		return range(of: substring) != nil
	}
	
	/// StringKit: Checks if a string starts with a number.
	public var startsWithNumber: Bool
	{
		guard !self.isEmpty && self.firstCharacter!.containsNumber else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts with a letter.
	public var startsWithLetter: Bool
	{
		guard !self.isEmpty && self.firstCharacter!.containsLetter else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts with a punctuation character.
	public var startsWithPunctuation: Bool
	{
		guard !self.isEmpty && self.firstCharacter!.containsPunctuation else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts with a emoji character.
	public var startsWithEmoji: Bool
	{
		guard !self.isEmpty && self.firstCharacter!.containsEmoji else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts lower case.
	public var startsLowerCase: Bool
	{
		guard !self.isEmpty && self.firstCharacter! == self.firstCharacter!.lowercased() else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts upper case.
	public var startsUpperCase: Bool
	{
		guard !self.isEmpty && self.firstCharacter! == self.firstCharacter!.uppercased() else { return false }
		return true
	}
	
	/// StringKit: Checks if a string starts with a given substring.
	///
	/// - Parameters:
	///		- substring: The substring to check.
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func startsWith(substring: String, caseSensitive: Bool = true) -> Bool
	{
		guard !self.isEmpty && !substring.isEmpty && self.length >= substring.length else { return false }
		
		if !caseSensitive
		{
			return self.substring(inRange: 0 ... substring.lastIndex!).lowercased() == substring.lowercased()
		}
		
		return self.substring(inRange: 0 ... substring.lastIndex!) == substring
	}
	
	/// StringKit: Checks if a string ends with a number.
	public var endsWithNumber: Bool
	{
		guard !self.isEmpty && self.lastCharacter!.containsNumber else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends with a letter.
	public var endsWithLetter: Bool
	{
		guard !self.isEmpty && self.lastCharacter!.containsLetter else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends with a punctuation character.
	public var endsWithPunctuation: Bool
	{
		guard !self.isEmpty && self.lastCharacter!.containsPunctuation else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends with a emoji character.
	public var endsWithEmoji: Bool
	{
		guard !self.isEmpty && self.lastCharacter!.containsEmoji else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends lower case.
	public var endsLowerCase: Bool
	{
		guard !self.isEmpty && self.lastCharacter! == self.lastCharacter!.lowercased() else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends upper case.
	public var endsUpperCase: Bool
	{
		guard !self.isEmpty && self.lastCharacter! == self.lastCharacter!.uppercased() else { return false }
		return true
	}
	
	/// StringKit: Checks if a string ends with a given substring.
	///
	/// - Parameters:
	///		- substring: The substring to check.
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func endsWith(substring: String, caseSensitive: Bool = true) -> Bool
	{
		guard !self.isEmpty && !substring.isEmpty && self.length >= substring.length else { return false }
		
		if !caseSensitive
		{
			return self.substring(inRange: self.lastIndex! - substring.lastIndex! ... self.lastIndex!).lowercased() == substring.lowercased()
		}
		
		return self.substring(inRange: self.lastIndex! - substring.lastIndex! ... self.lastIndex!) == substring
	}
	
	/// StringKit: Returns an array of the most common numbers in a string.
	public func mostCommonNumber() -> Array<String>
	{
		guard !self.isEmpty && self.containsNumber else { return Array<String>() }
		
		var counts: Dictionary<Character, Int> = Dictionary<Character, Int>()
		var commonNumbers: Array<Character> = Array<Character>()
		var maxCount: Int = Int()
		
		for character in self.removedSpacesAndNewLines().characters
		{
			if String(character).containsNumber
			{
				if let count = counts[character]
				{
					counts[character] = count + 1
				}
				else
				{
					counts[character] = 1
				}
			}
		}
		
		for (character, count) in counts
		{
			if count > maxCount
			{
				maxCount = count
				commonNumbers = [character]
			}
			else if count == maxCount
			{
				commonNumbers.append(character)
			}
		}
		
		return commonNumbers.map({ String($0) }).sorted()
	}
	
	/// StringKit: Returns an array of the most common letters in a string.
	///
	/// - Parameters
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func mostCommonLetter(caseSensitive: Bool = true) -> Array<String>
	{
		guard !self.isEmpty && self.containsLetter else { return Array<String>() }
		
		var counts: Dictionary<Character, Int> = Dictionary<Character, Int>()
		var commonLetters: Array<Character> = Array<Character>()
		var maxCount: Int = Int()
		
		for character in caseSensitive ? self.removedSpacesAndNewLines().characters : self.removedSpacesAndNewLines().lowercased().characters
		{
			if String(character).containsLetter
			{
				if let count = counts[character]
				{
					counts[character] = count + 1
				}
				else
				{
					counts[character] = 1
				}
			}
		}
		
		for (character, count) in counts
		{
			if count > maxCount
			{
				maxCount = count
				commonLetters = [character]
			}
			else if count == maxCount
			{
				commonLetters.append(character)
			}
		}
		
		return commonLetters.map({ String($0) }).sorted()
	}
	
	/// StringKit: Returns an array of the most common punctuation characters in a string.
	public func mostCommonPunctuationCharacter() -> Array<String>
	{
		guard !self.isEmpty && self.containsPunctuation else { return Array<String>() }
		
		var counts: Dictionary<Character, Int> = Dictionary<Character, Int>()
		var commonPunctuationCharacters: Array<Character> = Array<Character>()
		var maxCount: Int = Int()
		
		for character in self.removedSpacesAndNewLines().characters
		{
			if String(character).containsPunctuation
			{
				if let count = counts[character]
				{
					counts[character] = count + 1
				}
				else
				{
					counts[character] = 1
				}
			}
		}
		
		for (character, count) in counts
		{
			if count > maxCount
			{
				maxCount = count
				commonPunctuationCharacters = [character]
			}
			else if count == maxCount
			{
				commonPunctuationCharacters.append(character)
			}
		}
		
		return commonPunctuationCharacters.map({ String($0) }).sorted()
	}
	
	/// StringKit: Returns an array of the most common emojis in a string.
	public func mostCommonEmoji() -> Array<String>
	{
		guard !self.isEmpty && self.containsEmoji else { return Array<String>() }
		
		var counts: Dictionary<Character, Int> = Dictionary<Character, Int>()
		var commonPunctuationCharacters: Array<Character> = Array<Character>()
		var maxCount: Int = Int()
		
		for character in self.removedSpacesAndNewLines().characters
		{
			if String(character).containsEmoji
			{
				if let count = counts[character]
				{
					counts[character] = count + 1
				}
				else
				{
					counts[character] = 1
				}
			}
		}
		
		for (character, count) in counts
		{
			if count > maxCount
			{
				maxCount = count
				commonPunctuationCharacters = [character]
			}
			else if count == maxCount
			{
				commonPunctuationCharacters.append(character)
			}
		}
		
		return commonPunctuationCharacters.map({ String($0) }).sorted()
	}
	
	/// StringKit: Returns an array of the most common characters in a string.
	///
	/// - Parameters
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	///		- ignoreSpacesAndNewLines: The possibility to ignore whitespaces and new lines (optional, default: true).
	public func mostCommonCharacter(caseSensitive: Bool = true, ignoreSpacesAndNewLines: Bool = true) -> Array<String>
	{
		guard !self.isEmpty else { return Array<String>() }
		
		var counts: Dictionary<Character, Int> = Dictionary<Character, Int>()
		var commonCharacters: Array<Character> = Array<Character>()
		var maxCount: Int = Int()
		var selfString: String = ignoreSpacesAndNewLines ? self.removedSpacesAndNewLines() : self
		selfString = caseSensitive ? selfString : selfString.lowercased()
		
		for character in selfString.characters
		{
			if let count = counts[character]
			{
				counts[character] = count + 1
			}
			else
			{
				counts[character] = 1
			}
		}
		
		for (character, count) in counts
		{
			if count > maxCount
			{
				maxCount = count
				commonCharacters = [character]
			}
			else if count == maxCount
			{
				commonCharacters.append(character)
			}
		}

		return commonCharacters.map({ String($0) }).sorted()
	}
	
	/// StringKit: Returns an array containing the single characters of a string.
	public var characterArray: Array<String>
	{
		guard !self.isEmpty else { return Array<String>() }
		return self.characters.map({ String($0) })
	}
	
	/// StringKit: Returns the number of characters contained in a string.
	public var length: Int
	{
		guard !self.isEmpty else { return 0 }
		return self.characters.count
	}
	
	/// StringKit: Returns the last index of a string (if applicable).
	public var lastIndex: Int?
	{
		guard !self.isEmpty else { return nil }
		return self.length - 1
	}
	
	/// StringKit: Returns an array of strings representing the words in a string.
	public var words: Array<String>
	{
		guard !self.isEmpty else { return Array<String>() }
		let chararacterSet: CharacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let components: Array<String> = self.components(separatedBy: chararacterSet)
		return components.filter { !$0.isEmpty }
	}
	
	/// StringKit: Returns the number of words in a string.
	public var wordsCount: Int
	{
		return self.words.count
	}
	
	/// StringKit: Returns an array of strings separated by new lines.
	public var lines: Array<String>
	{
		guard !self.isEmpty else { return Array<String>() }
		var resultArray: Array<String> = Array<String>()
		self.enumerateLines
			{ line, _ in
				resultArray.append(line)
		}
		return resultArray
	}
	
	/// StringKit: Returns the first character of a string (if applicable).
	public var firstCharacter: String?
	{
		guard !self.isEmpty else { return nil }
		return self.character(atIndex: 0)
	}
	
	/// StringKit: Returns the last character of a string (if applicable).
	public var lastCharacter: String?
	{
		guard !self.isEmpty else { return nil }
		return self.character(atIndex: self.lastIndex!)
	}
	
	/// StringKit: Returns the n-th character of a string (safe).
	///
	/// - Parameters:
	///		- index: The index of the character that is tried to be accessed.
	///		- infinite: The possibility to move over a string until infinity (optional, default: false).
	public func character(atIndex index: Int, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self.substring(inRange: index ... index, infinite: true)
		}
		else
		{
			return self.substring(inRange: index ... index)
		}
	}
	
	/// StringKit: Returns the n-th character of a string beginning from the left side (safe).
	///
	/// - Parameters:
	///		- index: The index of the character that is tried to be accessed (optional, default: 0).
	///		- infinite: The possibility to move over a string until infinity (optional, default: false).
	public func characterFromLeft(atIndex index: Int = 0, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self.character(atIndex: index, infinite: true)
		}
		else
		{
			return self.character(atIndex: index)
		}
	}
	
	/// StringKit: Returns the n-th character of a string beginning from the right side (safe).
	///
	/// - Parameters:
	///		- index: The index of the character that is tried to be accessed (optional, default: 0).
	///		- infinite: The possibility to move over a string until infinity (optional, default: false).
	public func characterFromRight(atIndex index: Int = 0, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self.character(atIndex: self.lastIndex! - index, infinite: true)
		}
		else
		{
			return self.character(atIndex: self.lastIndex! - index)
		}
	}
	
	/// StringKit: Returns a substring beginning from the left side up to an given index (safe).
	///
	/// - Parameters:
	///		- index: The end index of the substring that is tried to be accessed (optional, default: 0).
	///		- infinite: The possibility to move over a string until infinity (optional, default: false).
	public func substringFromLeft(toIndex index: Int = 0, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			return self.substring(inRange: 0 ... index, infinite: true)
		}
		else
		{
			return self.substring(inRange: 0 ... index)
		}
	}
	
	/// StringKit: Returns a substring beginning from n - index up to the right side (safe).
	///
	/// - Parameters:
	///		- index: The start index from the right side of the substring that is tried to be accessed (optional, default: 0).
	///		- infinite: The possibility to move over a string until infinity (optional, default: false).
	public func substringFromRight(steps: Int = 0, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		if infinite
		{
			if steps < 0
			{
				return self.substring(inRange: self.lastIndex! ... self.lastIndex! + abs(steps), infinite: true)
			}
			else
			{
				return self.substring(inRange: self.lastIndex! - steps ... self.lastIndex!, infinite: true)
			}
		}
		else
		{
			return self.substring(inRange: self.lastIndex! - steps ... self.lastIndex!)
		}
	}
	
	/// StringKit: Returns a substring in range of a string (safe).
	///
	/// - Directions:
	///	- \+ ..< +
	///	- \- ..< -
	///	- \+ ..< - (reverse)
	///	- \- ..< +
	///
	/// - Parameters:
	///		- range: The range of the substring that is tried to be accessed.
	///		- infinite: The possibility to move over the string until infinity (default: false).
	public func substring(inRange range: CountableRange<Int>, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		var reversed: Bool = false
		var lowerBound: Int = Int()
		var upperBound: Int = Int()
		var result: String = String()
		
		reversed = range.lowerBound <= range.upperBound - 1 ? false : true
		lowerBound = range.lowerBound <= range.upperBound - 1 ? range.lowerBound : range.upperBound - 1
		upperBound = range.lowerBound <= range.upperBound - 1 ? range.upperBound - 1 : range.lowerBound
		
		if infinite && (lowerBound < 0 || upperBound >= self.length)
		{
			if lowerBound < 0
			{
				let correction: Int = self.length * Int(ceil(abs(Double(lowerBound)) / Double(self.length)))
				lowerBound = lowerBound + correction
				upperBound = upperBound + correction
			}
			
			if lowerBound == upperBound
			{
				result += String(self[self.index(self.startIndex, offsetBy: lowerBound % self.length)])
			}
			else
			{
				result += self[self.index(self.startIndex, offsetBy: lowerBound) ... self.index(self.startIndex, offsetBy: self.lastIndex!)]
				result += String(repeating: self, count: Int(Double(upperBound - lowerBound - result.length) / Double(self.length)))
				if result.lastIndex! < abs(lowerBound - upperBound)
				{
					result += self.substring(inRange: 0 ... (upperBound % self.length))
				}
			}
		}
		else
		{
			if lowerBound < 0 && upperBound < 0
			{
				lowerBound = 0
				upperBound = 0
			}
			else if lowerBound > self.lastIndex! && upperBound > self.lastIndex!
			{
				lowerBound = self.lastIndex!
				upperBound = self.lastIndex!
			}
			else
			{
				lowerBound = lowerBound < 0 ? 0 : lowerBound
				upperBound = upperBound > self.lastIndex! ? self.lastIndex! : upperBound
			}
			
			result = self[self.index(self.startIndex, offsetBy: lowerBound) ... self.index(self.startIndex, offsetBy: upperBound)]
		}
		
		if reversed
		{
			return result.reversed()
		}
		return result
	}
	
	/// StringKit: Returns a substring in range of a string (safe).
	///
	/// - Directions:
	///	- \+ ... +
	///	- \- ... -
	///	- \+ ... - (reverse)
	///	- \- ... +
	///
	/// - Parameters:
	///		- range: The range of the substring that is tried to be accessed.
	///		- infinite: The possibility to move over the string until infinity (default: false).
	public func substring(inRange range: CountableClosedRange<Int>, infinite: Bool = false) -> String
	{
		guard !self.isEmpty else { return String() }
		
		var reversed: Bool = false
		var lowerBound: Int = Int()
		var upperBound: Int = Int()
		var result: String = String()
		
		reversed = range.lowerBound <= range.upperBound ? false : true
		lowerBound = range.lowerBound <= range.upperBound ? range.lowerBound : range.upperBound
		upperBound = range.lowerBound <= range.upperBound ? range.upperBound : range.lowerBound
		
		if infinite && (lowerBound < 0 || upperBound >= self.length)
		{
			if lowerBound < 0
			{
				let correction: Int = self.length * Int(ceil(abs(Double(lowerBound)) / Double(self.length)))
				lowerBound = lowerBound + correction
				upperBound = upperBound + correction
			}
			
			if lowerBound == upperBound
			{
				result += String(self[self.index(self.startIndex, offsetBy: lowerBound % self.length)])
			}
			else
			{
				result += self[self.index(self.startIndex, offsetBy: lowerBound) ... self.index(self.startIndex, offsetBy: self.lastIndex!)]
				result += String(repeating: self, count: Int(Double(upperBound - result.length) / Double(self.length)))
				if result.lastIndex! < abs(lowerBound - upperBound)
				{
					result += self.substring(inRange: 0 ... (upperBound % self.length))
				}
			}
		}
		else
		{
			if lowerBound < 0 && upperBound < 0
			{
				lowerBound = 0
				upperBound = 0
			}
			else if lowerBound > self.lastIndex! && upperBound > self.lastIndex!
			{
				lowerBound = self.lastIndex!
				upperBound = self.lastIndex!
			}
			else
			{
				lowerBound = lowerBound < 0 ? 0 : lowerBound
				upperBound = upperBound > self.lastIndex! ? self.lastIndex! : upperBound
			}
			
			result = self[self.index(self.startIndex, offsetBy: lowerBound) ... self.index(self.startIndex, offsetBy: upperBound)]
		}
		
		if reversed
		{
			return result.reversed()
		}
		return result
	}
	
	/// StringKit: Returns an array of substrings in a certain length in range of string (safe).
	///
	/// - Parameters:
	///		- length: The length of the substrings.
	public func substrings(ofLength length: Int) -> Array<String>
	{
		guard !self.isEmpty && length > 0 else { return Array<String>() }
		return self.splitted(inSubstringsOfLength: length, inRange: 0 ... self.lastIndex!)
	}
	
	/// StringKit: Returns an array of substrings in a certain length in range of string (safe).
	///
	/// - Parameters:
	///		- length: The length of the substrings.
	///		- range: The range of the substring to split.
	public func substrings(ofLength length: Int, inRange range: CountableRange<Int>) -> Array<String>
	{
		guard !self.isEmpty && length > 0 else { return Array<String>() }
		return self.splitted(inSubstringsOfLength: length, inRange: range)
	}
	
	/// StringKit: Returns an array of substrings in a given length in range of string (safe).
	///
	/// - Parameters:
	///		- length: The length of the substrings.
	///		- range: The range of the substring to split.
	public func substrings(ofLength length: Int, inRange range: CountableClosedRange<Int>) -> Array<String>
	{
		guard !self.isEmpty && length > 0 else { return Array<String>() }
		return self.splitted(inSubstringsOfLength: length, inRange: range)
	}
	
	/// StringKit: Returns the number of occurrences matches a given substring.
	///
	/// - Parameters:
	///		- substring: The substring the count is searched for.
	///		- overlap: The possibility to search also for overlapping substrings (like: testest -> count: 2; optional, default: true).
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	public func count(substring: String, withOverlap overlap: Bool = true, caseSensitive: Bool = true) -> Int
	{
		guard !self.isEmpty else { return 0 }
		
		if overlap
		{
			if !caseSensitive
			{
				return self.indexesOf(substring: substring, withOverlap: true, caseSensitive: false).count
			}
			
			return self.indexesOf(substring: substring, withOverlap: true, caseSensitive: true).count
		}
		else
		{
			if !caseSensitive
			{
				return lowercased().components(separatedBy: substring.lowercased()).count - 1
			}
			
			return components(separatedBy: substring).count - 1
		}
	}
	
	/// StringKit: Returns an array with indexes of substrings matches a given substring (safe).
	///
	/// - Parameters:
	///		- substring: The substring the indexes are searched for.
	///		- overlapBool: The possibility to search also for overlapping substrings (like: "testest" -> indexes: [0, 3]; optional, default: true).
	///		- caseSensitive: The possibility to search case sensitive (optional, default: true).
	func indexesOf(substring: String, withOverlap overlapBool: Bool = true, caseSensitive: Bool = true) -> Array<Int>
	{
		guard !self.isEmpty && !substring.isEmpty && self.length >= substring.length else { return Array<Int>() }
		guard substring != self else { return [0] }
		
		var selfString: String = caseSensitive ? self : self.lowercased()
		var substring: String = caseSensitive ? substring : substring.lowercased()
		
		func calculateOverlap() -> Int
		{
			var overlapIndex: Int = 0
			while substring[overlapIndex] == substring[substring.lastIndex! - overlapIndex]
			{
				overlapIndex += 1
				guard overlapIndex <= substring.lastIndex! else { return overlapIndex }
			}
			return overlapIndex
		}
		
		var resultArray: Array<Int> = Array<Int>()
		let substringLastIndex: Int = substring.lastIndex!
		var index: Int = substringLastIndex
		let overlap: Int = overlapBool ? calculateOverlap() : 0
		
		if selfString.containsSameCharacter() != nil && substring.containsSameCharacter() != nil && overlapBool
		{
			resultArray = Array<Int>(0 ... selfString.length - substring.length)
		}
		else
		{
			if substring.length == 1
			{
				for (index, character) in selfString.characters.enumerated()
				{
					guard substring.firstCharacter! == String(character) else { continue }
					resultArray.append(index)
				}
			}
			else if substring.length == 2 && selfString.length > 1 && selfString.containsSameCharacter() != nil
			{
				index -= 1
				while index < selfString.lastIndex!
				{
					if substring == selfString.substring(inRange: index ... index + 1) { resultArray.append(index) }
					index = overlapBool ? index + 1 : index + 2
				}
			}
			else
			{
				var currentIndex: Int = index
				var matchIndex: Int = substringLastIndex
				
				while index < selfString.length
				{
					if selfString.character(atIndex: currentIndex) == substring.character(atIndex: matchIndex)
					{
						matchIndex -= 1
						currentIndex -= 1
					}
					else
					{
						matchIndex = substringLastIndex
						index += 1
						currentIndex = index
					}
					
					if matchIndex == -1
					{
						resultArray.append(index - substringLastIndex)
						index += substringLastIndex + 1 - overlap
						currentIndex = index
						matchIndex = substringLastIndex
					}
				}
			}
		}
		
		return resultArray
	}
	
	/// StringKit: Checks if a string matches a regex pattern.
	///
	/// - Parameters:
	///		- pattern: The pattern to verify.
	func matches(pattern: String) -> Bool
	{
		return self.range(of: pattern, options: String.CompareOptions.regularExpression, range: nil, locale: nil) != nil
	}
	
	//  MARK: SUBSCRIPTS
	/// StringKit:
	/// - get: Returns the n-th character of a string (safe).
	/// - set: Replaces the n-th character with a given new one (safe).
	///
	/// - Parameters:
	///		- index: The index of the character that is tried to be accessed.
	public subscript(index: Int) -> String
	{
		get
		{
			return self.character(atIndex: index)
		}
	}
	
	/// StringKit:
	/// - get: Returns the n-th character of a string (safe).
	/// - set: Replaces the n-th character with a given new one (safe).
	///
	/// - Parameters:
	///		- index: The index of the character that is tried to be accessed.
	///		- infinite: The possibility to move over a string until infinity.
	public subscript(index: Int, infinite: Bool) -> String
	{
		get
		{
			return self.character(atIndex: index, infinite: infinite)
		}
	}
	
	/// StringKit:
	/// - get: Returns a substring in a specific range of a string (safe).
	/// - set: Replaces a substring with a given new one (safe).
	///
	/// - Parameters:
	///		- range: The range of the substring that is tried to be accessed.
	public subscript(range: CountableRange<Int>) -> String
	{
		get
		{
			return self.substring(inRange: range)
		}
	}
	
	/// StringKit:
	/// - get: Returns a substring in a specific range of a string (safe).
	/// - set: Replaces a substring with a given new one (safe).
	///
	/// - Parameters:
	///		- range: The range of the substring that is tried to be accessed.
	public subscript(range: CountableClosedRange<Int>) -> String
	{
		get
		{
			return self.substring(inRange: range)
		}
	}
	
	/// StringKit:
	/// - get: Returns a substring in a specific range of a string (safe).
	/// - set: Replaces a substring with a given new one (safe).
	///
	/// - Parameters:
	///		- range: The range of the substring that is tried to be accessed.
	///		- infinite: The possibility to move over a string until infinity.
	public subscript(range: CountableRange<Int>, infinite: Bool) -> String
	{
		get
		{
			return self.substring(inRange: range, infinite: infinite)
		}
	}
	
	/// StringKit:
	/// - get: Returns a substring in a specific range of a string (safe).
	/// - set: Replaces a substring with a given new one (safe).
	///
	/// - Parameters:
	///		- range: The range of the substring that is tried to be accessed.
	///		- infinite: The possibility to move over a string until infinity.
	public subscript(range: CountableClosedRange<Int>, infinite: Bool) -> String
	{
		get
		{
			return self.substring(inRange: range, infinite: infinite)
		}
	}
}
