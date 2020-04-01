//
//  SAppearance.swift
//  
//
//  Created by Alex Nagy on 01/04/2020.
//

import UIKit
import ReactiveKit

public struct SAppearance {
    
    public static var mode = Property(SAppearenceMode.none)
    
    public static func observe() {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                mode.value = SAppearenceMode.dark
            } else {
                mode.value = SAppearenceMode.light
            }
        } else {
            mode.value = SAppearenceMode.preiOS13
        }
    }
    
    public static func get() -> SAppearenceMode {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return SAppearenceMode.dark
            } else {
                return SAppearenceMode.light
            }
        } else {
            return SAppearenceMode.preiOS13
        }
    }
}


