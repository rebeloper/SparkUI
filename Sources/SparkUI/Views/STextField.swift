//
//  STextField.swift
//  
//
//  Created by Alex Nagy on 06/03/2020.
//

import UIKit
import Layoutless

public class STextField: UIView {
    
    public var object: STextFieldBase!
    private let eyeButton = UIButton()
        .image(UIImage(systemName: "eye.slash.fill")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate))
        .size(CGSize(width: 30, height: 30))
    private var showingSecureText = Bucket(false)
    
    public var placeholder: UILabel
    
    public var actionButton: SNextButton?
    
    public init(placeholder: UILabel = UILabel(),
                placeholderInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 4, right: 0),
                sTextFieldBase: STextFieldBase = STextFieldBase(),
                isSecure: Bool = false,
                underlined: Bool = false,
                underlineSpacing: CGFloat = 6,
                actionButton: SNextButton? = nil) {
        self.placeholder = placeholder
        self.object = sTextFieldBase
        self.actionButton = actionButton
        super.init(frame: .zero)
        
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
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    fileprivate func observe() {
        eyeButton.addAction {
            self.showingSecureText.setValue.toggle()
        }
        
        showingSecureText.onNextWithFirst { (showing) in
            if showing {
                self.isSecureTextEntry(false)
                self.eyeButton
                    .image(UIImage(systemName: "eye.fill")?.withTintColor(.systemRed, renderingMode: .alwaysTemplate))
            } else {
                self.isSecureTextEntry(true)
                self.eyeButton
                    .image(UIImage(systemName: "eye.slash.fill")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate))
            }
        }
        
    }
    
}
