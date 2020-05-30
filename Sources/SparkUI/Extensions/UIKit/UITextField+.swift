//
//  UITextField+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

public extension UITextField {
    func selectAll() {
        self.selectedTextRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
    }
    
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> UITextField {
        self.autocorrectionType = autocorrectionType
        return self
    }
    
    @discardableResult
    func userInteractionEnabled(_ isUserInteractionEnabled: Bool = true) -> UITextField {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
}

public extension UITextField {
    func subscribe(_ event: UIControl.Event = .editingChanged, interval: TimeInterval = 0.1, completion: @escaping (String?) -> ()) {
        self.throttle(event, interval: interval) { (textField: UITextField) in
            guard let text = textField.text else {
                completion(nil)
                return
            }
            completion(text)
        }
    }
}

