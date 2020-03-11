//
//  SCornerShadowView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowView: UIView {
    
    public init(shadowRadius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat, maskedCorners: CACornerMask? = nil) {
        super.init(frame: .zero)
        
        let shadowView = UIView()
        shadowView.backgroundColor = .systemBackground
        
        shadowView.clipsToBounds = true
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = color.cgColor
        shadowView.layer.shadowOffset = offset
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOpacity = opacity
        shadowView.layer.cornerRadius = cornerRadius
        
        addSubview(shadowView)
        shadowView.edgeTo(self)
        
        if let maskedCorners = maskedCorners {
            let maskView = UIView()
            maskView.backgroundColor = .systemBackground
            maskView.layer.masksToBounds = true
            maskView.layer.maskedCorners = maskedCorners
            
            addSubview(maskView)
            maskView.edgeTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

