//
//  SStyle.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

// MARK: - SButton

/// Represents view style with a closure that configures the view.
public struct SButtonStyle<View: SButton> {

    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: SButtonStyle<View> {
        return SButtonStyle { _ in }
    }
}

public extension SButton {
    
    convenience init<V>(uiView: UIView = UIView(), style: SButtonStyle<V>) {
        self.init(uiView: uiView)
        apply(style)
    }

    /// Applies the given style to self.
    func apply<V>(_ style: SButtonStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    func styled<V>(with style: SButtonStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

// MARK: - SImageView

/// Represents view style with a closure that configures the view.
public struct SImageViewStyle<View: SImageView> {

    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: SImageViewStyle<View> {
        return SImageViewStyle { _ in }
    }
}

public extension SImageView {
    
    convenience init<V>(uiImageView: UIImageView = UIImageView(), style: SImageViewStyle<V>) {
        self.init(uiImageView: uiImageView)
        apply(style)
    }

    /// Applies the given style to self.
    func apply<V>(_ style: SImageViewStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    func styled<V>(with style: SImageViewStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

// MARK: - SLabel

/// Represents view style with a closure that configures the view.
public struct SLabelStyle<View: SLabel> {

    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: SLabelStyle<View> {
        return SLabelStyle { _ in }
    }
}

public extension SLabel {
    
    convenience init<V>(uiLabel: UILabel = UILabel(), style: SLabelStyle<V>) {
        self.init(uiLabel: uiLabel)
        apply(style)
    }

    /// Applies the given style to self.
    func apply<V>(_ style: SLabelStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    func styled<V>(with style: SLabelStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

// MARK: - SSwitch

/// Represents view style with a closure that configures the view.
public struct SSwitchStyle<View: SSwitch> {

    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: SSwitchStyle<View> {
        return SSwitchStyle { _ in }
    }
}

public extension SSwitch {
    
    convenience init<V>(uiSwitch: UISwitch = UISwitch(), style: SSwitchStyle<V>) {
        self.init(uiSwitch: uiSwitch)
        apply(style)
    }

    /// Applies the given style to self.
    func apply<V>(_ style: SSwitchStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    func styled<V>(with style: SSwitchStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

// MARK: - STextField

/// Represents view style with a closure that configures the view.
public struct STextFieldStyle<View: STextField> {

    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: STextFieldStyle<View> {
        return STextFieldStyle { _ in }
    }
}

public extension STextField {
    
    convenience init<V>(placeholder: UILabel = UILabel(),
                               placeholderInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 4, right: 0),
                               sTextFieldBase: STextFieldBase = STextFieldBase(),
                               isSecure: Bool = false,
                               underlined: Bool = false,
                               underlineSpacing: CGFloat = 5,
                               style: STextFieldStyle<V>) {
        self.init(placeholder: placeholder, placeholderInsets: placeholderInsets, sTextFieldBase: sTextFieldBase, isSecure: isSecure, underlined: underlined, underlineSpacing: underlineSpacing)
        apply(style)
    }

    /// Applies the given style to self.
    func apply<V>(_ style: STextFieldStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    func styled<V>(with style: STextFieldStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

// MARK: - SPlaceholderTextView

/// Represents view style with a closure that configures the view.
public struct STextViewStyle<View: SPlaceholderTextView> {

    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: STextViewStyle<View> {
        return STextViewStyle { _ in }
    }
}

public extension STextView {
    
    convenience init<V>(frame: CGRect = .zero, textContainer: NSTextContainer? = nil, style: STextViewStyle<V>) {
        self.init(frame: frame, textContainer: textContainer)
        apply(style)
    }

    /// Applies the given style to self.
    func apply<V>(_ style: STextViewStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    func styled<V>(with style: STextViewStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

