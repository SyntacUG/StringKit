//
//  SKSupporting.swift
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

//  MARK: SUPPORTING INT EXTENSION - TESTED
public extension Int
{
	//  MARK: OPERATORS
	/// StringKit: Returns a CountableRange.
	public static func ..<(left: Int, right: Int) -> CountableRange<Int>
	{
		return CountableRange<Int>.init(uncheckedBounds: (lower: left, upper: right))
	}
	
	/// StringKit: Returns a CountableClosedRange.
	public static func ...(left: Int, right: Int) -> CountableClosedRange<Int>
	{
		return CountableClosedRange<Int>.init(uncheckedBounds: (lower: left, upper: right))
	}
}

/// StringKit: Returns the greatest common divisor.
///
/// - Parameters:
///		- a: The first number.
///		- b: The second number.
func gcd(of a: Int, and b: Int) -> Int
{
	if b == 0
	{
		return a
	}
	else
	{
		return gcd(of: b, and: a % b)
	}
}

/// StringKit: Checks if a number is a prime number.
///
/// - Parameters:
///		- number: The number to check.
func isPrime(number: Int) -> Bool
{
	if number == 2
	{
		return true
	}
	else if number == 1 || number & 1 == 0
	{
		return false
	}
	
	for n in stride(from: 3, through: Int(round(sqrt(Double(number)))), by: 2)
	{
		if number % n == 0
		{
			return false
		}
	}
	
	return true
}

/// StringKit: Returns all divisors of a specific number.
///
/// - Parameters:
///		- number: The number to find the divisors for.
func findDivisors(number: Int) -> [Int]
{
	var divisors: Array<Int> = Array<Int>()
	var temp: Int = number
	
	if !isPrime(number: number)
	{
		for divisor in 1 ... number / 2
		{
			if divisor < temp
			{
				if number % divisor == 0
				{
					divisors.append(divisor)
					temp = number / divisor
					
					if temp != divisor
					{
						divisors.append(temp)
					}
					
					if isPrime(number: temp)
					{
						break
					}
				}
			}
			else
			{
				break
			}
		}
	}
	else
	{
		divisors = [1, number]
	}
	
	return divisors
}
