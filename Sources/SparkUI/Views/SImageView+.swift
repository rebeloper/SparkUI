//
//  SImageView+.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit
import Kingfisher

public extension SImageView {
    
    @discardableResult
    func background(color: UIColor) -> SImageView {
        self.object.backgroundColor = color
        return self
    }
    
    @discardableResult
    func circular(radius: CGFloat) -> SImageView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        setSize(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> SImageView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> SImageView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> SImageView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    func setImage(from imageUrl: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil, indicatorType: IndicatorType = .none, completion: @escaping (Result<RetrieveImageResult?, Error>) -> () = {_ in}) {
        self.object.contentMode = contentMode
        if imageUrl.contains("https:") {
            guard let downloadURL = URL(string: imageUrl) else {
                print("Invalid url: \(imageUrl)")
                return
            }
            
            let resource = ImageResource(downloadURL: downloadURL)
            
            self.object.kf.indicatorType = indicatorType
            self.object.kf.setImage(with: resource, placeholder: placeholderImage, options: nil) { (result) in
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
                self.object.image = UIImage(named: imageUrl)?.withRenderingMode(renderingMode)
            } else if let placeholderImage = placeholderImage {
                self.object.image = placeholderImage.withRenderingMode(renderingMode)
            }
        }
    }
    
    func cancelDownload() {
        object.kf.cancelDownloadTask()
    }
    
    @discardableResult
    func setImage(_ named: String, renderingMode: UIImage.RenderingMode = .alwaysOriginal, contentMode: UIView.ContentMode = .scaleAspectFill, placeholderImage: UIImage? = nil) -> SImageView {
        self.object.contentMode = contentMode
        if UIImage(named: named) != nil {
            self.object.image = UIImage(named: named)?.withRenderingMode(renderingMode)
        } else if let placeholderImage = placeholderImage {
            self.object.image = placeholderImage.withRenderingMode(renderingMode)
        }
        return self
    }
    
    @discardableResult
    func setSystemImage(_ systemName: String, renderingMode: UIImage.RenderingMode = .alwaysTemplate, contentMode: UIView.ContentMode = .scaleAspectFit, placeholderImage: UIImage? = nil) -> SImageView {
        self.object.contentMode = contentMode
        if UIImage(systemName: systemName) != nil {
            self.object.image = UIImage(systemName: systemName)?.withRenderingMode(renderingMode)
        } else if let placeholderImage = placeholderImage {
            self.object.image = placeholderImage.withRenderingMode(renderingMode)
        }
        return self
    }
    
    @discardableResult
    func templateImageColor(_ color: UIColor) -> SImageView {
        self.object.tintColor = color
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool = true) -> SImageView {
        self.object.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: ContentMode) -> SImageView {
        self.object.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func masksToBounds(_ value: Bool = true) -> SImageView {
        object.layer.masksToBounds = value
        return self
    }
    
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> SImageView {
        object.layer.cornerRadius = radius
        object.layer.masksToBounds = true
        return self
    }
}


