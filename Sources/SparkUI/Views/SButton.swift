//
//  SButton.swift
//  
//
//  Created by Alex Nagy on 23/02/2020.
//

import UIKit
import Layoutless

public class SButton: UIView {
    
    public var object: UIView!
    var activityContainerView = UIView().alpha(0)
    var activityIndicatorView = UIActivityIndicatorView()
    var activityIndicatorViewMessageLabel = UILabel().bold()
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
        addSubview(activityContainerView)
        
        uiView.edgeTo(self)
        activityContainerView.edgeTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startActivityIndicator(text: String = "", textColor: UIColor = .systemGray, indicatorColor: UIColor = .systemGray, backgroundColor: UIColor = .systemBackground, borderColor: UIColor = .systemGray, borderWidth: CGFloat = 2, cornerRadius: CGFloat = 10) {
        isUserInteractionEnabled = false
        self.text = text
        activityIndicatorView.color = indicatorColor
        
        activityContainerView
            .setBackground(color: backgroundColor)
            .setBorder(width: borderWidth, color: borderColor)
            .setCorner(cornerRadius)
        
        if self.text != "" {
            stack(.horizontal, spacing: 10)(
                activityIndicatorView,
                activityIndicatorViewMessageLabel.text(self.text).text(color: textColor)
            ).centeringInParent().layout(in: activityContainerView)
        } else {
            stack(.horizontal)(
                activityIndicatorView
            ).centeringInParent().layout(in: activityContainerView)
        }
        
        self.activityContainerView.addFadeTo(1.0, duration: 0.4)
        
        activityIndicatorView.startAnimating()
    }
    
    public func updateActivityIndicator(text: String) {
        if self.text != "" {
            activityIndicatorViewMessageLabel.text(text)
        } else {
            print("ERROR: SButton 'updateActivityIndicator' error: Could not update activity indicator with text: \(text) -> Please start the 'startActivityIndicator' with the 'text' parameter as a non-empty string")
        }
        
    }
    
    public func stopActivityIndicator(text: String = "", completion: @escaping (Bool) -> () = { _ in }) {
        activityIndicatorView.stopAnimating()
        activityIndicatorViewMessageLabel.text(text)
        
        if self.text != "" {
            SDispatchQueue.delay(bySeconds: 1) {
                self.isUserInteractionEnabled = true
                self.activityContainerView.addFadeTo(0.0, duration: 0.4)
                completion(true)
            }
        } else {
            isUserInteractionEnabled = true
            self.activityContainerView.addFadeTo(0.0, duration: 0.4)
            completion(true)
        }
    }
    
    public func stopActivityIndicatorWithError(completion: @escaping (Bool) -> () = { _ in }) {
        activityIndicatorViewMessageLabel.text(color: .systemRed)
        stopActivityIndicator(text: "Error", completion: completion)
    }
    
    public func stopActivityIndicatorWithSuccess(completion: @escaping (Bool) -> () = { _ in }) {
        activityIndicatorViewMessageLabel.text(color: .systemGreen)
        stopActivityIndicator(text: "Success", completion: completion)
    }
    
    public func enable() {
        isUserInteractionEnabled = true
        addFadeTo(1.0, duration: 0.2)
    }
    
    public func disable() {
        isUserInteractionEnabled = false
        addFadeTo(0.5, duration: 0.2)
    }
}
