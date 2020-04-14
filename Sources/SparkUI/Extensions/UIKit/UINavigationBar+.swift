//
//  UINavigationBar+.swift
//  
//
//  Created by Alex Nagy on 14/04/2020.
//

import UIKit

extension UINavigationBar {
    public func setTransparent(_ transparent: Bool) {
        if transparent {
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
            isTranslucent = true
            backgroundColor = .clear
        } else {
            setBackgroundImage(nil, for: .default)
            shadowImage = nil
            backgroundColor = nil
        }
    }
}
