//
//  SBackButton.swift
//  
//
//  Created by Alex Nagy on 05/04/2020.
//

import UIKit
import Layoutless

public class SBackButton: UIView {
    
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
        uiView: UIView = UILabel()
        .text("Back")
        .text(color: .systemBlue),
        accessoryView: UIView = UIImageView()
        .setSystemImage("chevron.left")
        .templateImageColor(.systemBlue)
        .size(CGSize(width: 22, height: 28))) {
        
        object = uiView
        self.accessoryView = accessoryView
        super.init(frame: .zero)
        
        stack(.horizontal)(
            accessoryView,
            uiView
            ).fillingParent().layout(in: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    public func enabled() -> SBackButton {
        self.enable()
        return self
    }
    
    @discardableResult
    public func disabled() -> SBackButton {
        self.disable()
        return self
    }
}


