//
//  SCornerShadowButtonView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowButtonView: UIView {
    
    public var object: UIButton!
    
    public init(_ button: UIButton, radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat, maskedCorners: SCornerMask, clipsToViewBounds: Bool = true, masksToViewBounds: Bool = false) {
        self.object = button
        super.init(frame: .zero)
        backgroundColor = .white
        clipsToBounds  = clipsToViewBounds
        layer.masksToBounds = masksToViewBounds
        layer.shadowColor   = color.cgColor
        layer.shadowOffset  = offset
        layer.shadowRadius  = radius
        layer.shadowOpacity = opacity
        layer.cornerRadius  = cornerRadius
        layer.maskedCorners = maskedCorners
        
        button.layer.cornerRadius = cornerRadius
        button.layer.maskedCorners = maskedCorners
        button.clipsToBounds = clipsToViewBounds
        addSubview(button)
        button.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

