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
    var text = ""
    
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
        self.text = text
        activityIndicatorView.color = indicatorColor
        
        activityBackgroundView
            .setBackground(color: backgroundColor)
            .setBorder(width: borderWidth, color: borderColor)
            .setCorner(cornerRadius)
        activityBackgroundView.isHidden = false
        
        if self.text != "" {
            stack(.horizontal, spacing: 10)(
                activityIndicatorView,
                activityIndicatorViewMessageLabel.text(self.text).text(color: textColor)
            ).centeringInParent().layout(in: activityBackgroundView)
        } else {
            stack(.horizontal, spacing: 10)(
                activityIndicatorView
            ).centeringInParent().layout(in: activityBackgroundView)
        }
        
        
        
        activityIndicatorView.startAnimating()
    }
    
    public func updateActivityIndicator(text: String) {
        if self.text != "" {
            activityIndicatorViewMessageLabel.text(text)
        } else {
            print("ERROR: SButton 'updateActivityIndicator' error: Could not update activity indicator with text: \(text) -> Please start the 'startActivityIndicator' with the 'text' parameter with a non-empty string")
        }
        
    }
    
    public func stopActivityIndicator(text: String = "") {
        activityIndicatorView.stopAnimating()
        activityIndicatorViewMessageLabel.text(text)
        
        if self.text != "" {
            SDispatchQueue.delay(bySeconds: 1) {
                self.isUserInteractionEnabled = true
                self.activityIndicatorViewMessageLabel.addFadeTo(0.0, duration: 0.4) { (finished) in
                    self.activityBackgroundView.isHidden = true
                    self.activityIndicatorViewMessageLabel.addFadeTo(1.0, duration: 0.0)
                }
            }
        } else {
            isUserInteractionEnabled = true
            self.activityIndicatorViewMessageLabel.addFadeTo(0.0, duration: 0.4) { (finished) in
                self.activityBackgroundView.isHidden = true
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
