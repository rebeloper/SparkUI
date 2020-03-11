//
//  STextView.swift
//  
//
//  Created by Alex Nagy on 04/03/2020.
//

import UIKit
import RSKPlaceholderTextView

public typealias STextView = RSKPlaceholderTextView

extension STextView {
    
    @discardableResult
    open func text(_ text: String) -> STextView {
        self.text = text
        return self
    }
    
    @discardableResult
    open func placeholder(_ placeholder: String, color: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)) -> STextView {
        self.placeholder = placeholder as NSString
        self.placeholderColor = color
        return self
    }
    
    @discardableResult
    open func background(color: UIColor) -> STextView {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    public func corner(radius: CGFloat, maskedCorners: CACornerMask = allCorners) -> STextView {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat) -> STextView {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(color: UIColor) -> STextView {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat, color: UIColor) -> STextView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    open func size(_ size: CGSize) -> STextView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    open func height(_ height: CGFloat) -> STextView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func width(_ width: CGFloat) -> STextView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> STextView {
        self.font = font
        return self
    }
    
    @discardableResult
    open func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> STextView {
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
    open func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> STextView {
        if let weight = weight {
            self.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func bold(_ ofSize: CGFloat = 17.5) -> STextView {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func italic(_ ofSize: CGFloat = 17.5) -> STextView {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> STextView {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    open func isHidden(_ isHidden: Bool = true) -> STextView {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    public func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> STextView {
        self.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> STextView {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    open func isScrollEnabled(_ isScrollEnabled: Bool) -> STextView {
        self.isScrollEnabled = isScrollEnabled
        return self
    }
    
    @discardableResult
    open func delegate(_ delegate: UIViewController) -> STextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    open func delegateView(_ delegate: UIView) -> STextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    open func delegateCollectionView(_ delegate: UICollectionViewCell) -> STextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    open func delegateCollectionReusableView(_ delegate: UICollectionReusableView) -> STextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
}

