//
//  SStyle.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

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

extension STextField {
    
    public convenience init<V>(style: STextFieldStyle<V>, sTextFieldBase: STextFieldBase = STextFieldBase(), isSecure: Bool = false, underlined: Bool = false, underlineSpacing: CGFloat = 5) {
        self.init(sTextFieldBase: sTextFieldBase, isSecure: isSecure, underlined: underlined, underlineSpacing: underlineSpacing)
        apply(style)
    }

    /// Applies the given style to self.
    public func apply<V>(_ style: STextFieldStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    public func styled<V>(with style: STextFieldStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

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

extension SButton {
    
    public convenience init<V>(uiView: UIView, style: SButtonStyle<V>) {
        self.init(uiView: uiView)
        apply(style)
    }

    /// Applies the given style to self.
    public func apply<V>(_ style: SButtonStyle<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    public func styled<V>(with style: SButtonStyle<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

