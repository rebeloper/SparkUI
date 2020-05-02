//
//  SBlurView.swift
//  
//
//  Created by Alex Nagy on 03/05/2020.
//

import UIKit

open class SBlurView: UIVisualEffectView {
    
    private var animator: UIViewPropertyAnimator!
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    
    public init(style: UIBlurEffect.Style, intensity: CGFloat) {
        super.init(effect: nil)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = UIBlurEffect(style: style) }
        animator.fractionComplete = intensity
    }
    
    public init(color: UIColor? = nil, alpha: CGFloat = 0.5, blurRadius: CGFloat = 3, scale: CGFloat = 1.0) {
        super.init(effect: nil)
        blurEffect.setValue(color, forKeyPath: "colorTint")
        blurEffect.setValue(alpha, forKeyPath: "colorTintAlpha")
        blurEffect.setValue(blurRadius, forKeyPath: "blurRadius")
        blurEffect.setValue(scale, forKeyPath: "scale")
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = self.blurEffect }
        animator.fractionComplete = 1.0
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
