//
//  SButton.swift
//  
//
//  Created by Alex Nagy on 23/02/2020.
//

import UIKit
import SparkMisc

public class SButton: UIView {
    
    public var object: UIView?
    var activityIndicatorView = UIActivityIndicatorView()
    
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
    
    public init(uiView: UIView) {
        self.object = uiView
        super.init(frame: .zero)
        
        addSubview(uiView)
        addSubview(activityIndicatorView)
        
        uiView.edgeTo(self)
        activityIndicatorView.centerIn(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startActivityIndicator() {
        isUserInteractionEnabled = false
        self.object?.addFadeTo(0.2)
        activityIndicatorView.startAnimating()
    }
    
    public func stopActivityIndicator() {
        isUserInteractionEnabled = true
        self.object?.addFadeTo(1.0, duration: 0.2, completion: nil)
        activityIndicatorView.stopAnimating()
    }
}
