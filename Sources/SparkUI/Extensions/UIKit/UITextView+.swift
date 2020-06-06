//
//  UITextView+.swift
//  
//
//  Created by Alex Nagy on 06/06/2020.
//

import UIKit

public extension UITextView {
    func sizeToAlwaysFitText() {
        isScrollEnabled = false
        sizeToFit()
    }
} 
