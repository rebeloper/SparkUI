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
    public func corner(radius: CGFloat) -> STextView {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
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
}

