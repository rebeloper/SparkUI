//
//  RichFont.swift
//  
//
//  Created by Alex Nagy on 28/05/2020.
//

import UIKit

public typealias RichFont = UIFont

let fontBoldTrait = UIFontDescriptor.SymbolicTraits.traitBold

extension UIFontDescriptor {
    var hasBoldTrait: Bool {
        return symbolicTraits.contains(.traitBold)
    }
}

extension NSAttributedString {
    @discardableResult
    public func fontSize(_ size: CGFloat) -> NSAttributedString {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        let fontAttrs = attrs.filter {
            $0.0 == .font
        }

        let font: RichFont
        if fontAttrs.count > 0, let fst = fontAttrs.first?.1 as? RichFont {
            font = fst
        } else {
            font = RichFont.systemFont(ofSize: size)
        }
        let sizedDescriptor = font.fontDescriptor.withSize(size)
        let sizedFont = RichFont(descriptor: sizedDescriptor, size: size)
        return self.font(sizedFont)
    }
}

extension NonAttributedString {
    @discardableResult
    public func fontSize(_ size: CGFloat) -> NSAttributedString {
        return rich.fontSize(size)
    }
}
