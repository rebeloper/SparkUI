//
//  SafeArea.swift
//  
//
//  Created by Alex Nagy on 10/05/2020.
//

import UIKit
import Layoutless

public struct SafeArea {
    public static func insets() -> UIEdgeInsets {
        if let window = UIWindow().getKeyWindow() {
            return window.safeAreaInsets
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    public static func lenght(for side: SSide) -> Length {
        switch side {
        case .top:
            return Length(integerLiteral: Int(insets().top))
        case .left:
            return Length(integerLiteral: Int(insets().left))
        case .bottom:
            return Length(integerLiteral: Int(insets().bottom))
        case .right:
            return Length(integerLiteral: Int(insets().right))
        }
    }
}
