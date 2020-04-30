//
//  SHud.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import Layoutless

open class SHud {
    public static let shared = SHud()
    
    private let backgroundView: UIView
    private let hudView: UIView
    private let activityIndicatorView: UIActivityIndicatorView
    private let titleLabel: UILabel
    private let messageLabel: UILabel
    private let animationDuration: TimeInterval
    
    public init(backgroundColor: UIColor = UIColor.systemBlack.withAlphaComponent(0.2),
         hudColor: UIColor = UIColor.systemWhite,
         hudCornerRadius: CGFloat = 10,
         activityIndicatorViewStyle: UIActivityIndicatorView.Style = .large,
         activityIndicatorViewColor: UIColor = .systemBlack,
         titleLabelFont: UIFont = .systemFont(ofSize: 24, weight: .medium),
         titleLabelColor: UIColor = .systemBlack,
         messageLabelFont: UIFont = .systemFont(ofSize: 14, weight: .medium),
         messageLabelColor: UIColor = .systemGray,
         animationDuration: TimeInterval = 0.25) {
        
        self.backgroundView = UIView().setBackground(color: backgroundColor)
        self.hudView = UIView().setBackground(color: hudColor).setCorner(hudCornerRadius)
        self.activityIndicatorView = UIActivityIndicatorView().style(activityIndicatorViewStyle).color(activityIndicatorViewColor)
        self.titleLabel = UILabel().text(color: titleLabelColor).textAlignment(.center).setMultiline().font(titleLabelFont)
        self.messageLabel = UILabel().text(color: messageLabelColor).textAlignment(.center).setMultiline().font(messageLabelFont)
        self.animationDuration = animationDuration
    }
    
    public init(backgroundView: UIView = UIView().setBackground(color: UIColor.systemBlack.withAlphaComponent(0.2)),
         hudView: UIView = UIView().setBackground(color: .systemWhite).setCorner(10),
         activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView().style(.large).color(.systemBlack),
         titleLabel: UILabel = UILabel().text(color: .systemBlack).textAlignment(.center).setMultiline().font(.systemFont(ofSize: 24, weight: .medium)),
         messageLabel: UILabel = UILabel().text(color: .systemGray).textAlignment(.center).setMultiline().font(.systemFont(ofSize: 14, weight: .medium)),
         animationDuration: TimeInterval = 0.25) {
        
        self.backgroundView = backgroundView
        self.hudView = hudView
        self.activityIndicatorView = activityIndicatorView
        self.titleLabel = titleLabel
        self.messageLabel = messageLabel
        self.animationDuration = animationDuration
    }
    
    public func show(withHudView: Bool = false, completion: @escaping () -> () = {}) {
        guard let visibleViewController = visibleViewController() else { return }
        
        clearLabels()
        
        activityIndicatorView.startAnimating()
        
        stack(.vertical)(
            backgroundView
        ).fillingParent().layout(in: visibleViewController.view)
        
        if withHudView {
            stack(.vertical)(
                hudView.sizing(toWidth: Length(integerLiteral: Int(visibleViewController.view.frame.size.width) - 96))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                activityIndicatorView
            ).insetting(by: 24).fillingParent().layout(in: hudView)
        } else {
            stack(.vertical)(
                activityIndicatorView
            ).centeringInParent().layout(in: backgroundView)
        }
        
        backgroundView.alpha = 0.0
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.backgroundView.alpha = 1.0
            completion()
        })
    }
    
    public func show(title: String, message: String, withHudView: Bool = true, completion: @escaping () -> () = {}) {
        guard let visibleViewController = visibleViewController() else { return }
        
        clearLabels()
        
        activityIndicatorView.startAnimating()
        
        stack(.vertical)(
            backgroundView
        ).fillingParent().layout(in: visibleViewController.view)
        
        if withHudView {
            stack(.vertical)(
                hudView.sizing(toWidth: Length(integerLiteral: Int(visibleViewController.view.frame.size.width) - 96))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                activityIndicatorView,
                titleLabel.text(title),
                messageLabel.text(message)
            ).insetting(by: 24).fillingParent().layout(in: hudView)
            
        } else {
            stack(.vertical)(
                hudView.setBackground(color: .clear).sizing(toWidth: Length(integerLiteral: Int(visibleViewController.view.frame.size.width) - 96))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                activityIndicatorView,
                titleLabel.text(title),
                messageLabel.text(message)
            ).insetting(by: 24).fillingParent().layout(in: hudView)
        }
        
        backgroundView.alpha = 0.0
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.backgroundView.alpha = 1.0
            completion()
        })
    }
    
    public func update(title: String, completion: @escaping () -> () = {}) {
        titleLabel.text = title
        completion()
    }
    
    public func update(message: String, completion: @escaping () -> () = {}) {
        messageLabel.text = message
        completion()
    }
    
    public func update(title: String, message: String, completion: @escaping () -> () = {}) {
        titleLabel.text = title
        messageLabel.text = message
        completion()
    }
    
    public func hide(completion: @escaping () -> () = {}) {
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.backgroundView.alpha = 0.0
        }) { finished in
            self.activityIndicatorView.stopAnimating()
            self.backgroundView.removeFromSuperview()
            completion()
        }
    }
    
    public func hideWithAlert(title: String, message: String, completion: @escaping () -> () = {}) {
        hide {
            SAlertController.showAlert(style: .alert, title: title, message: message)
            completion()
        }
    }
    
    public func hideWithSuccessAlert(message: String,completion: @escaping () -> () = {}) {
        hide {
            SAlertController.showSuccess(message: message)
            completion()
        }
    }
    
    public func hideWithWarningAlert(message: String, completion: @escaping () -> () = {}) {
        hide {
            SAlertController.showWarning(message: message)
            completion()
        }
    }
    
    public func hideWithErrorAlert(message: String, completion: @escaping () -> () = {}) {
        hide {
            SAlertController.showError(message: message)
            completion()
        }
    }
    
    private func clearLabels() {
        titleLabel.text = ""
        messageLabel.text = ""
    }
    
}
