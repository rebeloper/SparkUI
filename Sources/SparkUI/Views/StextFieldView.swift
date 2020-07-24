//
//  STextFieldView.swift
//  
//
//  Created by Alex Nagy on 30/05/2020.
//

import UIKit
import Layoutless

public class STextFieldView: UIView {
    
    public var textField: UITextField?
    
    private let eyeButton = UIButton().image(UIImage(systemName: "eye.slash.fill")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate))
    private let showingSecureText = Bucket(false)
    
    public init(placeholder: String = "", text: String = "", isSecure: Bool = false, insetting: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12), height: Length = 44) {
        super.init(frame: .zero)
        textField = UITextField()
        textField?.placeholder = placeholder
        textField?.text = text
        
        guard let textField = textField else { return }
        
        if isSecure {
            self.isSecureTextEntry(true).keyboardType(.default)
            addActions()
            subscribe()
        }
        
        stack(.vertical)(
            stack(.horizontal)(
                textField.sizing(toHeight: height).insetting(by: insetting),
                Spacer().sizing(toWidth: isSecure ? 36 : 0)
            ),
            SDivider()
            ).fillingParent().layout(in: self)
        
        eyeButton
            .sizing(toHeight: isSecure ? 30 : 0)
            .centeringVerticallyInParent()
            .stickingToParentEdges(right: isSecure ? 6 : 0)
            .layout(in: self)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addActions() {
        eyeButton.addAction {
            self.showingSecureText.value.toggle()
        }
    }
    
    fileprivate func subscribe() {
        showingSecureText.subscribe(with: self) { (showing) in
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
    
    public func subscribe(_ event: UIControl.Event = .editingChanged, interval: TimeInterval = 0.1, completion: @escaping (String?) -> ()) {
        self.textField?.throttle(event, interval: interval) { (textField: UITextField) in
            guard let text = textField.text else {
                completion(nil)
                return
            }
            completion(text)
        }
    }
}
