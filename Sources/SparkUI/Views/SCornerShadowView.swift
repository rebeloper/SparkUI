//
//  SCornerShadowView.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

public class SCornerShadowView: SView {
    
    private var shadowRadius: CGFloat
    private var cornerRadius: CGFloat
    
    private var corners: UIRectCorner
    private var shadowColor: UIColor
    private var shadowOpacity: CGFloat
    private var shadowOffset: CGSize
    private var shadowLayerFillColor: UIColor
    
    private var shadowLayer: CAShapeLayer!
    
    public init(shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner = [.allCorners], shadowColor: UIColor = .systemBlack, shadowOpacity: CGFloat = 0.2, shadowOffset: CGSize = CGSize(width: 1.0, height: 1.0), shadowLayerFillColor: UIColor = .systemBackground) {
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        
        self.corners = corners
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.cornerRadius = cornerRadius
        self.shadowLayerFillColor = shadowLayerFillColor
        
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        insertShadowLayer()
    }
    
    func insertShadowLayer() {
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
        }
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        shadowLayer.fillColor = shadowLayerFillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = Float(shadowOpacity)
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.shouldRasterize = true
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let hasUserInterfaceStyleChanged = previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection) else { return }
        
        if hasUserInterfaceStyleChanged {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
    }
    
}

