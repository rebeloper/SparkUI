//
//  UISearchBar+.swift
//  
//
//  Created by Alex Nagy on 02/07/2020.
//

import UIKit

public extension UISearchBar {
    
    @discardableResult
    func barStyle(_ barStyle: UIBarStyle) -> UISearchBar {
        self.barStyle = barStyle
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UISearchBarDelegate?) -> UISearchBar {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func placholder(_ placholder: String?) -> UISearchBar {
        self.placeholder = placholder
        return self
    }
}
