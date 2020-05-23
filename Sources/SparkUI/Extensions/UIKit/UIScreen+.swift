//
//  UIScreen+.swift
//  
//
//  Created by Alex Nagy on 23/05/2020.
//

import UIKit

public extension UIScreen {
    
    func size() -> CGSize {
        bounds.size
    }
    
    func width() -> CGFloat {
        bounds.width
    }
    
    func height() -> CGFloat {
        bounds.height
    }
}
