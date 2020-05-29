//
//  String+Rich.swift
//  
//
//  Created by Alex Nagy on 28/05/2020.
//

import Foundation
import UIKit

/**
 * Protocol used to add all functionality to both `String` and `NSString`.
 * You normally don't need to use this directly yourself.
 *
 * Please note: I would have preferred for this protocol to be internal.
 * That doesn't work with Swift 3 however; when doing release builds you
 * get 'undefined symbol' linker errors. More info:
 * https://bugs.swift.org/browse/SR-2925
 */
public protocol NonAttributedString: RichString {
    /**
     * Create a `NSAttributedString` version of the string. Should be internal, not public;
     * see remark above.
     *
     * - Returns: `NSAttributedString` version of this string.
     */
    var rich: RichString { get }
}

/**
 * Protocol used to add all functionality to both `String` and `NSString`.
 * You normally don't need to use this protocol directly yourself.
 */
extension NonAttributedString {
    @discardableResult
    public func font(_ font: RichFont) -> NSAttributedString {
        return rich.font(font)
    }

    @discardableResult
    public func color(_ color: RichColor) -> NSAttributedString {
        return rich.color(color)
    }

    @discardableResult
    public func backgroundColor(_ color: RichColor) -> NSAttributedString {
        return rich.backgroundColor(color)
    }

    @discardableResult
    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return rich.paragraphStyle(paragraphStyle)
    }

    @discardableResult
    public func paragraphStyle(configure: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString {
        return rich.paragraphStyle(configure: configure)
    }

    @discardableResult
    public func ligature(_ ligature: Bool) -> NSAttributedString {
        return rich.ligature(ligature)
    }

    @discardableResult
    public func kern(_ kern: Float) -> NSAttributedString {
        return rich.kern(kern)
    }

    @discardableResult
    public func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString {
        return rich.strikeThrough(style: style)
    }

    @discardableResult
    public func strikeThrough(color: RichColor) -> NSAttributedString {
        return rich.strikeThrough(color: color)
    }

    @discardableResult
    public func strikeThrough(color: RichColor, style: NSUnderlineStyle) -> NSAttributedString {
        return rich.strikeThrough(color: color, style: style)
    }

    @discardableResult
    public func underline(style: NSUnderlineStyle) -> NSAttributedString {
        return rich.underline(style: style)
    }

    @discardableResult
    public func underline(color: RichColor) -> NSAttributedString {
        return rich.underline(color: color)
    }

    @discardableResult
    public func underline(color: RichColor, style: NSUnderlineStyle)
            -> NSAttributedString {
        return rich.underline(color: color, style: style)
    }

    @discardableResult
    public func stroke(width: Float, color: RichColor) -> NSAttributedString {
        return rich.stroke(width: width, color: color)
    }

    @discardableResult
    public func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return rich.shadow(shadow)
    }

    @discardableResult
    public func shadow(configure: (NSShadow) -> Void) -> NSAttributedString {
        return rich.shadow(configure: configure)
    }

    @discardableResult
    public func attachment(configure: (NSTextAttachment) -> Void)
        -> NSAttributedString {
            return rich.attachment(configure: configure)
    }

    @discardableResult
    public func letterPressed() -> NSAttributedString {
        return rich.letterPressed()
    }

    @discardableResult
    public func link(url: NSURL) -> NSAttributedString {
        return rich.link(url: url)
    }

    @discardableResult
    public func link(string: String) -> NSAttributedString {
        return rich.link(string: string)
    }

    @discardableResult
    public func baselineOffset(_ offset: Float) -> NSAttributedString {
        return rich.baselineOffset(offset)
    }

    @discardableResult
    public func obliqueness(_ obliqueness: Float) -> NSAttributedString {
        return rich.obliqueness(obliqueness)
    }

    @discardableResult
    public func expansion(_ expansion: Float) -> NSAttributedString {
        return rich.expansion(expansion)
    }
}

extension String: NonAttributedString {
    public var rich: RichString {
        return NSAttributedString(string: self)
    }
}

extension NSString: NonAttributedString {
    public var rich: RichString {
        return NSAttributedString(string: self as String)
    }
}

