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
    
    private let size = UIScreen.main.bounds.size
    
    private let backgroundView: UIView
    private let hudView: UIView
    private let hudHorizontalPadding: Int
    private let activityIndicatorView: UIActivityIndicatorView
    private let titleLabel: UILabel
    private let messageLabel: UILabel
    private let animationDuration: TimeInterval
    private let infoImageView: UIImageView
    private let successImageView: UIImageView
    private let warningImageView: UIImageView
    private let errorImageView: UIImageView
    
    private let headerView = UIView()
    
    public init(backgroundColor: UIColor = UIColor.systemBlack.withAlphaComponent(0.2),
                hudColor: UIColor = UIColor.systemWhite,
                hudCornerRadius: CGFloat = 15,
                hudHorizontalPadding: Int = 48,
                activityIndicatorViewStyle: UIActivityIndicatorView.Style = .large,
                activityIndicatorViewColor: UIColor = .systemBlack,
                titleLabelFont: UIFont = .systemFont(ofSize: 24, weight: .medium),
                titleLabelColor: UIColor = .systemBlack,
                messageLabelFont: UIFont = .systemFont(ofSize: 14, weight: .medium),
                messageLabelColor: UIColor = .systemGray,
                animationDuration: TimeInterval = 0.25,
                infoImageViewFont: UIFont = .boldSystemFont(ofSize: 32),
                infoImageViewColor: UIColor = .systemBlue,
                successImageViewFont: UIFont = .boldSystemFont(ofSize: 32),
                successImageViewColor: UIColor = .systemGreen,
                warningImageViewFont: UIFont = .boldSystemFont(ofSize: 32),
                warningImageViewColor: UIColor = .systemOrange,
                errorImageViewFont: UIFont = .boldSystemFont(ofSize: 32),
                errorImageViewColor: UIColor = .systemRed) {
        
        self.backgroundView = UIView().setBackground(color: backgroundColor)
        self.hudView = UIView().setBackground(color: hudColor).setCorner(hudCornerRadius)
        self.hudHorizontalPadding = hudHorizontalPadding
        self.activityIndicatorView = UIActivityIndicatorView().style(activityIndicatorViewStyle).color(activityIndicatorViewColor)
        self.titleLabel = UILabel().text(color: titleLabelColor).textAlignment(.center).setMultiline().font(titleLabelFont)
        self.messageLabel = UILabel().text(color: messageLabelColor).textAlignment(.center).setMultiline().font(messageLabelFont)
        self.animationDuration = animationDuration
        self.infoImageView = UIImageView().setSystemImage("info.circle", configuration: UIImage.SymbolConfiguration(font: infoImageViewFont)).templateImageColor(infoImageViewColor)
        self.successImageView = UIImageView().setSystemImage("checkmark.circle", configuration: UIImage.SymbolConfiguration(font: successImageViewFont)).templateImageColor(successImageViewColor)
        self.warningImageView = UIImageView().setSystemImage("exclamationmark.triangle", configuration: UIImage.SymbolConfiguration(font: warningImageViewFont)).templateImageColor(warningImageViewColor)
        self.errorImageView = UIImageView().setSystemImage("xclamationmark.circle", configuration: UIImage.SymbolConfiguration(font: errorImageViewFont)).templateImageColor(errorImageViewColor)
    }
    
    public init(backgroundView: UIView = UIView().setBackground(color: UIColor.systemBlack.withAlphaComponent(0.2)),
                hudView: UIView = UIView().setBackground(color: .systemWhite).setCorner(15),
                hudHorizontalPadding: Int = 48,
                activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView().style(.large).color(.systemBlack),
                titleLabel: UILabel = UILabel().text(color: .systemBlack).textAlignment(.center).setMultiline().font(.systemFont(ofSize: 24, weight: .medium)),
                messageLabel: UILabel = UILabel().text(color: .systemGray).textAlignment(.center).setMultiline().font(.systemFont(ofSize: 14, weight: .medium)),
                animationDuration: TimeInterval = 0.25,
                infoImageView: UIImageView = UIImageView().setSystemImage("info.circle", configuration: UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 32))).templateImageColor(.systemBlue),
                successImageView: UIImageView = UIImageView().setSystemImage("checkmark.circle", configuration: UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 32))).templateImageColor(.systemGreen),
                warningImageView: UIImageView = UIImageView().setSystemImage("exclamationmark.triangle", configuration: UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 32))).templateImageColor(.systemOrange),
                errorImageView: UIImageView = UIImageView().setSystemImage("exclamationmark.circle", configuration: UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 32))).templateImageColor(.systemRed)) {
        
        self.backgroundView = backgroundView
        self.hudView = hudView
        self.hudHorizontalPadding = hudHorizontalPadding
        self.activityIndicatorView = activityIndicatorView
        self.titleLabel = titleLabel
        self.messageLabel = messageLabel
        self.animationDuration = animationDuration
        self.infoImageView = infoImageView
        self.successImageView = successImageView
        self.warningImageView = warningImageView
        self.errorImageView = errorImageView
    }
    
    public func show(withHudView: Bool = false, completion: @escaping () -> () = {}) {
        
        resetHud()
        
        activityIndicatorView.startAnimating()
        
        stack(.vertical)(
            activityIndicatorView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            infoImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            successImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            warningImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            errorImageView
        ).fillingParent().layout(in: headerView)
        
        if let window = getKeyWindow() {
            window.addSubview(backgroundView.setSize(size))
        }
        
        if withHudView {
            stack(.vertical)(
                hudView.sizing(toWidth: Length(integerLiteral: Int(size.width) - hudHorizontalPadding * 2))
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
        
        resetHud()
        
        activityIndicatorView.startAnimating()
        
        stack(.vertical)(
            activityIndicatorView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            infoImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            successImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            warningImageView
        ).fillingParent().layout(in: headerView)
        
        stack(.vertical)(
            errorImageView
        ).fillingParent().layout(in: headerView)
        
        if let window = getKeyWindow() {
            window.addSubview(backgroundView.setSize(size))
        }
        
        if withHudView {
            stack(.vertical)(
                hudView.sizing(toWidth: Length(integerLiteral: Int(size.width) - hudHorizontalPadding * 2))
            ).centeringInParent().layout(in: backgroundView)
            
            stack(.vertical, spacing: 12)(
                headerView,
                titleLabel.text(title),
                messageLabel.text(message)
            ).insetting(by: 24).fillingParent().layout(in: hudView)
            
        } else {
            stack(.vertical)(
                hudView.setBackground(color: .clear).sizing(toWidth: Length(integerLiteral: Int(size.width) - hudHorizontalPadding * 2))
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
                self.resetHud()
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
    
    public func hideWithInfoAlert(message: String, completion: @escaping () -> () = {}) {
        hide {
            Alert.showInfo(message: message)
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
    
    public func hideWithInfo(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        activityIndicatorView.isHidden = true
        infoImageView.isHidden = false
        update(title: "Info", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    public func hideWithSuccess(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        show(successImageView)
        update(title: "Success", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    public func hideWithWarning(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        show(warningImageView)
        update(title: "Warning", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    public func hideWithError(with delay: SHudDelay = .short, message: String, completion: @escaping () -> () = {}) {
        show(errorImageView)
        update(title: "Error", message: message) {
            self.hide(with: delay) {
                completion()
            }
        }
    }
    
    private func resetHud() {
        showActivityIndicator()
        clearLabels()
    }
    
    private func clearLabels() {
        titleLabel.text = ""
        messageLabel.text = ""
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        infoImageView.isHidden = true
        successImageView.isHidden = true
        warningImageView.isHidden = true
        errorImageView.isHidden = true
    }
    
    private func show(_ imageView: UIImageView) {
        activityIndicatorView.isHidden = true
        imageView.isHidden = false
    }
    
    private func getKeyWindow() -> UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return window
    }
    
}
