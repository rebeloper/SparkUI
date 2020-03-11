//
//  SCornerShadowView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowView: UIView {
    
    public init(shadowRadius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat, corners: UIRectCorner, clipsToViewBounds: Bool = true, masksToViewBounds: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = .white
        clipsToBounds = clipsToViewBounds
        layer.masksToBounds = masksToViewBounds
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        roundCorners(corners: UIRectCorner, radius: cornerRadius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

