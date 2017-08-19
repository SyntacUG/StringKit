//
//  SKConversion.swift
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
//  Created by (Rainer Niemann, rainerniemann@icloud.com) and (Andreas Niemann, andreasniemann1999@icloud.com)
//  This project is licensed under the MIT License. See the LICENSE.md file for details.
//

//  MARK: IMPORTS - TESTED
#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif

//  MARK: STRING CONVERSION EXTENSION - TESTED
public extension String
{
	/// StringKit: Returns the Bool value from a string (if applicable).
	public var boolValue: Bool?
	{
		let selfLowerCase: String = self.trimmed.lowercased()
		if selfLowerCase == "true" || selfLowerCase == "1" || selfLowerCase == "right"
		{
			return true
		}
		else if selfLowerCase == "false" || selfLowerCase == "0" || selfLowerCase == "wrong"
		{
			return false
		}
		return nil
	}
	
	/// StringKit: Returns the UInt value from a string (if applicable).
	public var UIntValue: UInt?
	{
		guard let doubleValue: Double = Double(self), doubleValue > 0 else { return UInt(self) }
		return UInt(doubleValue)
	}
	
	/// StringKit: Returns the UInt8 value from a string (if applicable).
	public var UInt8Value: UInt8?
	{
		guard let doubleValue: Double = Double(self), doubleValue > 0 else { return UInt8(self) }
		return UInt8(doubleValue)
	}
	
	/// StringKit: Returns the UInt16 value from a string (if applicable).
	public var UInt16Value: UInt16?
	{
		guard let doubleValue: Double = Double(self), doubleValue > 0 else { return UInt16(self) }
		return UInt16(doubleValue)
	}
	
	/// StringKit: Returns the UInt32 value from a string (if applicable).
	public var UInt32Value: UInt32?
	{
		guard let doubleValue: Double = Double(self), doubleValue > 0 else { return UInt32(self) }
		return UInt32(doubleValue)
	}
	
	/// StringKit: Returns the UInt64 value from a string (if applicable).
	public var UInt64Value: UInt64?
	{
		guard let doubleValue: Double = Double(self), doubleValue > 0 else { return UInt64(self) }
		return UInt64(doubleValue)
	}
	
	/// StringKit: Returns the Int value from a string (if applicable).
	public var intValue: Int?
	{
		guard let doubleValue: Double = Double(self) else { return Int(self) }
		return Int(doubleValue)
	}
	
	/// StringKit: Returns the Int8 value from a string (if applicable).
	public var int8Value: Int8?
	{
		guard let doubleValue: Double = Double(self) else { return Int8(self) }
		return Int8(doubleValue)
	}
	
	/// StringKit: Returns the Int16 value from a string (if applicable).
	public var int16Value: Int16?
	{
		guard let doubleValue: Double = Double(self) else { return Int16(self) }
		return Int16(doubleValue)
	}
	
	/// StringKit: Returns the Int32 value from a string (if applicable).
	public var int32Value: Int32?
	{
		guard let doubleValue: Double = Double(self) else { return Int32(self) }
		return Int32(doubleValue)
	}
	
	/// StringKit: Returns the Int64 value from a string (if applicable).
	public var int64Value: Int64?
	{
		guard let doubleValue: Double = Double(self) else { return Int64(self) }
		return Int64(doubleValue)
	}
	
	/// StringKit: Returns the Float value from a string (if applicable).
	///
	/// - Parameters
	///		- locale: The possibility to choose a locale (optional, default: Locale.current).
	public func floatValue(locale: Locale = Locale.current) -> Float?
	{
		let formatter: NumberFormatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Float
	}
	
	/// StringKit: Returns the Float32 value from a string (if applicable).
	///
	/// - Parameters
	///		- locale: The possibility to choose a locale (optional, default: Locale.current).
	public func float32Value(locale: Locale = Locale.current) -> Float32?
	{
		let formatter: NumberFormatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Float32
	}
	
	/// StringKit: Returns the Float64 value from a string (if applicable).
	///
	/// - Parameters
	///		- locale: The possibility to choose a locale (optional, default: Locale.current).
	public func float64Value(locale: Locale = Locale.current) -> Float64?
	{
		let formatter: NumberFormatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Float64
	}
	
	/// StringKit: Returns the Double value from a string (if applicable).
	///
	/// - Parameters
	///		- locale: The possibility to choose a locale (optional, default: Locale.current).
	public func doubleValue(locale: Locale = Locale.current) -> Double?
	{
		let formatter: NumberFormatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Double
	}
	
	/// StringKit: Returns the Decimal value from a string (if applicable).
	public var decimalValue: Decimal?
	{
		return Decimal(string: self)
	}
	
	/// StringKit: Returns the CGFloat value from a string (if applicable).
	///
	/// - Parameters
	///		- locale: The possibility to choose a locale (optional, default: Locale.current).
	public func cgFloatValue(locale: Locale = Locale.current) -> CGFloat?
	{
		let formatter: NumberFormatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? CGFloat
	}
	
	/// StringKit: Returns a Date object in format of "HH:mm:ss" (if applicable).
	public var timeValue: Date?
	{
		let formatter: DateFormatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "HH:mm:ss"
		return formatter.date(from: self.trimmed.lowercased())
	}
	
	/// StringKit: Returns a Date object in format of "yyyy-MM-dd" (if applicable).
	public var dateValue: Date?
	{
		let formatter: DateFormatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: self.trimmed.lowercased())
	}
	
	/// StringKit: Returns a Date object in format of "yyyy-MM-dd HH:mm:ss" (if applicable).
	public var dateTimeValue: Date?
	{
		let formatter: DateFormatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter.date(from: self.trimmed.lowercased())
	}
	
	/// StringKit: Returns a date object converted from a string of date format (if applicable).
	///
	/// - Parameters:
	///		- format: The format of the target date object.
	public func date(withFormat format: String) -> Date?
	{
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: self)
	}
	
	/// StringKit: Returns an array encoded in ASCII (if applicable).
	///
	/// - Parameters:
	///		- ignoreNonValidValues: The possibility to ignore and remove non valid values (optional, default: false).
	public func asciiEncoded(ignoreNonValidValues: Bool = false) -> Array<Int>?
	{
		guard !self.isEmpty else { return [0] }
		var resultArray: Array<Int> = Array<Int>()
		
		if ignoreNonValidValues
		{
			return self.unicodeScalars.filter({ $0.isASCII }).map({ Int($0.value) })
		}
		
		for unicodeScalar in self.unicodeScalars
		{
			guard unicodeScalar.isASCII else { return nil }
			resultArray.append(Int(unicodeScalar.value))
		}
		
		return resultArray
	}
	
	/// StringKit: Returns an array decoded from ASCII (if applicable).
	///
	/// - Parameters:
	///		- ignoreNonValidValues: The possibility to ignore and remove non valid values (optional, default: false).
	public func asciiDecoded(ignoreNonValidValues: Bool = false) -> Array<String>?
	{
		guard !self.isEmpty else { return Array<String>() }
		var resultArray: Array<String> = Array<String>()
		let ascii: Array<Int> = self.components(separatedBy: " ").map({ Int($0) ?? -1 })
		
		if ignoreNonValidValues
		{
			return ascii.filter({ UnicodeScalar($0)!.isASCII }).map({ String(describing: UnicodeScalar($0)!) })
		}
		
		for asciiValue in ascii
		{
			guard let unicodeScalar = UnicodeScalar(asciiValue) else { return nil }
			guard unicodeScalar.isASCII else { return nil }
			resultArray.append(String(unicodeScalar))
		}
		
		return resultArray
	}
	
	/// StringKit: Returns an array encoded in Unicode.
	public func unicodeEncoded() -> Array<Int>
	{
		guard !self.isEmpty else { return Array<Int>() }
		return self.unicodeScalars.map({ $0.hashValue })
	}
	
	/// StringKit: Returns an array decoded from Unicode.
	public func unicodeDecoded() -> Array<String>
	{
		guard !self.isEmpty else { return Array<String>() }
		return self.components(separatedBy: " ").map({ String(describing: UnicodeScalar(Int($0)!)!) })
	}
	
	/// StringKit: Returns a string encoded in base64 (if applicable).
	public func base64Encoded() -> String?
	{
		guard !self.isEmpty else { return nil }
		return data(using: .utf8)?.base64EncodedString()
	}
	
	/// StringKit: Encodes a string in base64 and returns the result (if applicable; discardable).
	@discardableResult
	public mutating func base64Encode() -> String?
	{
		guard !self.isEmpty, let base64: String = self.base64Encoded() else { return nil }
		self = base64
		return self
	}
	
	/// StringKit: Returns a string decoded from base64 (if applicable).
	public func base64Decoded() -> String?
	{
		guard !self.isEmpty else { return String() }
		guard let decodedData: Data = Data(base64Encoded: self) else { return nil }
		return String(data: decodedData, encoding: .utf8)
	}
	
	/// StringKit: Decodes a string from base64 and returns the result (if applicable; discardable).
	@discardableResult
	public mutating func base64Decode() -> String?
	{
		guard !self.isEmpty, let decodedData: String = self.base64Decoded() else { return nil }
		self = decodedData
		return self
	}
	
	/// StringKit: Returns the URL value from a string (if applicable).
	public var urlValue: URL?
	{
		return URL(string: self)
	}
	
	/// StringKit: Returns a string encoded in URL format (if applicable).
	public func urlEncoded() -> String?
	{
		guard !self.isEmpty else { return nil }
		return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
	}
	
	/// StringKit: Encodes a string in URL format and returns the result (if applicable; discardable).
	@discardableResult
	public mutating func urlEncode() -> String?
	{
		guard !self.isEmpty, let encodedData: String = self.urlEncoded() else { return nil }
		self = encodedData
		return self
	}
	
	/// StringKit: Returns a string decoded from URL format (if applicable).
	public func urlDecoded() -> String?
	{
		guard !self.isEmpty else { return nil }
		return self.removingPercentEncoding
	}
	
	/// StringKit: Decodes a string from URL format and returns the result (if applicable; discardable).
	@discardableResult
	public mutating func urlDecode() -> String?
	{
		guard !self.isEmpty, let decodedData: String = self.urlDecoded() else { return nil }
		self = decodedData
		return self
	}
}
