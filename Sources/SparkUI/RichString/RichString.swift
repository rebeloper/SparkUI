//
//  RichString.swift
//  
//
//  Created by Alex Nagy on 28/05/2020.
//

import Foundation
import UIKit

/**
 * The RichString protocol defines the interface of this framework.
 *
 * - Note: All attributes are always applied on the *entire range* of the attributed string.
 *         This means that you normally create attributed strings for the text parts that have
 *         the desired attributes, and then concatenate them (using operator `+(_:_:)` for example).
 */
public protocol RichString {

    /**
     * Apply the given font. The type `Font` is a type alias of `UIFont` on iOS,
     * and of `NSFont` on macOS.
     *
     * - Param font: The font that the attributed string should have.
     * - Returns: A new attributed string that has the given font attribute.
     */
    func font(_ font: RichFont) -> NSAttributedString

    /**
     * Applies the given font size. If no font was set on the
     * attributed string yet, `Font.systemFont` will be assumed.
     *
     * - Parameter size: The desired point size of the attributed string.
     * - Returns: A new attributed string that has the given font size attribute.
     */
    func fontSize(_ size: CGFloat) -> NSAttributedString

    /**
     * Applies the given paragraph style.
     *
     * - Parameter paragraphStyle: The paragraph style that is applied.
     * - Returns: A new attributed string that has the paragraph style applied.
     */
    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString

    /**
     * Applies a paragraph style, configuring it with the given closure. If the attributed
     * string already had a paragraph style attribute, the `configure` closure is called
     * on that paragraph style; otherwise a new `NSMutableParagraphStyle` is used.
     *
     * For example:
     *
     * ```swift
     *    let result = "Hello World".paragraphStyle {
     *         $0.firstLineHeadIndent = 10
     *    }
     * ```
     *
     * - Parameter configure: The closure that you can use to configure the paragraph style.
     * - Returns: A new attributed string that has the configured paragraph style applied.
     */
    func paragraphStyle(configure: (NSMutableParagraphStyle) -> Void)
            -> NSAttributedString

    /**
     * Applies the given (foreground) color.
     *
     * - Parameter color: The foreground color that is applied.
     * - Returns: A new attributed string that has the given foreground color.
     */
    func color(_ color: RichColor) -> NSAttributedString

    /**
     * Applies the given background color.
     *
     * - Parameter color: the background color that is applied
     * - Returns: a new attributed string that has the given background color.
     */
    func backgroundColor(_ color: RichColor) -> NSAttributedString

    /**
     * Configures whether or not to use ligatures. Default is that they are used.
     *
     * - Parameter ligature: Indicates whether or not ligatures should be used.
     * - Returns: A new attributed string that has the given ligature attribute.
     */
    func ligature(_ ligature: Bool) -> NSAttributedString

    /**
     * Configures the amount with which to modify the default kerning. The default `0`
     * means that no kerning change is applied.
     *
     * - Parameter kern: The amount to modify the default kerning.
     *                   `0` means kerning is disabled.
     * - Returns: A new attributed string that has the given kerning applied.
     */
    func kern(_ kern: Float) -> NSAttributedString

    /**
     * Configures the strike through style.
     *
     * - Parameter style: The `NSUnderlineStyle` to apply. Please note that depending on
     *                    OS and version not all styles may actually work.
     * - Returns: A new attributed string that has the given strike through style applied.
     */
    func strikeThrough(style: NSUnderlineStyle) -> NSAttributedString

    /**
     * Configures the strike through color.
     *
     * - Parameter color: The color to apply. Please note that only setting the color
     *                    has no effect, the style must be configured as well.
     * - Returns: A new attributed string that has the given strike through color applied.
     */
    func strikeThrough(color: RichColor) -> NSAttributedString

    /**
     * Configures both the strike through color and style.
     *
     * - Parameter color: The color to apply.
     * - Parameter style: The `NSUnderlineStyle` to apply. Please note that depending on
     *                    OS and version not all styles may actually work.
     * - Returns: A new attributed string that has the given strike through color and style applied.
     */
    func strikeThrough(color: RichColor, style: NSUnderlineStyle) -> NSAttributedString

    /**
     * Configures the underline style.
     *
     * - Parameter style: The `NSUnderlineStyle` to apply. Please note that depending on
     *                    OS and version not all styles may actually work.
     * - Returns: A new attributed string that has the given underline style applied.
     */
    func underline(style: NSUnderlineStyle) -> NSAttributedString

    /**
     * Configures the underline color.
     *
     * - Parameter color: The color to apply. Please note that only setting the color
     *                    has no effect, the style must be configured as well.
     * - Returns: A new attributed string that has the given underline color applied.
     */
    func underline(color: RichColor) -> NSAttributedString

    /**
     * Configures both the underline color and style.
     *
     * - Parameter color: The color to apply.
     * - Parameter style: The `NSUnderlineStyle` to apply. Please note that depending on
     *                    OS and version not all styles may actually work.
     * - Returns: A new attributed string that has the given underline color and style applied.
     */
    func underline(color: RichColor, style: NSUnderlineStyle) -> NSAttributedString

    /**
     * Configures the stroke.
     *
     * - Parameter width: The width of the stroke.
     * - Parameter color: The color of the stroke.
     * - Returns: A new attributed string that has the given stroke attributes applied.
     */
    func stroke(width: Float, color: RichColor) -> NSAttributedString

    /**
     * Configures the shadow by setting an `NSShadow` instance.
     *
     * - Parameter shadow: The `NSShadow` to apply.
     * - Returns: A new attributed string that has the given shadow applied.
     */
    func shadow(_ shadow: NSShadow) -> NSAttributedString

    /**
     * Configures the shadow using a closure that receives an `NSShadow` instance.
     *
     * For example:
     *
     * ```swift
     *    let result = "Hello World".shadow {
     *        $0.shadowOffset = CGSize(width: 3, height: 3)
     *        $0.shadowBlurRadius = 2
     *        $0.shadowColor = Color.gray
     *    }
     * ```
     *
     * - Parameter configure: The closure that you use to configure the shadow; it is passed
     *                        an `NSShadow` instance that you can change and is then applied.
     * - Returns: A new attributed string that has the configured shadow applied.
     */
    func shadow(configure: (NSShadow) -> Void) -> NSAttributedString

    /**
     * Creates a new `NSTextAttachment` and passes it to the `configure` closure.
     *
     * - Parameter configure: the closure that you can use to configure the
     *                        `NSTextAttachment` instance.
     * - Returns: A new attributed string that has the configured text attachment.
     */
    func attachment(configure: (NSTextAttachment) -> Void)
        -> NSAttributedString

    /**
     * Adds the "letter pressed" text effect.
     *
     * - Returns: A new attributed string that has the "letter pressed" text effect applied.
     */
    func letterPressed() -> NSAttributedString

    /**
     * Creates hyperlink to the given URL with the receiver as text.
     *
     * - Parameter url: The URL to which the hyperlink points.
     * - Returns: A new attributed string that is the receiver converted to a hyperlink.
     */
    func link(url: NSURL) -> NSAttributedString

    /**
     * Creates hyperlink to the given URL with the receiver as text.
     *
     * - Parameter string: The URL string to which the hyperlink points.
     * - Returns: A new attributed string that is the receiver converted to a hyperlink.
     */
    func link(string: String) -> NSAttributedString

    /**
     * Configures the baseline offset.
     *
     * - Parameter offset: The number of points the text is offset from the baseline.
     * - Returns: A new attributed string that has the given baseline offset configured.
     */
    func baselineOffset(_ offset: Float) -> NSAttributedString

    /**
     * Configures the skew to be applied to glyphs.
     *
     * - Parameter obliqueness: The skew that is applied to glyphs; `0` means no skew.
     * - Returns: A new attributed string that has the given obliqueness configured.
     */
    func obliqueness(_ obliqueness: Float) -> NSAttributedString

    /**
     * Configures the expansion to be applied to glyphs.
     *
     * - Parameter expansion: The log of the expansion factor to be applied to glyphs.
     * - Returns: A new attributed string that has the given expansion configured.
     */
    func expansion(_ expansion: Float) -> NSAttributedString
}

private func xcodeBugWorkaround() {
    print("https://stackoverflow.com/a/54510891")
}

