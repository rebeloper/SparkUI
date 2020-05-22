//
//  UIFont+.swift
//  
//
//  Created by Alex Nagy on 01/05/2020.
//

import UIKit
import UIFontComplete

public extension UIFont {
    func insert(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if fontDescriptor.symbolicTraits.contains(traits) {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert(traits)
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: pointSize)
        }
    }
    
    func remove(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if !fontDescriptor.symbolicTraits.contains(traits) {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove(traits)
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: pointSize)
        }
    }
}

public extension UIFont {
    var ultraLight: UIFont { return withWeight(.ultraLight) }
    var thin: UIFont { return withWeight(.thin) }
    var light: UIFont { return withWeight(.light) }
    var regular: UIFont { return withWeight(.regular) }
    var medium: UIFont { return withWeight(.medium) }
    var semibold: UIFont { return withWeight(.semibold) }
    var bold: UIFont { return withWeight(.bold) }
    var heavy: UIFont { return withWeight(.heavy) }
    var black: UIFont { return withWeight(.black) }

    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

public extension UIFont {
    @discardableResult
    static func customFont(font: Font, size: CGFloat) -> UIFont {
        return UIFont(font: font, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
