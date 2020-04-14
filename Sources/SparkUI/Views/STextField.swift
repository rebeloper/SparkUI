//
//  STextField.swift
//  
//
//  Created by Alex Nagy on 06/03/2020.
//

import UIKit
import ReactiveKit
import Bond
import Layoutless

public class STextField: UIView {
    
    public var object: STextFieldBase!
    private let eyeButton = UIButton()
        .image(UIImage(systemName: "eye.slash.fill")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate))
        .size(CGSize(width: 30, height: 30))
    private let showingSecureText = Property(false)
    
    public var placeholder: UILabel
    public var placeholderAnimation: STextFieldPlaceholderAnimation
    
    public var actionButton: SNextButton?
    
    public init(placeholder: UILabel = UILabel(),
                placeholderInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 4, right: 0),
                placeholderAnimation: STextFieldPlaceholderAnimation = .fade,
                sTextFieldBase: STextFieldBase = STextFieldBase(),
                isSecure: Bool = false,
                underlined: Bool = false,
                underlineSpacing: CGFloat = 3,
                actionButton: SNextButton? = nil) {
        self.placeholder = placeholder
        self.placeholderAnimation = placeholderAnimation
        self.object = sTextFieldBase
        self.actionButton = actionButton
        super.init(frame: .zero)
        
        self.object.delegate = self
        
        stack(.horizontal)(
            placeholder,
            Spacer()
            ).fillingParent(insets: placeholderInsets).layout(in: self)
        
        if let actionButton = self.actionButton {
            
            if isSecure {
                
                if underlined {
                    let underline = SDivider()
                    stack(.vertical)(
                        stack(.horizontal)(
                            sTextFieldBase,
                            eyeButton,
                            Spacer().setWidth(5),
                            actionButton
                        ),
                        Spacer().setHeight(underlineSpacing),
                        underline
                        ).fillingParent().layout(in: self)
                } else {
                    stack(.vertical)(
                        stack(.horizontal)(
                            sTextFieldBase,
                            eyeButton,
                            Spacer().setWidth(5),
                            actionButton
                        )
                    ).fillingParent().layout(in: self)
                }
                
                self.isSecureTextEntry(true).keyboardType(.default)
                
                observe()
                
            } else {
                
                if underlined {
                    let underline = SDivider()
                    stack(.vertical)(
                        stack(.horizontal)(
                            sTextFieldBase,
                            actionButton
                        ),
                        Spacer().setHeight(underlineSpacing),
                        underline
                        ).fillingParent().layout(in: self)
                } else {
                    stack(.vertical)(
                        stack(.horizontal)(
                            sTextFieldBase,
                            actionButton
                        )
                    ).fillingParent().layout(in: self)
                }
            }
            
        } else {
            
            if isSecure {
                
                if underlined {
                    let underline = SDivider()
                    stack(.vertical)(
                        stack(.horizontal)(
                            sTextFieldBase,
                            eyeButton,
                            Spacer().setWidth(5)
                        ),
                        Spacer().setHeight(underlineSpacing),
                        underline
                        ).fillingParent().layout(in: self)
                } else {
                    stack(.vertical)(
                        stack(.horizontal)(
                            sTextFieldBase,
                            eyeButton,
                            Spacer().setWidth(5)
                        )
                    ).fillingParent().layout(in: self)
                }
                
                self.isSecureTextEntry(true).keyboardType(.default)
                
                observe()
                
            } else {
                
                if underlined {
                    let underline = SDivider()
                    stack(.vertical)(
                        sTextFieldBase,
                        Spacer().setHeight(underlineSpacing),
                        underline
                        ).fillingParent().layout(in: self)
                } else {
                    stack(.vertical)(
                        sTextFieldBase
                    ).fillingParent().layout(in: self)
                }
            }
            
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func observe() {
        eyeButton.reactive.tap.observeNext { [weak self] in
            guard let self = self else { return }
            self.showingSecureText.value.toggle()
        }.dispose(in: bag)
        
        showingSecureText.observeNext { (showing) in
            if showing {
                self.isSecureTextEntry(false)
                self.eyeButton
                    .image(UIImage(systemName: "eye.fill")?.withTintColor(.systemRed, renderingMode: .alwaysTemplate))
            } else {
                self.isSecureTextEntry(true)
                self.eyeButton
                    .image(UIImage(systemName: "eye.slash.fill")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate))
            }
        }.dispose(in: bag)
        
    }
    
    func hidePlaceholder() {
        switch self.placeholderAnimation {
        case .fade:
            UIView.animate(withDuration: 0.25) {
                self.placeholder.alpha = 0.0
            }
        case .slideUp:
            let scaleFactor: CGFloat = 0.8
            let placeholdeLabelHalfWidth = self.placeholder.frame.width / 2
            let smallPlaceholdeLabelHalfWidth = placeholdeLabelHalfWidth * scaleFactor
            let movementOnX = placeholdeLabelHalfWidth - smallPlaceholdeLabelHalfWidth + 12
            UIView.animate(withDuration: 0.25) {
                self.placeholder.alpha = 0.6
                self.placeholder.frame.origin.y -= 24
                self.placeholder.frame.origin.x -= movementOnX
                self.placeholder.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            }
        }
    }
    
    func showPlaceholder() {
        switch self.placeholderAnimation {
        case .fade:
            UIView.animate(withDuration: 0.25) {
                self.placeholder.alpha = 1.0
            }
        case .slideUp:
            let scaleFactor: CGFloat = 0.8
            let placeholdeLabelHalfWidth = self.placeholder.frame.width / 2
            let smallPlaceholdeLabelHalfWidth = placeholdeLabelHalfWidth * scaleFactor
            let movementOnX = placeholdeLabelHalfWidth - smallPlaceholdeLabelHalfWidth + 12
            UIView.animate(withDuration: 0.25) {
                self.placeholder.alpha = 1.0
                self.placeholder.frame.origin.y += 24
                self.placeholder.frame.origin.x += movementOnX
                self.placeholder.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let hasUserInterfaceStyleChanged = previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection) else { return }
        
        if hasUserInterfaceStyleChanged {
            // TODO: if appearance changes placeholder gets stuck
        }
    }
    
}

extension STextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.hidePlaceholder()
        }
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.showPlaceholder()
        }
    }
}
