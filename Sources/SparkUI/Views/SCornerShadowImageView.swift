//
//  SCornerShadowImageView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowImageView: UIView {
    
    public var object: UIImageView!
    
    public init(_ imageView: UIImageView, radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat, clipsToViewBounds: Bool = true, masksToViewBounds: Bool = true) {
        self.object = imageView
        super.init(frame: .zero)
        backgroundColor = .white
        clipsToBounds = clipsToViewBounds
        layer.masksToBounds = masksToViewBounds
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.cornerRadius = cornerRadius
        
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
