//
//  UIButton+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit
import Kingfisher
import Layoutless

public extension UIButton {
    
    func setImage(from imageUrl: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil) {
        imageView?.contentMode = contentMode
        if imageUrl.contains("https:") {
            guard let downloadURL = URL(string: imageUrl) else {
                print("Invalid url: \(imageUrl)")
                return
            }
            
            let resource = ImageResource(downloadURL: downloadURL)
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: { (receivedSize, totalSize) in
                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
                print("downloading progress: \(percentage)%")
            }, downloadTaskUpdated: nil) { (result) in
                switch result {
                case .success(let retrieveImageResult):
                    let image = retrieveImageResult.image
                    let cacheType = retrieveImageResult.cacheType
                    let source = retrieveImageResult.source
                    let originalSource = retrieveImageResult.originalSource
                    self.setImage(image.withRenderingMode(renderingMode), for: .normal)
                    let message = """
                    - 🌄 ------------------------
                    Successfully loaded image
                    Image size:
                    \(image.size)
                    Cache type:
                    \(cacheType)
                    Source:
                    \(source)
                    Original source:
                    \(originalSource)
                    - 🌄 ------------------------
                    """
                    print(message)
                case .failure(let err):
                    if let placeholderImage = placeholderImage {
                        self.setImage(placeholderImage.withRenderingMode(renderingMode), for: .normal)
                    }
                    self.setImage(placeholderImage?.withRenderingMode(renderingMode), for: .normal)
                    print(err.localizedDescription)
                }
            }
        } else {
            if UIImage(named: imageUrl) != nil {
                setImage(UIImage(named: imageUrl)?.withRenderingMode(renderingMode), for: .normal)
            } else if let placeholderImage = placeholderImage {
                setImage(placeholderImage.withRenderingMode(renderingMode), for: .normal)
            }
        }
    }
    
    @discardableResult
    func image(_ image: UIImage?, renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIButton {
        setImage(image?.withRenderingMode(renderingMode), for: .normal)
        return self
    }
    
    @discardableResult
    func text(_ text: String) -> UIButton {
        setTitle(text, for: .normal)
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString) -> UIButton {
        setAttributedTitle(text, for: .normal)
        return self
    }
    
    @discardableResult
    func text(color: UIColor) -> UIButton {
        setTitleColor(color, for: .normal)
        return self
    }
    
    @discardableResult
    func textAlignment(_ alignment: ContentHorizontalAlignment) -> UIButton {
        contentHorizontalAlignment = alignment
        return self
    }
    
    @discardableResult
    func setImageOnRight() -> UIButton {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return self
    }
    
    @discardableResult
    func setImageOnFarRight() -> UIButton {
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        return self
    }
    
    @discardableResult
    func underline(with color: UIColor = .systemGray5, height: CGFloat = 0.5) -> UIButton {
        let underlineView = UIView().setBackground(color: color)
        underlineView.setHeight(height)
        underlineView.stickingToParentEdges(left: 12, right: 0, bottom: 0).layout(in: self)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> UIButton {
        titleLabel?.numberOfLines(numberOfLines)
        return self
    }
    
    @discardableResult
    func setMultiline() -> UIButton {
        titleLabel?.setMultiline()
        return self
    }
    
    @discardableResult
    func tint(color: UIColor) -> UIButton {
        tintColor = color
        return self
    }
    
    @discardableResult
    func background(color: UIColor) -> UIButton {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func background(image: UIImage?) -> UIButton {
        setBackgroundImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> UIButton {
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
    func underlineTextStyle(_ textStyle: TextStyle, underlineStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> UIButton {
        
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
    func strikethroughTextStyle(_ textStyle: TextStyle, strikethroughStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> UIButton {
        
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
    func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> UIButton {
        if let weight = weight {
            titleLabel?.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    func bold(_ ofSize: CGFloat = 17.5) -> UIButton {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func italic(_ ofSize: CGFloat = 17.5) -> UIButton {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func underlined(_ underlinedTextStyle: TextStyle = .regular, underlineStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> UIButton {
        self.underlineTextStyle(underlinedTextStyle, underlineStyle: underlineStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func strikethrough(_ strikethroughTextStyle: TextStyle = .regular, strikethroughStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> UIButton {
        self.strikethroughTextStyle(strikethroughTextStyle, strikethroughStyle: strikethroughStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func corner(radius: CGFloat, maskedCorners: CACornerMask = CACornerMask_allCorners) -> UIButton {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat) -> UIButton {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(color: UIColor) -> UIButton {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat, color: UIColor) -> UIButton {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func content(mode: UIView.ContentMode) -> UIButton {
        imageView?.contentMode = mode
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int) -> UIButton {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func rotate(by angle: CGFloat) -> UIButton {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = transform.rotated(by: radians)
        transform = rotation
        return self
    }
    
    @discardableResult
    func circular(radius: CGFloat) -> UIButton {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        size(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    func insets(_ insets: UIEdgeInsets) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right).isActive = true
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> UIButton {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> UIButton {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> UIButton {
        self.isEnabled = !isDisabled
        setTitleColor(textColor, for: .normal)
        return self
    }
    
    @discardableResult
    func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemWhite, backgroundColor: UIColor = .systemGray) -> UIButton {
        self.isEnabled = !isDisabled
        setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool = true) -> UIButton {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func add(target: Any? = nil, action: Selector? = nil) -> UIButton {
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        return self
    }
}


