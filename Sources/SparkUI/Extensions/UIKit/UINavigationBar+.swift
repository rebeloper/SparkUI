//
//  UINavigationBar+.swift
//  
//
//  Created by Alex Nagy on 14/04/2020.
//

import UIKit

extension UINavigationBar {
    
    public func setTransparency(to backgroundColor: UIColor?, tintColor: UIColor = .systemBlue) {
        if backgroundColor == .clear {
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
            isTranslucent = true
        } else {
            setBackgroundImage(nil, for: .default)
            shadowImage = nil
        }
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
    
    public func resetTransparencyToDefault() {
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
        backgroundColor = nil
    }
    
}
