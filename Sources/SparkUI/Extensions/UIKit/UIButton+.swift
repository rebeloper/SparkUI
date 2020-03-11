//
//  UIButton+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

extension UIButton {
    
    @discardableResult
    open func image(_ image: UIImage?, renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIButton {
        setImage(image?.withRenderingMode(renderingMode), for: .normal)
        return self
    }
    
    @discardableResult
    open func text(_ text: String) -> UIButton {
        setTitle(text, for: .normal)
        return self
    }
    
    @discardableResult
    open func text(color: UIColor) -> UIButton {
        setTitleColor(color, for: .normal)
        return self
    }
    
    @discardableResult
    open func tint(color: UIColor) -> UIButton {
        tintColor = color
        return self
    }
    
    @discardableResult
    open func background(color: UIColor) -> UIButton {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    open func background(image: UIImage?) -> UIButton {
        setBackgroundImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    open func font(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    open func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> UIButton {
        switch textStyle {
        case .regular:
            titleLabel?.font = .systemFont(ofSize: ofSize)
        case .bold:
            titleLabel?.font = .boldSystemFont(ofSize: ofSize)
        case .italic:
            titleLabel?.font = .italicSystemFont(ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func underlineTextStyle(_ textStyle: TextStyle, underlineStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> UIButton {
        
        switch textStyle {
        case .regular:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
            self.setAttributedTitle(attributeString, for: .normal)
        case .bold:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
            self.setAttributedTitle(attributeString, for: .normal)
        case .italic:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
            self.setAttributedTitle(attributeString, for: .normal)
        }
        return self
    }
    
    @discardableResult
    open func strikethroughTextStyle(_ textStyle: TextStyle, strikethroughStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> UIButton {
        
        switch textStyle {
        case .regular:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
            self.setAttributedTitle(attributeString, for: .normal)
        case .bold:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
            self.setAttributedTitle(attributeString, for: .normal)
        case .italic:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
            self.setAttributedTitle(attributeString, for: .normal)
        }
        return self
    }
    
    @discardableResult
    open func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> UIButton {
        if let weight = weight {
            titleLabel?.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func bold(_ ofSize: CGFloat = 17.5) -> UIButton {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func italic(_ ofSize: CGFloat = 17.5) -> UIButton {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func underlined(_ underlinedTextStyle: TextStyle = .regular, underlineStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> UIButton {
        self.underlineTextStyle(underlinedTextStyle, underlineStyle: underlineStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func strikethrough(_ strikethroughTextStyle: TextStyle = .regular, strikethroughStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> UIButton {
        self.strikethroughTextStyle(strikethroughTextStyle, strikethroughStyle: strikethroughStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    public func corner(radius: CGFloat, maskedCorners: CACornerMask = allCorners) -> UIButton {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat) -> UIButton {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(color: UIColor) -> UIButton {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat, color: UIColor) -> UIButton {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    open func content(mode: UIView.ContentMode) -> UIButton {
        imageView?.contentMode = mode
        return self
    }
    
    @discardableResult
    open func tag(_ tag: Int) -> UIButton {
        self.tag = tag
        return self
    }
    
    @discardableResult
    public func rotate(by angle: CGFloat) -> UIButton {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = transform.rotated(by: radians)
        transform = rotation
        return self
    }
    
    @discardableResult
    public func circular(radius: CGFloat) -> UIButton {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        size(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    public func insets(_ insets: UIEdgeInsets) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right).isActive = true
        return self
    }
    
    @discardableResult
    open func size(_ size: CGSize) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    open func height(_ height: CGFloat) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func width(_ width: CGFloat) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    open func isEnabled(_ isEnabled: Bool) -> UIButton {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    open func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> UIButton {
        self.isEnabled = !isDisabled
        setTitleColor(textColor, for: .normal)
        return self
    }
    
    @discardableResult
    open func isDisabled(_ isDisabled: Bool, textColor: UIColor = .white, backgroundColor: UIColor = .systemGray) -> UIButton {
        self.isEnabled = !isDisabled
        setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    open func isHidden(_ isHidden: Bool = true) -> UIButton {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    open func add(target: Any? = nil, action: Selector? = nil) -> UIButton {
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        return self
    }
}


