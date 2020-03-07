//
//  SCornerShadowButtonView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowButtonView: UIView {
    
    public var object: UIButton!
    
    public init(_ button: UIButton, radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        self.object = button
        super.init(frame: .zero)
        backgroundColor = .white
        clipsToBounds       = true
        layer.masksToBounds = false
        layer.shadowColor   = color.cgColor
        layer.shadowOffset  = offset
        layer.shadowRadius  = radius
        layer.shadowOpacity = opacity
        layer.cornerRadius  = cornerRadius
        
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        addSubview(button)
        button.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

