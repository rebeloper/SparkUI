//
//  STextField.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit

extension STextField {
    
    @discardableResult
    open func text(_ text: String) -> STextField {
        object?.text = text
        return self
    }
    
    @discardableResult
    open func text(_ color: UIColor) -> STextField {
        object?.textColor = color
        return self
    }
    
    @discardableResult
    open func placeholder(_ placeholder: String) -> STextField {
        object?.placeholder = placeholder
        return self
    }
    
    @discardableResult
    open func background(color: UIColor) -> STextField {
        object?.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> STextField {
        object?.font = font
        return self
    }
    
    @discardableResult
    open func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> STextField {
        switch textStyle {
        case .regular:
            object?.font = .systemFont(ofSize: ofSize)
        case .bold:
            object?.font = .boldSystemFont(ofSize: ofSize)
        case .italic:
            object?.font = .italicSystemFont(ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> STextField {
        if let weight = weight {
            object?.font = .systemFont(ofSize: ofSize, weight: weight)
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
        object?.layer.cornerRadius = radius
        object?.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat) -> STextField {
        object?.layer.borderWidth = width
        object?.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(color: UIColor) -> STextField {
        object?.layer.borderColor = color.cgColor
        object?.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat, color: UIColor) -> STextField {
        object?.layer.borderWidth = width
        object?.layer.borderColor = color.cgColor
        object?.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> STextField {
        object?.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> STextField {
        object?.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    public func isSecureTextEntry(_ isSecureTextEntry: Bool) -> STextField {
        object?.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    open func isEnabled(_ isEnabled: Bool) -> STextField {
        object?.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    open func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> STextField {
        object?.isEnabled = !isDisabled
        object?.textColor = textColor
        return self
    }
    
    @discardableResult
    open func isHidden(_ isHidden: Bool = true) -> STextField {
        object?.isHidden = isHidden
        return self
    }
    
    @discardableResult
    open func delegate(_ delegate: UIViewController) -> STextField {
        object?.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    open func delegateView(_ delegate: UIView) -> STextField {
        object?.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    open func delegateCollectionView(_ delegate: UICollectionViewCell) -> STextField {
        object?.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    open func delegateCollectionReusableView(_ delegate: UICollectionReusableView) -> STextField {
        object?.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> STextField {
        object?.textAlignment = textAlignment
        return self
    }
    
}

