//
//  STextField.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit

public extension STextField {
    
    @discardableResult
    func text(_ text: String) -> STextField {
        object.text = text
        return self
    }
    
    @discardableResult
    func text(_ color: UIColor) -> STextField {
        object.textColor = color
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String) -> STextField {
        object.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func background(color: UIColor) -> STextField {
        object.backgroundColor = color
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> STextField {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> STextField {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> STextField {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> STextField {
        object.font = font
        return self
    }
    
    @discardableResult
    func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> STextField {
        switch textStyle {
        case .regular:
            object.font = .systemFont(ofSize: ofSize)
        case .bold:
            object.font = .boldSystemFont(ofSize: ofSize)
        case .italic:
            object.font = .italicSystemFont(ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> STextField {
        if let weight = weight {
            object.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    func bold(_ ofSize: CGFloat = 17.5) -> STextField {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func italic(_ ofSize: CGFloat = 17.5) -> STextField {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func corner(radius: CGFloat, maskedCorners: CACornerMask = CACornerMask_allCorners) -> STextField {
        object.layer.cornerRadius = radius
        object.layer.maskedCorners = maskedCorners
        object.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat) -> STextField {
        object.layer.borderWidth = width
        object.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(color: UIColor) -> STextField {
        object.layer.borderColor = color.cgColor
        object.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat, color: UIColor) -> STextField {
        object.layer.borderWidth = width
        object.layer.borderColor = color.cgColor
        object.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> STextField {
        object.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> STextField {
        object.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> STextField {
        object.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> STextField {
        object.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> STextField {
        object.isEnabled = !isDisabled
        object.textColor = textColor
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool = true) -> STextField {
        object.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIViewController) -> STextField {
        object.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    func delegateView(_ delegate: UIView) -> STextField {
        object.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    func delegateCollectionView(_ delegate: UICollectionViewCell) -> STextField {
        object.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    func delegateCollectionReusableView(_ delegate: UICollectionReusableView) -> STextField {
        object.delegate = delegate as? UITextFieldDelegate
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> STextField {
        object.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int) -> STextField {
        object.tag = tag
        return self
    }
    
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> STextField {
        object.autocorrectionType = autocorrectionType
        return self
    }
    
}

