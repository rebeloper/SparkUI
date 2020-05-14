//
//  SPlaceholderTextView.swift
//  
//
//  Created by Alex Nagy on 04/03/2020.
//

import UIKit
import RSKPlaceholderTextView

public extension STextView {
    
    @discardableResult
    func text(_ text: String) -> SPlaceholderTextView {
        self.text = text
        return self
    }
    
    @discardableResult
    func text(color: UIColor) -> SPlaceholderTextView {
        textColor = color
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String, color: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)) -> SPlaceholderTextView {
        self.placeholder = placeholder as NSString
        self.placeholderColor = color
        return self
    }
    
    @discardableResult
    func background(color: UIColor) -> SPlaceholderTextView {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func maximumNumberOfLines(maximumNumberOfLines: Int) -> SPlaceholderTextView {
        textContainer.maximumNumberOfLines = maximumNumberOfLines
        return self
    }
    
    @discardableResult
    func lineBreakMode(lineBreakMode: NSLineBreakMode) -> SPlaceholderTextView {
        textContainer.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult
    func corner(radius: CGFloat, maskedCorners: CACornerMask = CACornerMask_allCorners) -> SPlaceholderTextView {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat) -> SPlaceholderTextView {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(color: UIColor) -> SPlaceholderTextView {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat, color: UIColor) -> SPlaceholderTextView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> SPlaceholderTextView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> SPlaceholderTextView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> SPlaceholderTextView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> SPlaceholderTextView {
        self.font = font
        return self
    }
    
    @discardableResult
    func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> SPlaceholderTextView {
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
    func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> SPlaceholderTextView {
        if let weight = weight {
            self.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    func bold(_ ofSize: CGFloat = 17.5) -> SPlaceholderTextView {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func italic(_ ofSize: CGFloat = 17.5) -> SPlaceholderTextView {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> SPlaceholderTextView {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool = true) -> SPlaceholderTextView {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> SPlaceholderTextView {
        self.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> SPlaceholderTextView {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func isScrollEnabled(_ isScrollEnabled: Bool) -> SPlaceholderTextView {
        self.isScrollEnabled = isScrollEnabled
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIViewController) -> SPlaceholderTextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    func delegateView(_ delegate: UIView) -> SPlaceholderTextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    func delegateCollectionView(_ delegate: UICollectionViewCell) -> SPlaceholderTextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    func delegateCollectionReusableView(_ delegate: UICollectionReusableView) -> SPlaceholderTextView {
        self.delegate = delegate as? UITextViewDelegate
        return self
    }
    
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> SPlaceholderTextView {
        self.autocorrectionType = autocorrectionType
        return self
    }
}

