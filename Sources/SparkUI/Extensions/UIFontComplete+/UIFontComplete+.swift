//
//  UIFontComplete+.swift
//  
//
//  Created by Alex Nagy on 06/07/2020.
//

import UIKit
import UIFontComplete

public extension UIFont {
    @discardableResult
    static func system(font: Font, ofSize size: CGFloat) -> UIFont {
        return UIFont(font: font, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    @discardableResult
    static func custom(font: UIFont?) -> UIFont {
        return font ?? UIFont.systemFont(ofSize: 16)
    }
}

public extension FontRepresentable where Self.RawValue == String {
    func of(size: Int) -> UIFont? {
        return UIFont(name: rawValue, size: CGFloat(size))
    }
}
