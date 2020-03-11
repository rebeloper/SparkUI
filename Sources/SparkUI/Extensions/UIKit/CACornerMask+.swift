//
//  CACornerMask+.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

extension CACornerMask {
    
    public func select(_ corner: SCorner) -> CACornerMask {
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
