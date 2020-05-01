//
//  UIFont+.swift
//  
//
//  Created by Alex Nagy on 01/05/2020.
//

import UIKit

extension UIFont {
    public func insert(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if fontDescriptor.symbolicTraits.contains(traits) {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert(traits)
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: pointSize)
        }
    }
    
    public func remove(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
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

extension UIFont {
    public var ultraLight: UIFont { return withWeight(.ultraLight) }
    public var thin: UIFont { return withWeight(.thin) }
    public var light: UIFont { return withWeight(.light) }
    public var regular: UIFont { return withWeight(.regular) }
    public var medium: UIFont { return withWeight(.medium) }
    public var semibold: UIFont { return withWeight(.semibold) }
    public var bold: UIFont { return withWeight(.bold) }
    public var heavy: UIFont { return withWeight(.heavy) }
    public var black: UIFont { return withWeight(.black) }

    public func withWeight(_ weight: UIFont.Weight) -> UIFont {
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
