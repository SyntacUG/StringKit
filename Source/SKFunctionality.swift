//
//  SKFunctionality.swift
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

//  MARK: STRING FUNCTIONALITY EXTENSION - TESTED
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
