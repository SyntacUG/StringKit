//
//  SKCreation.swift
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

//  MARK: STRING CREATION EXTENSION - TESTED
public extension String
{
	/// StringKit: Creates a new, random string of a given length and returns the result.
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
	
	//  MARK: INITIALIZERS
	/// StringKit: Creates a new, random string of a given length.
	///
	/// - Parameters:
	///		- length: The number of characters in the new string.
	public init(randomOfLength length: Int)
	{
		self = String.random(ofLength: length)
	}
	
	/// StringKit: Creates a new string from an ASCII array (if applicable).
	///
	/// - Parameters:
	///		- ascii: The ASCII array.
	///		- ignoreNonValidValues: The possibility to ignore and remove non valid values (optional, default: false).
	public init?(ascii: Array<Int>, ignoreNonValidValues: Bool = false)
	{
		if let resultArray: Array<String> = ascii.flatMap({ String($0) }).joined(separator: " ").asciiDecoded(ignoreNonValidValues: ignoreNonValidValues)
		{
			self.init(resultArray.joined())
			return
		}
		return nil
	}
	
	/// StringKit: Creates a new string from a base64 string (if applicable).
	///
	/// - Parameters:
	///		- base64: The base64 string.
	public init?(base64: String)
	{
		guard let string: String = base64.base64Decoded() else { return nil }
		self.init(string)
	}
}
