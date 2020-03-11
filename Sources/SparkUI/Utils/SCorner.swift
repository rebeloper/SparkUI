//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

struct SCorner {
    
    public func select(_ corner: SCornerType) -> CACornerMask {
        switch corner {
        case .topLeft:
            return .layerMaxXMinYCorner
        case .topRight:
            return .layerMinXMinYCorner
        case .bottomLeft:
            return .layerMinXMaxYCorner
        case .bottomRight:
            return .layerMaxXMaxYCorner
        }
    }
}
