//
//  Call.swift
//  
//
//  Created by Alex Nagy on 24/07/2020.
//

import Foundation
import UIKit

public class DataDetector {

    public class func _find(all type: NSTextCheckingResult.CheckingType,
                             in string: String, iterationClosure: (String) -> Bool) {
        guard let detector = try? NSDataDetector(types: type.rawValue) else { return }
        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
        let matches = detector.matches(in: string, options: [], range: range)
        loop: for match in matches {
            for i in 0 ..< match.numberOfRanges {
                let nsrange = match.range(at: i)
                let startIndex = string.index(string.startIndex, offsetBy: nsrange.lowerBound)
                let endIndex = string.index(string.startIndex, offsetBy: nsrange.upperBound)
                let range = startIndex..<endIndex
                guard iterationClosure(String(string[range])) else { break loop }
            }
        }
    }

    public class func find(all type: NSTextCheckingResult.CheckingType, in string: String) -> [String] {
        var results = [String]()
        _find(all: type, in: string) {
            results.append($0)
            return true
        }
        return results
    }

    public class func first(type: NSTextCheckingResult.CheckingType, in string: String) -> String? {
        var result: String?
        _find(all: type, in: string) {
            result = $0
            return false
        }
        return result
    }
}

// MARK: PhoneNumber

public struct PhoneNumber {
    private(set) var number: String
    public init?(extractFrom string: String) {
        guard let phoneNumber = PhoneNumber.first(in: string) else { return nil }
        self = phoneNumber
    }

    private init (string: String) { self.number = string }

    public func makeACall() {
        guard let url = URL(string: "tel://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    public static func extractAll(from string: String) -> [PhoneNumber] {
        DataDetector.find(all: .phoneNumber, in: string)
            .compactMap {  PhoneNumber(string: $0) }
    }

    public static func first(in string: String) -> PhoneNumber? {
        guard let phoneNumberString = DataDetector.first(type: .phoneNumber, in: string) else { return nil }
        return PhoneNumber(string: phoneNumberString)
    }
}

extension PhoneNumber: CustomStringConvertible { public var description: String { number } }

// MARK: String extension

public extension String {

    // MARK: Get remove all characters exept numbers

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    var detectedPhoneNumbers: [PhoneNumber] { PhoneNumber.extractAll(from: self) }
    var detectedFirstPhoneNumber: PhoneNumber? { PhoneNumber.first(in: self) }
}

public struct Call {
    public static func number(_ number: String) {
        if let phoneNumber = PhoneNumber(extractFrom: number) {
            phoneNumber.makeACall()
        } else {
            Alert.showInfo(message: "Invalid phone number: \(number)")
        }
    }
    
    /// position starts with 1
    public static func extractedNumber(from text: String, position: Int = 1) {
        if position < 1 {
            Alert.showInfo(message: "Position of phone number should be greater than 1")
            return
        }
        let phoneNumbers = PhoneNumber.extractAll(from: text)
        if position <= phoneNumbers.count {
            phoneNumbers[position - 1].makeACall()
        } else {
            Alert.showInfo(message: "No phone number found")
        }
    }
    
    public static func firstExtractedNumber(from text: String) {
        if let phoneNumber = PhoneNumber.extractAll(from: text).first {
            phoneNumber.makeACall()
        } else {
            Alert.showInfo(message: "No phone number found")
        }
    }
    
    public static func lastExtractedNumber(from text: String) {
        if let phoneNumber = PhoneNumber.extractAll(from: text).last {
            phoneNumber.makeACall()
        } else {
            Alert.showInfo(message: "No phone number found")
        }
    }
}
