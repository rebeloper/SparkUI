//
//  UIImage+.swift
//  
//
//  Created by Alex Nagy on 23/04/2020.
//

import UIKit

extension UIImage {
    
    public func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    public func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    public func aspectRatio(_ aspectRatioBase: AspectRatioBase = .width) -> CGFloat {
        switch aspectRatioBase {
        case .width:
            return size.width / size.height
        case .height:
            return size.height / size.width
        }
    }
}

