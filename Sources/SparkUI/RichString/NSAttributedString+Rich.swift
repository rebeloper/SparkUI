//
//  NSAttributedString+Rich.swift
//  
//
//  Created by Alex Nagy on 28/05/2020.
//

import Foundation
import UIKit

// MARK: - Simple attributes

/**
 * Extension to add all RichString functionality to `NSAttributedString`.
 */
extension NSAttributedString: RichString {
    public func color(_ color: RichColor) -> NSAttributedString {
        return addingAttribute(.foregroundColor, value: color)
    }

    public func backgroundColor(_ color: RichColor) -> NSAttributedString {
        return addingAttribute(.backgroundColor, value: color)
    }

    public func font(_ font: RichFont) -> NSAttributedString {
        return addingAttribute(.font, value: font)
    }

    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }

    public func paragraphStyle(configure: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString {
        let style: NSMutableParagraphStyle
        if let existingStyle = self.paragraphStyle,
           let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle {
            style = mutableCopy
        } else {
            style = NSMutableParagraphStyle()
        }
        configure(style)
        return addingAttribute(.paragraphStyle, value: style)
    }

    public func ligature(_ ligature: Bool) -> NSAttributedString {
        return addingAttribute(.ligature, value: ligature ? 1 : 0)
    }

    public func kern(_ kern: Float) -> NSAttributedString {
        return addingAttribute(.kern, value: kern)
    }

    public func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(.strikethroughStyle, value: style.rawValue)
    }

    public func strikeThrough(color: RichColor) -> NSAttributedString {
        return addingAttribute(.strikethroughColor, value: color)
    }

    public func strikeThrough(color: RichColor, style: NSUnderlineStyle) -> NSAttributedString {
        return strikeThrough(color: color).strikeThrough(style: style)
    }

    public func underline(style: NSUnderlineStyle) -> NSAttributedString {
        return addingAttribute(.underlineStyle, value: style.rawValue)
    }

    public func underline(color: RichColor) -> NSAttributedString {
        return addingAttribute(.underlineColor, value: color)
    }

    public func underline(color: RichColor, style: NSUnderlineStyle)
            -> NSAttributedString {
        return underline(color: color).underline(style: style)
    }

    public func stroke(width: Float, color: RichColor) -> NSAttributedString {
        return addingAttribute(.strokeColor, value: color)
            .addingAttribute(.strokeWidth, value: width)
    }

    public func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return addingAttribute(.shadow, value: shadow)
    }

    public func shadow(configure: (NSShadow) -> Void) -> NSAttributedString {
        let shadow: NSShadow
        if let myShadow = self.shadow {
            shadow = myShadow
        } else {
            shadow = NSShadow()
        }
        configure(shadow)
        return self.shadow(shadow)
    }

    public func attachment(configure: (NSTextAttachment) -> Void)
        -> NSAttributedString {
            let attachment = NSTextAttachment()
            configure(attachment)
            return addingAttribute(.attachment, value: attachment)
    }

    public func letterPressed() -> NSAttributedString {
        return addingAttribute(.textEffect, value: NSAttributedString.TextEffectStyle.letterpressStyle)
    }

    public func link(url: NSURL) -> NSAttributedString {
        return addingAttribute(.link, value: url)
    }

    public func link(string: String) -> NSAttributedString {
        return addingAttribute(.link, value: string)
    }

    public func baselineOffset(_ offset: Float) -> NSAttributedString {
        return addingAttribute(.baselineOffset, value: offset)
    }

    public func obliqueness(_ obliqueness: Float) -> NSAttributedString {
        return addingAttribute(.obliqueness, value: obliqueness)
    }

    public func expansion(_ expansion: Float) -> NSAttributedString {
        return addingAttribute(.expansion, value: expansion)
    }
}

// MARK: - Private helpers
extension NSAttributedString {
    func addingAttribute(_ key: NSAttributedString.Key, value: Any) -> NSAttributedString {
        let mutableMe = makeMutable()
        let range = entireString()
        mutableMe.addAttribute(key, value: value, range: range)
        return NSAttributedString(attributedString: mutableMe)
    }

    func makeMutable() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

    func entireString() -> NSRange {
        return NSRange(location: 0, length: self.string.count)
    }
}

// MARK: - Attribute getters

/**
 * Extension to add attribute getters to `NSAttributedString`.
 */
extension NSAttributedString {
    var attrs: [NSAttributedString.Key: Any] {
        guard self.length > 0 else {
            return [:]
        }

        var range: NSRange = NSRange()
        let attrs = self.attributes(at: self.length - 1, effectiveRange: &range)
        return attrs
    }

    /**
     * - Returns: The configured color, if any.
     * - See: `RichString.color(_:)`
     */
    public var color: RichColor? {
        return attrs[.foregroundColor] as? RichColor
    }

    /**
     * - Returns: The configured background color, if any.
     * - See: `RichString.backgroundColor(_:)`
     */
    public var backgroundColor: RichColor? {
        return attrs[.backgroundColor] as? RichColor
    }

    /**
     * - Returns: The configured font size, if any.
     * - See: `RichString.fontSize(_:)`
     */
    public var fontSize: CGFloat? {
        return (attrs[.font] as? RichFont)?.pointSize
    }

    /**
     * - Returns: The configured paragraph style.
     * - See: `RichString.paragraphStyle(_:)`
     * - See: `RichString.paragraphStyle(configure:)`
     */
    public var paragraphStyle: NSParagraphStyle? {
        return attrs[.paragraphStyle] as? NSParagraphStyle
    }

    /**
     * - Returns: Whether or not ligatures are enabled (if configured).
     * - See: `RichString.ligature(_:)`
     */
    public var ligature: Bool? {
        guard let ligatureNumber = attrs[.ligature] as? Int else {
            return nil
        }
        return ligatureNumber == 1
    }

    /**
     * - Returns: The configured kerning, if any.
     * - See: `RichString.kern(_:)`
     */
    public var kern: Float? {
        return attrs[.kern] as? Float
    }

    /**
     * - Returns: The configured strike through style, if any.
     * - See: `RichString.strikeThrough(style:)`
     * - See: `RichString.strikeThrough(color:,style:)`
     */
    public var strikeThroughStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[.strikethroughStyle] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    /**
     * - Returns: The configured strike through color, if any.
     * - See: `RichString.strikeThrough(color:)`
     * - See: `RichString.strikeThrough(color:,style:)`
     */
    public var strikeThroughColor: RichColor? {
        return attrs[.strikethroughColor] as? RichColor
    }

    /**
     * - Returns: The configured underline style, if any.
     * - See: `RichString.underline(style:)`
     * - See: `RichString.underline(color:,style:)`
     */
    public var underlineStyle: NSUnderlineStyle? {
        guard let rawValue = attrs[.underlineStyle] as? Int else {
            return nil
        }
        return NSUnderlineStyle(rawValue: rawValue)
    }

    /**
     * - Returns: The configured underline color, if any.
     * - See: `RichString.underline(color:)`
     * - See: `RichString.underline(color:,style:)`
     */
    public var underlineColor: RichColor? {
        return attrs[.underlineColor] as? RichColor
    }

    /**
     * - Returns: The configured stroke width, if any.
     * - See: `RichString.stoke(width:,color:)`
     */
    public var strokeWidth: Float? {
        return attrs[.strokeWidth] as? Float
    }

    /**
     * - Returns: The configured stroke color, if any.
     * - See: `RichString.stroke(width:,color:)`
     */
    public var strokeColor: RichColor? {
        return attrs[.strokeColor] as? RichColor
    }

    /**
     * - Returns: The configured shadow, if any.
     * - See: `RichString.shadow(_:)`
     * - See: `RichString.shadow(configure:)`
     */
    public var shadow: NSShadow? {
        return attrs[.shadow] as? NSShadow
    }

    /**
     * - Returns: The configured attachment, if any.
     * - See: `RichString.attachment(configure:)`
     */
    public var attachment: NSTextAttachment? {
        return attrs[.attachment] as? NSTextAttachment
    }

    /**
     * - Returns: Whether or not the letter pressed text effect is configured.
     * - See: `RichString.letterPressed()`
     */
    public var isLetterPressed: Bool? {
        guard let textEffect = attrs[.textEffect] as? NSAttributedString.TextEffectStyle else {
            return nil
        }
        return textEffect == NSAttributedString.TextEffectStyle.letterpressStyle
    }

    /**
     * - Returns: The configured URL, if any.
     * - See: `RichString.link(string:)`
     * - See: `RichString.link(url:)`
     */
    public var link: NSURL? {
        if let string = attrs[.link] as? String {
            return NSURL(string: string)
        } else {
            return attrs[.link] as? NSURL
        }
    }

    /**
     * - Returns: The configured baseline offset, if any.
     * - See: `RichString.baselineOffset(_:)`
     */
    public var baselineOffset: Float? {
        return attrs[.baselineOffset] as? Float
    }

    /**
     * - Returns: The configured obliqueness (skew), if any.
     * - See: `RichString.obliqueness(_:)`
     */
    public var obliqueness: Float? {
        return attrs[.obliqueness] as? Float
    }

    /**
     * - Returns: The configured expansion, if any.
     * - See: `RichString.expansion(_:)`
     */
    public var expansion: Float? {
        return attrs[.expansion] as? Float
    }
}

