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
    
    public static func lenght(for side: SSide) -> CGFloat {
        switch side {
        case .top:
            return insets().top
        case .left:
            return insets().left
        case .bottom:
            return insets().bottom
        case .right:
            return insets().right
        }
    }
}
