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
}
