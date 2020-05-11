//
//  SBlurView.swift
//  
//
//  Created by Alex Nagy on 03/05/2020.
//

import UIKit
import Layoutless

open class SBlurView: UIView {
    
    public var visualEffectView: SVisualEffectView?
    
    public init(style: UIBlurEffect.Style, intensity: CGFloat) {
        super.init(frame: .zero)
        visualEffectView = SVisualEffectView(style: style, intensity: intensity)
        
        guard let visualEffectView = visualEffectView else { return }
        stack(.vertical)(
            visualEffectView
            ).fillingParent().layout(in: self)
    }
    
    public init(color: UIColor? = nil, alpha: CGFloat = 0.5, blurRadius: CGFloat = 3, scale: CGFloat = 1.0) {
        super.init(frame: .zero)
        visualEffectView = SVisualEffectView(color: color, alpha: alpha, blurRadius: blurRadius, scale: scale)
        
        guard let visualEffectView = visualEffectView else { return }
        stack(.vertical)(
            visualEffectView
        ).fillingParent().layout(in: self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
}
