//
//  STextField.swift
//  
//
//  Created by Alex Nagy on 04/03/2020.
//

import UIKit

open class STextField: UITextField {
    
    public let insets: UIEdgeInsets
    
    public init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension STextField {
    
    @discardableResult
    open func text(_ text: String) -> STextField {
        self.text = text
        return self
    }
    
    @discardableResult
    open func text(_ color: UIColor) -> STextField {
        textColor = color
        return self
    }
    
    @discardableResult
    open func placeholder(_ placeholder: String) -> STextField {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    open func background(color: UIColor) -> STextField {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> STextField {
        self.font = font
        return self
    }
    
    public enum TextStyle {
        case regular, bold, italic
    }
    
    @discardableResult
    open func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> STextField {
        switch textStyle {
        case .regular:
            self.font = .systemFont(ofSize: ofSize)
        case .bold:
            self.font = .boldSystemFont(ofSize: ofSize)
        case .italic:
            self.font = .italicSystemFont(ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> STextField {
        if let weight = weight {
            self.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func bold(_ ofSize: CGFloat = 17.5) -> STextField {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func italic(_ ofSize: CGFloat = 17.5) -> STextField {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    public func corner(radius: CGFloat) -> STextField {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat) -> STextField {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(color: UIColor) -> STextField {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat, color: UIColor) -> STextField {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> STextField {
        self.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> STextField {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    public func isSecureTextEntry(_ isSecureTextEntry: Bool) -> STextField {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    open func isEnabled(_ isEnabled: Bool) -> STextField {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    open func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> STextField {
        self.isEnabled = !isDisabled
        self.textColor = textColor
        return self
    }
    
    @discardableResult
    open func isHidden(_ isHidden: Bool = true) -> STextField {
        self.isHidden = isHidden
        return self
    }
    
}



