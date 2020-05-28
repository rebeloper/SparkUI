//
//  NSAttributedStringOperators.swift
//  
//
//  Created by Alex Nagy on 28/05/2020.
//

import Foundation

/**
 * Concatenates two attributed strings. Has the same behavior as NSMutableAttributedString.append().
 */
public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let mlhs = NSMutableAttributedString(attributedString: lhs)
    mlhs.append(rhs)
    return NSAttributedString(attributedString: mlhs)
}
