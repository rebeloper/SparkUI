//
//  UIImageView+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit
import Kingfisher

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
    
    open func setImage(from imageUrl: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil, indicatorType: IndicatorType = .none) {
        self.contentMode = contentMode
        if imageUrl.contains("https:") {
            guard let downloadURL = URL(string: imageUrl) else {
                print("Invalid url: \(imageUrl)")
                return
            }
            
            let resource = ImageResource(downloadURL: downloadURL)
            
            self.kf.indicatorType = indicatorType
            self.kf.setImage(with: resource, placeholder: placeholderImage, options: nil, progressBlock: { (receivedSize, totalSize) in
                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
                print("downloading progress: \(percentage)%")
            }) { (result) in
                switch result {
                case .success(let retrieveImageResult):
                    let image = retrieveImageResult.image
                    let cacheType = retrieveImageResult.cacheType
                    let source = retrieveImageResult.source
                    let originalSource = retrieveImageResult.originalSource
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
                    print(err.localizedDescription)
                }
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
    open func setImage(_ named: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil) -> UIImageView {
        self.contentMode = contentMode
        if UIImage(named: named) != nil {
            self.image = UIImage(named: named)?.withRenderingMode(renderingMode)
        } else if let placeholderImage = placeholderImage {
            self.image = placeholderImage.withRenderingMode(renderingMode)
        }
        return self
    }
    
    @discardableResult
    open func setSystemImage(_ systemName: String, configuration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(weight: .regular), renderingMode: UIImage.RenderingMode = .alwaysTemplate, contentMode: UIView.ContentMode = .scaleAspectFit, placeholderImage: UIImage? = nil) -> UIImageView {
        self.contentMode = contentMode
        if UIImage(systemName: systemName) != nil {
            self.image = UIImage(systemName: systemName, withConfiguration: configuration)?.withRenderingMode(renderingMode)
        } else if let placeholderImage = placeholderImage {
            self.image = placeholderImage.withRenderingMode(renderingMode)
        }
        return self
    }
    
    @discardableResult
    open func templateImageColor(_ color: UIColor) -> UIImageView {
        self.tintColor = color
        return self
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


