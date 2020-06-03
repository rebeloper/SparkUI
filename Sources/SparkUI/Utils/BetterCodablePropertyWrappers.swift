//
//  BetterCodablePropertyWrappers.swift
//  
//
//  Created by Alex Nagy on 03/06/2020.
//

import Foundation
import BetterCodable

// MARK: - True

public struct DefaultTrueStrategy: DefaultCodableStrategy {
    public static var defaultValue: Bool { return true }
}

/// Decodes Bools defaulting to `true` if applicable
///
/// `@DefaultTrue` decodes Bools and defaults the value to true if the Decoder is unable to decode the value.
public typealias DefaultTrue = DefaultCodable<DefaultTrueStrategy>

// MARK: - EmptyString

public struct DefaultEmptyStringStrategy: DefaultCodableStrategy {
    public static var defaultValue: String { return String.empty }
}

/// Decodes String defaulting to `""` if applicable
///
/// `@DefaultEmptyString` decodes Strings and defaults the value to an empty string if the Decoder is unable to decode the value.
public typealias DefaultEmptyString = DefaultCodable<DefaultEmptyStringStrategy>

// MARK: - ZeroInt

public struct DefaultZeroIntStrategy: DefaultCodableStrategy {
    public static var defaultValue: Int { return Int.zero }
}

/// Decodes Int defaulting to `0` if applicable
///
/// `@DefaultZeroInt` decodes Ints and defaults the value to an 0 if the Decoder is unable to decode the value.
public typealias DefaultZeroInt = DefaultCodable<DefaultZeroIntStrategy>

// MARK: - ZeroDouble

public struct DefaultZeroDoubleStrategy: DefaultCodableStrategy {
    public static var defaultValue: Double { return Double.zero }
}

/// Decodes Double defaulting to `0.0` if applicable
///
/// `@DefaultZeroDouble` decodes Doubles and defaults the value to an 0.0 if the Decoder is unable to decode the value.
public typealias DefaultZeroDouble = DefaultCodable<DefaultZeroDoubleStrategy>

// MARK: - Now

public struct DefaultNowStrategy: DefaultCodableStrategy {
    public static var defaultValue: Date { return Date.now }
}

/// Decodes Date defaulting to now if applicable
///
/// `@DefaultNow` decodes Dates and defaults the value to now if the Decoder is unable to decode the value.
public typealias DefaultNow = DefaultCodable<DefaultNowStrategy>
