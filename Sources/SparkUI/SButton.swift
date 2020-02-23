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
    var activityBackgroundView = UIView().setHidden(true)
    var activityIndicatorView = UIActivityIndicatorView()
    var activityIndicatorViewMessageLabel = UILabel().setMultiline().bold()
    
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
        addSubview(activityBackgroundView)
        
        uiView.edgeTo(self)
        activityBackgroundView.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startActivityIndicator(text: String = "", textColor: UIColor = .systemGray, indicatorColor: UIColor = .systemGray, backgroundColor: UIColor = .systemBackground, borderColor: UIColor = .systemGray, borderWidth: CGFloat = 2, cornerRadius: CGFloat = 10) {
        isUserInteractionEnabled = false
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.color = indicatorColor
        activityIndicatorViewMessageLabel.isHidden(false)
        
        activityBackgroundView
            .setBackground(color: backgroundColor)
            .setBorder(width: borderWidth, color: borderColor)
            .setCorner(cornerRadius)
        activityBackgroundView.isHidden = false
        
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
                self.activityIndicatorViewMessageLabel.addFadeTo(0.0, duration: 0.4) { (finished) in
                    self.activityBackgroundView.isHidden = true
                    self.activityIndicatorViewMessageLabel.isHidden(true)
                    self.activityIndicatorViewMessageLabel.addFadeTo(1.0, duration: 0.0)
                }
            }
        } else {
            isUserInteractionEnabled = true
            self.activityIndicatorViewMessageLabel.addFadeTo(0.0, duration: 0.4) { (finished) in
                self.activityBackgroundView.isHidden = true
                self.activityIndicatorViewMessageLabel.isHidden(true)
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
