//
//  UIActivityIndicatorView+.swift
//  
//
//  Created by Alex Nagy on 30/04/2020.
//

import UIKit

public extension UIActivityIndicatorView {
    
    @discardableResult
    func color(_ color: UIColor) -> UIActivityIndicatorView {
        self.color = color
        return self
    }
    
    @discardableResult
    func style(_ style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        self.style = style
        return self
    }
    
}
