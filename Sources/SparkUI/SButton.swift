//
//  SButton.swift
//  
//
//  Created by Alex Nagy on 23/02/2020.
//

import UIKit
import Layoutless
import SparkMisc

public class SButton: UIView {
    
    public var object: UIView?
    var activityIndicatorView = UIActivityIndicatorView()
    var activityIndicatorViewMessageLabel = UILabel().bold()
    
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
        object = uiView
        super.init(frame: .zero)
        
        addSubview(uiView)
        uiView.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startActivityIndicator(text: String = "", textColor: UIColor = .systemGray, indicatorColor: UIColor = .systemGray) {
        isUserInteractionEnabled = false
        
        activityIndicatorView.color = indicatorColor
        activityIndicatorViewMessageLabel.isHidden(false)
        
        object?.addFadeTo(0.05, duration: 0.0)
        stack(.horizontal, spacing: 10)(
            activityIndicatorView,
            activityIndicatorViewMessageLabel.text(text).text(color: textColor)
        ).centeringInParent().layout(in: self)
        
        activityIndicatorView.startAnimating()
    }
    
    public func updateActivityIndicator(text: String) {
        activityIndicatorViewMessageLabel.text(text)
    }
    
    public func stopActivityIndicator(text: String = "") {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        activityIndicatorViewMessageLabel.text(text)
        
        if text != "" {
            SDispatchQueue.delay(bySeconds: 1) {
                self.isUserInteractionEnabled = true
                self.object?.addFadeTo(1.0, duration: 0.4, completion: nil)
                self.activityIndicatorViewMessageLabel.addFadeTo(0.0, duration: 0.4) { (finished) in
                    self.activityIndicatorViewMessageLabel.isHidden(true)
                    self.activityIndicatorView.isHidden = false
                    self.activityIndicatorViewMessageLabel.addFadeTo(1.0, duration: 0.0)
                }
            }
        } else {
            isUserInteractionEnabled = true
            object?.addFadeTo(1.0, duration: 0.4, completion: nil)
            self.activityIndicatorViewMessageLabel.addFadeTo(0.0, duration: 0.4) { (finished) in
                self.activityIndicatorViewMessageLabel.isHidden(true)
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorViewMessageLabel.addFadeTo(1.0, duration: 0.0)
            }
        }
    }
    
    public func stopActivityIndicatorWithError() {
        activityIndicatorViewMessageLabel.text(color: .systemRed)
        stopActivityIndicator(text: "Error")
    }
    
    public func stopActivityIndicatorWithSuccess() {
        activityIndicatorViewMessageLabel.text(color: .systemGreen)
        stopActivityIndicator(text: "Success")
    }
}
