//
//  UIActivityIndicatorView+.swift
//  
//
//  Created by Alex Nagy on 30/04/2020.
//

import UIKit

extension UIActivityIndicatorView {
    
    @discardableResult
    public func color(_ color: UIColor) -> UIActivityIndicatorView {
        self.color = color
        return self
    }
    
    @discardableResult
    public func style(_ style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        self.style = style
        return self
    }
    
    @discardableResult
    public func hidesWhenStopped(_ hidesWhenStopped: Bool = true) -> UIActivityIndicatorView {
        self.hidesWhenStopped = hidesWhenStopped
        return self
    }
    
    @discardableResult
    public func start() -> UIActivityIndicatorView {
        self.startAnimating()
        return self
    }
    
    @discardableResult
    public func stop() -> UIActivityIndicatorView {
        self.stopAnimating()
        return self
    }
}
