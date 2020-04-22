//
//  UITextField+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

extension UITextField {
    public func selectAll() {
        self.selectedTextRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
    }
    
    @discardableResult
    public func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> UITextField {
        self.autocorrectionType = autocorrectionType
        return self
    }
}
