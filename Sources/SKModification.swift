//
//  SKModification.swift
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

//  MARK: STRING MODIFICATION EXTENSION - NOT TESTED
public extension String
{
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
		guard !self.isEmpty && self.range(of: self)! ~= self.index(self.startIndex, offsetBy: index) else { return self }
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
		guard !self.isEmpty && self.range(of: self)! ~= self.index(self.startIndex, offsetBy: index) else { return self }
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
			let index: Int = self.indexesOf(substring: string)[0]
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
			let index: Int = self.indexesOf(substring: string)[0]
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
	
	public func splitted(inSubstringsOfLength length: Int, inRange range: CountableRange<Int>) -> Array<String>
	{
		guard !self.isEmpty && length > 0 else { return Array<String>() }
		let stringInRange: String = self.substring(inRange: range)
		
		if length == 1
		{
			return self.substring(inRange: range).characterArray
		}
		else
		{
			return stride(from: 0, to: stringInRange.lastIndex! + 1, by: length).map(
			{ index -> String in
				let stringInRange: String = self.substring(inRange: range)
				let startIndex: Int = index
				let endIndex: Int = index + length - 1
				return stringInRange.substring(inRange: startIndex ... endIndex)
			})
		}
	}
	
	public func splitted(inSubstringsOfLength length: Int, inRange range: CountableClosedRange<Int>) -> Array<String>
	{
		guard !self.isEmpty && length > 0 else { return Array<String>() }
		let stringInRange: String = self.substring(inRange: range)
		
		if length == 1
		{
			return self.substring(inRange: range).characterArray
		}
		else
		{
			return stride(from: 0, to: stringInRange.lastIndex! + 1, by: length).map(
			{ index -> String in
				let stringInRange: String = self.substring(inRange: range)
				let startIndex: Int = index
				let endIndex: Int = index + length - 1
				return stringInRange.substring(inRange: startIndex ... endIndex)
			})
		}
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
		guard !self.isEmpty && self.contains(string) && self.indexesOf(substring: string).contains(0) else { return self }
		self = self[string.length ... self.lastIndex!]
		return self
	}
	
	public func truncatedLeft(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOf(substring: string).contains(0) else { return self }
		return self[string.length ... self.lastIndex!]
	}
	
	public mutating func truncateRight(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOf(substring: string).contains(self.length - string.length) else { return self }
		self = self[string.length ... self.lastIndex!]
		return self
	}
	
	public func truncatedRight(_ string: String) -> String
	{
		guard !self.isEmpty && self.contains(string) && self.indexesOf(substring: string).contains(self.length - string.length) else { return self }
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
	
	/// StringKit: Latinized string.
	public var latinized: String {
		return folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	
	/// StringKit: Returns the elements of an array joined with a given string.
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
	@discardableResult
	public mutating func join<T: Collection>(_ elements: T) -> String
	{
		self = elements.map({ String(describing: $0) }).joined(separator: self)
		return self
	}
	
	/// StringKit: Returns a slugified String.
	@available(OSX 10.11, *)
	public func slugified() -> String?
	{
		
		guard !self.isEmpty else { return self }
		let allowedCharacters: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
		if self.applyingTransform(StringTransform.toLatin, reverse: false) != nil && self.applyingTransform(StringTransform.stripCombiningMarks, reverse: false) != nil
		{
			var temporary: String = String()
			temporary = self.applyingTransform(StringTransform.toLatin, reverse: false)!
			temporary = self.applyingTransform(StringTransform.stripCombiningMarks, reverse: false)!
			return temporary
				.components(separatedBy: allowedCharacters.inverted)
				.filter({ $0 != "" })
				.joined(separator: "-")
		}
		
		return self
	}
	
	/// StringKit: Returns a slugified String.
	@available(OSX 10.11, *)
	@discardableResult
	public mutating func slugify() -> String?
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
	
	//  MARK: OPERATORS
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
