//
//  SButton.swift
//  
//
//  Created by Alex Nagy on 23/02/2020.
//

import UIKit

public class SButton: UIView {
    
    public var object: UIView?
    var activityIndicatorView = UIActivityIndicatorView()
    
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
        object?.alpha = 0.2
        activityIndicatorView.startAnimating()
    }
    
    public func stopActivityIndicator() {
        object?.alpha = 1.0
        activityIndicatorView.stopAnimating()
    }
}
