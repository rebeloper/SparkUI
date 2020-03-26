//
//  UIImageView+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    @discardableResult
    public func background(color: UIColor) -> UIImageView {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func circular(radius: CGFloat) -> UIImageView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        setSize(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    public func insets(_ insets: UIEdgeInsets) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right).isActive = true
        return self
    }
    
    @discardableResult
    open func size(_ size: CGSize) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    open func height(_ height: CGFloat) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func width(_ width: CGFloat) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    open func setImage(from imageUrl: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil) {
        self.contentMode = contentMode
        if imageUrl.contains("https:") {
            self.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholderImage) { (image, err, cacheType, url) in
                guard let url = url else {
                    print("SDWebImage error: Invalid url provided: \(imageUrl)")
                    return
                }
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                guard image != nil else {
                    print("SDWebImage error: Could not load image; it is nil")
                    return
                }
                print("Successfully loaded image from Url: \(url.absoluteString) with Cache Type: \(cacheType)")
            }
        } else {
            if UIImage(named: imageUrl) != nil {
                self.image = UIImage(named: imageUrl)?.withRenderingMode(renderingMode)
            } else if let placeholderImage = placeholderImage {
                self.image = placeholderImage.withRenderingMode(renderingMode)
            }
        }
    }
    
    @discardableResult
    open func isHidden(_ isHidden: Bool = true) -> UIImageView {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    open func contentMode(_ contentMode: ContentMode) -> UIImageView {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    open func masksToBounds(_ value: Bool = true) -> UIImageView {
        layer.masksToBounds = value
        return self
    }
    
    @discardableResult
    open func cornerRadius(_ radius: CGFloat, maskedCorners: CACornerMask = CACornerMask_allCorners) -> UIImageView {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
}


