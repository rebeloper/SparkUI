//
//  SHud.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import Layoutless

public typealias Hud = SHud

public enum SHudDelay: Double {
    case none = 0.0
    case mini = 1.0
    case short = 2.0
    case normal = 3.0
    case long = 4.0
    case extraLong = 5.0
}

open class SHud {
    public static let apply = SHud()
    
    private let backgroundView: UIView
    private let hudView: UIView
    private let activityIndicatorView: UIActivityIndicatorView
    private let titleLabel: UILabel
    private let messageLabel: UILabel
    private let animationDuration: TimeInterval
    
    private let headerView = UIView()
    private let headerImageView = UIImageView()
        .setSystemImage("exclamationmark.triangle", configuration: UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 14), scale: .large))
        .templateImageColor(.systemOrange)
    
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
            activityIndicatorView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            headerImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            backgroundView
        ).fillingParent().layout(in: visibleViewController.view)
        
        if withHudView {
            stack(.vertical)(
                hudView.sizing(toWidth: Length(integerLiteral: Int(visibleViewController.view.frame.size.width) - 96))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                headerView
            ).insetting(by: 24).fillingParent().layout(in: hudView)
        } else {
            stack(.vertical)(
                headerView
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
//            activityIndicatorView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            headerImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            backgroundView
        ).fillingParent().layout(in: visibleViewController.view)
        
        if withHudView {
            stack(.vertical)(
                hudView.sizing(toWidth: Length(integerLiteral: Int(visibleViewController.view.frame.size.width) - 96))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                headerView,
                titleLabel.text(title),
                messageLabel.text(message)
            ).insetting(by: 24).fillingParent().layout(in: hudView)
            
        } else {
            stack(.vertical)(
                hudView.setBackground(color: .clear).sizing(toWidth: Length(integerLiteral: Int(visibleViewController.view.frame.size.width) - 96))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                headerView,
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
    
    public func showWorking(message: String, withHudView: Bool = true, completion: @escaping () -> () = {}) {
        show(title: "Working", message: message, withHudView: withHudView) {
            completion()
        }
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
    
    public func hide(with delay: SHudDelay = .none, completion: @escaping () -> () = {}) {
        SDispatchQueue.delay(bySeconds: delay.rawValue) {
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.backgroundView.alpha = 0.0
            }) { finished in
                self.activityIndicatorView.stopAnimating()
                self.backgroundView.removeFromSuperview()
                completion()
            }
        }
    }
    
    public func hideWithAlert(title: String, message: String, completion: @escaping () -> () = {}) {
        hide {
            Alert.show(.alert, title: title, message: message)
            completion()
        }
    }
    
    public func hideWithSuccessAlert(message: String, completion: @escaping () -> () = {}) {
        hide {
            Alert.showSuccess(message: message)
            completion()
        }
    }
    
    public func hideWithWarningAlert(message: String, completion: @escaping () -> () = {}) {
        hide {
            Alert.showWarning(message: message)
            completion()
        }
    }
    
    public func hideWithErrorAlert(message: String, completion: @escaping () -> () = {}) {
        hide {
            Alert.showError(message: message)
            completion()
        }
    }
    
    public func hide(with delay: SHudDelay = .short, title: String, message: String, completion: @escaping () -> () = {}) {
        update(title: title, message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    public func hideWithSuccess(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        update(title: "Success", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    public func hideWithWarning(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        update(title: "Warning", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    public func hideWithError(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        update(title: "Error", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    private func clearLabels() {
        titleLabel.text = ""
        messageLabel.text = ""
    }
    
}
