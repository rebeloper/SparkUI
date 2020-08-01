//
//  Console.swift
//
//
//  Created by Alex Nagy on 01/08/2020.
//

import Foundation

internal extension NSAttributedString {
    static func breakLine() -> NSAttributedString {
        return NSAttributedString(string: "\n")
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: length)
    }
}
