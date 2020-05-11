//
//  SNextButton.swift
//  
//
//  Created by Alex Nagy on 05/04/2020.
//

import UIKit
import Layoutless

public class SNextButton: UIView {
    
    public var object: UIView!
    public var accessoryView: UIView!
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        addFadeTo(0.2, duration: 0.0)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        addFadeTo(1.0, duration: 0.2)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        addFadeTo(1.0, duration: 0.2)
    }
    
    public init(
        uiView: UIView? = UILabel()
        .text("Next")
        .text(color: .systemBlue),
        accessoryView: UIView = UIImageView()
        .setSystemImage("chevron.right")
        .templateImageColor(.systemBlue)
        .size(CGSize(width: 22, height: 28))) {
        
        if let uiView = uiView {
            object = uiView
            
            self.accessoryView = accessoryView
            super.init(frame: .zero)
            
            stack(.horizontal)(
                uiView,
                accessoryView
                ).fillingParent().layout(in: self)
        } else {
            let uiView = UIView()
            object = uiView
            
            self.accessoryView = accessoryView
            super.init(frame: .zero)
            
            stack(.horizontal)(
                uiView,
                accessoryView
                ).fillingParent().layout(in: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    public func enable() {
        isUserInteractionEnabled = true
        addFadeTo(1.0, duration: 0.2)
    }
    
    public func disable() {
        isUserInteractionEnabled = false
        addFadeTo(0.5, duration: 0.2)
    }
    
    @discardableResult
    public func enabled() -> SNextButton {
        self.enable()
        return self
    }
    
    @discardableResult
    public func disabled() -> SNextButton {
        self.disable()
        return self
    }
}

