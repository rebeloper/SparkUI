//
//  UIImageView+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit
import Kingfisher

public extension UIImageView {
    
    @discardableResult
    func background(color: UIColor) -> UIImageView {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func circular(radius: CGFloat) -> UIImageView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        setSize(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    func insets(_ insets: UIEdgeInsets) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right).isActive = true
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> UIImageView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func circular(_ radius: CGFloat) -> UIImageView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        size(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    func square(_ lenght: CGFloat) -> UIImageView {
        layer.masksToBounds = true
        size(CGSize(width: lenght, height: lenght))
        return self
    }
    
    func setImage(from imageUrl: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil, indicatorType: IndicatorType = .none, completion: @escaping (Result<RetrieveImageResult?, Error>) -> () = {_ in}) {
        self.contentMode = contentMode
        if imageUrl.contains("https:") {
            guard let downloadURL = URL(string: imageUrl) else {
                print("Invalid url: \(imageUrl)")
                return
            }
            
            let resource = ImageResource(downloadURL: downloadURL)
            
            self.kf.indicatorType = indicatorType
            self.kf.setImage(with: resource, placeholder: placeholderImage, options: nil) { (result) in
                switch result {
                case .success(let retrieveImageResult):
                    completion(.success(retrieveImageResult))
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.failure(err))
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
    
    func cancelDownload() {
        kf.cancelDownloadTask()
    }
    
    @discardableResult
    func setImage(_ named: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil) -> UIImageView {
        self.contentMode = contentMode
        if UIImage(named: named) != nil {
            self.image = UIImage(named: named)?.withRenderingMode(renderingMode)
        } else if let placeholderImage = placeholderImage {
            self.image = placeholderImage.withRenderingMode(renderingMode)
        }
        return self
    }
    
    @discardableResult
    func setSystemImage(_ systemName: String, configuration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(weight: .regular), renderingMode: UIImage.RenderingMode = .alwaysTemplate, contentMode: UIView.ContentMode = .scaleAspectFit, placeholderImage: UIImage? = nil) -> UIImageView {
        self.contentMode = contentMode
        if UIImage(systemName: systemName) != nil {
            self.image = UIImage(systemName: systemName, withConfiguration: configuration)?.withRenderingMode(renderingMode)
        } else if let placeholderImage = placeholderImage {
            self.image = placeholderImage.withRenderingMode(renderingMode)
        }
        return self
    }
    
    func setImageFrom(urlOrName: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil, indicatorType: IndicatorType = .none) {
        if urlOrName.contains("https") {
            setImage(from: urlOrName, renderingMode: renderingMode, contentMode: contentMode, placeholderImage: placeholderImage, indicatorType: indicatorType)
        } else {
            setImage(urlOrName, renderingMode: renderingMode, contentMode: contentMode, placeholderImage: placeholderImage)
        }
    }
    
    @discardableResult
    func templateImageColor(_ color: UIColor) -> UIImageView {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool = true) -> UIImageView {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: ContentMode) -> UIImageView {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func masksToBounds(_ value: Bool = true) -> UIImageView {
        layer.masksToBounds = value
        return self
    }
    
    @discardableResult
    func cornerRadius(_ radius: CGFloat, maskedCorners: CACornerMask = CACornerMask_allCorners) -> UIImageView {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> UIImageView {
        self.alpha = alpha
        return self
    }
}


