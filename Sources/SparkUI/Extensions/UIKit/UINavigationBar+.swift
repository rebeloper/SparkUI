//
//  UINavigationBar+.swift
//  
//
//  Created by Alex Nagy on 14/04/2020.
//

import UIKit

extension UINavigationBar {
    public func transparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        backgroundColor = .clear
    }
    
    public func resetTransparency(to backgroundColor: UIColor? = nil) {
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
        self.backgroundColor = backgroundColor
    }
}
