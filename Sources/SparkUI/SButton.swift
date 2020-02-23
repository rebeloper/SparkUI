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
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.addFadeTo(0.2) { (success) in
            self.addFadeTo(1.0, duration: 0.2, completion: nil)
        }
    }
    
    public init(uiView: UIView) {
        self.object = uiView
        super.init(frame: .zero)
        
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
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
