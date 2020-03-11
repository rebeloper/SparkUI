//
//  SCornerShadowView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowView: UIView {
    
    public init(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat, clipsToViewBounds: Bool = true, masksToViewBounds: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = .white
        clipsToBounds = clipsToViewBounds
        layer.masksToBounds = masksToViewBounds
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
//        layer.cornerRadius = cornerRadius
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10).cgPath)
        layer.mask = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

