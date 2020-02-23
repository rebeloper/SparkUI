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
        self.object?.alpha = 0.2
        SDispatchQueue.delay(bySeconds: 1) {
            self.object?.alpha = 1.0
        }
    }
    
    public init(uiView: UIView) {
        self.object = uiView
        super.init(frame: .zero)
        
        uiView.addGestureRecognizer(tap)
        uiView.isUserInteractionEnabled = true
        
        addSubview(uiView)
        addSubview(activityIndicatorView)
        
        uiView.edgeTo(self)
        activityIndicatorView.centerIn(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startActivityIndicator() {
        self.object?.alpha = 0.2
        activityIndicatorView.startAnimating()
    }
    
    public func stopActivityIndicator() {
        self.object?.alpha = 1.0
        activityIndicatorView.stopAnimating()
    }
}
